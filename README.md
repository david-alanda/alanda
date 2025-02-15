# Welcome to alanda !

A framework for developing processes the easy way.

# License 
Except where otherwise specified, source code in this repository is  licensed under
the CDDL license.
See LICENSE.txt for details.
Refert to ATTRIBUTIONS.txt for the license of external components distributed with this projet.  

# Building alanda from source

### Requirements :
* docker
* docker-compose 1.*
* maven > 3.0
* nodejs, at least 8.10
* npm 5.6.0
* Oracle Database 11g Express Edition Release 11.2.0

### Note:

The commands in the following guide assume you call them from the alanda root folder after cloning the repository.
You may need to change some path values if you change to a different folder!

## Build the backend
Use the top level pom.xml to build the backend part:

    mvn -DskipTests -Dcobertura.skip=true --file backend/pom.xml clean install


## Local Deployment
To save you the burden of setting up Wildfly and Elastic search for alanda, we have two ready to use
docker-compose YAML files to start the two beasts.

    # your containers will run in this subnet
    docker network create --driver=bridge --subnet=10.100.0.0/16 --gateway=10.100.0.254 alanda_bpma_bridge

    docker-compose --file backend/alanda-development/src/test/resources/docker-compose.yml up --build

Camunda/Wildfly and Elasticsearch should be available on ports 8080 and 9206 respectively.

    nmap -p 8080,9206 localhost
    8080/tcp open  http-proxy
    9206/tcp open  wap-vcard-s


## Database initialization

### Oracle

#### Create an alanda user in the oracle database

As oracle **system** or **sys** user:

    create user alanda identified by alanda;
    grant connect,resource, create any view to alanda;

As oracle sys user you can also *optionally* grant access to the v_$parameter view. This will silence the warning `
liquibase: Could not set check compatibility mode on OracleDatabase, assuming not running in any sort of compatibility mode: Cannot read from v$parameter: ORA-00942: table or view does not exist`
when creating the database tables.

    grant select on v_$parameter to alanda;

Test that you can login with:

    sqlplus alanda/alanda@XE
    SQL> -- hello oracle

#### Create the default schema for alanda, overwriting any previous alanda schema
Copy the default database migration configuration and edit to match your oracle and filesystem setup:

    cp backend/alanda-development/src/main/resources/db-migration/db-migration-default.properties backend/alanda-development/src/main/resources/db-migration/db-migration.properties
    editor ./backend/alanda-development/src/main/resources/db-migration/db-migration.properties

Now using you can create the default tables that alanda needs. Either run the main Method of the java class from your IDE, and enter the 'init' command at the prompt:

    ./backend/alanda-development/src/main/java/io/alanda/development/dbtools/alandaDatabaseMigration.java

or via the command line:

    mvn --file ./backend/alanda-development clean install

    mvn --file ./backend/alanda-development  exec:java -Dexec.classpathScope="test" \
    -Dexec.mainClass="io.alanda.development.dbtools.AlandaDatabaseMigration" \
    -Dexec.cleanupDaemonThreads=false \
    -Dexec.args="init"

### Elastic Search

Once the elastic docker container is up, create the indices for Alanda:

    curl -XPUT -H "Content-Type: application/json" --data @backend/alanda-camunda-es-history-plugin/src/main/resources/mapping/index-schema.json http://localhost:9206/alanda-process    
    
    curl -XPUT -H "Content-Type: application/json" --data @backend/alanda-camunda-es-history-plugin/src/main/resources/mapping/index-task.json http://localhost:9206/alanda-task

Then create the aliases for the indices:

    curl -XPOST -H "Content-Type: application/json" 'http://localhost:9206/_aliases' -d '
    {
        "actions" : [
            { "add" : { "index" : "alanda-task", "alias" : "pmc-task" } }
        ]
    }'

    curl -XPOST -H "Content-Type: application/json" 'http://localhost:9206/_aliases' -d '
    {
        "actions" : [
            { "add" : { "index" : "alanda-process", "alias" : "pmc" } }
        ]
    }'


## Deploying the backend

Copy the two wars in the wildfly deployment directory

    cp backend/alanda-rest/target/alanda-rest.war backend/alanda-development/src/test/resources/docker-camunda/mount_deployment
    cp backend/alanda-background/target/alanda-background.war backend/alanda-development/src/test/resources/docker-camunda/mount_deployment


## Building and running the frontend
For the front end, we ship a npm pacakge.json which that you can use to build and serve the angular files

    cd frontend/alanda-libraries
    npm install
    npm start

## Create an admin user to login

     Insert into PMC_GROUP (GUID,GROUPNAME,LONGNAME,GROUPSOURCE,CREATED,CREATEUSER,LASTUPDATE,UPDATEUSER,VERSION,SOURCEID,SOURCENAME,ACTIVE,EMAIL,PHONE) values (1,'admin','Administrators','alanda',null,null,null,null,0,null,null,1,null,null);
     Insert into PMC_USER (GUID,LOGINNAME,FIRSTNAME,SURNAME,EMAIL,MOBILE,LOCKED,CREATED,CREATEUSER,LASTUPDATE,UPDATEUSER,VERSION,PASSWORD,LAST_LOGIN,PMC_DEPARTMENT,EXTERNALGUID,SOURCE,COMPANY) values (1,'alanda','Alan','Da','alanda@alanda.io',null,0,null,null,null,null,0,null,null,null,null,'alanda',null);
     Insert into PMC_USER_GROUP (REF_USER,REF_GROUP,SELECT_CONTACT) values (1,1,1);

Now you can login as 'alanda' without password.

If you managed so far on your own, congratulation, and enjoy !
