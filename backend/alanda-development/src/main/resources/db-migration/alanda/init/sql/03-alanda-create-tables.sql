--liquibase formatted sql

--changeset fsa:init-alanda-tables

-- ================CALENDAR_ENTITY ================
CREATE TABLE CALENDAR_ENTITY
(
    GUID          NUMBER(38)    NOT NULL,
    CREATED       DATE
                                NOT NULL,
    CREATEUSER    NUMBER(38, 0) NOT NULL,
    LASTUPDATE    DATE,
    UPDATEUSER    NUMBER(38, 0),
    VERSION       NUMBER(38, 0) NOT NULL,
    TITLE         VARCHAR2(200) NOT NULL,
    PROJECT_ID    NUMBER(38)    NOT NULL,
    SITE_IDNAME   VARCHAR2(20),
    CALENDAR_TYPE VARCHAR2(20)  NOT NULL,
    PARTNER_TYPE  VARCHAR2(20),
    START_DATE    DATE,
    END_DATE      DATE,
    ORGANIZER_ID  NUMBER(38)    NOT NULL
);

-- ================CALENDAR_PARTICIPANT ================
CREATE TABLE CALENDAR_PARTICIPANT
(
    GUID        NUMBER(38)    NOT NULL,
    CREATED     DATE
                              NOT NULL,
    CREATEUSER  NUMBER(38, 0) NOT NULL,
    LASTUPDATE  DATE,
    UPDATEUSER  NUMBER(38, 0),
    VERSION     NUMBER(38, 0) NOT NULL,
    CALENDAR_ID NUMBER(38)    NOT NULL,
    FULL_NAME   VARCHAR2(100),
    EMAIL       VARCHAR2(100),
    USER_ID     NUMBER(38)
);

-- ================EMAIL_JOB ================
CREATE TABLE EMAIL_JOB
(
    ID_           NUMBER(38, 0) NOT NULL,
    KEY_          VARCHAR2(50),
    SUBJECT_      VARCHAR2(50),
    MESSAGE_      CLOB,
    RECEIVER_     VARCHAR2(50)  NOT NULL,
    JOB_EXECUTOR_ VARCHAR2(50),
    CREATED_      DATE
);

-- ================PMC_CARD ================
CREATE TABLE PMC_CARD
(
    GUID    NUMBER(38) NOT NULL,
    TITLE   VARCHAR2(500),
    VERSION NUMBER(38) NOT NULL
);

-- ================PMC_CARDLIST ================
CREATE TABLE PMC_CARDLIST
(
    GUID    NUMBER(38) NOT NULL,
    IDNAME  VARCHAR2(255),
    VERSION NUMBER(38) NOT NULL
);

-- ================PMC_CARDLIST_CARD ================
CREATE TABLE PMC_CARDLIST_CARD
(
    REF_CARDLIST NUMBER(38, 0) NOT NULL,
    REF_CARD     NUMBER(38, 0) NOT NULL
);

-- ================PMC_DEPARTMENT ================
CREATE TABLE PMC_DEPARTMENT
(
    GUID    NUMBER(38, 0) NOT NULL,
    VERSION NUMBER(38, 0) NOT NULL,
    IDNAME  VARCHAR2(255) NOT NULL,
    NAME    VARCHAR2(400) NOT NULL
);

-- ================PMC_DOCUMENT ================
CREATE TABLE PMC_DOCUMENT
(
    ID         NUMBER(38, 0) NOT NULL,
    DIRECTORY  VARCHAR2(500),
    FILENAME   VARCHAR2(200),
    FILESIZE   NUMBER(38, 0),
    CREATED    DATE,
    CREATEUSER NUMBER(38, 0),
    LASTUPDATE DATE,
    UPDATEUSER NUMBER(38, 0),
    PROJECTID  NUMBER(38, 0)
);

-- ================PMC_DOCU_CONFIG ================
CREATE TABLE PMC_DOCU_CONFIG
(
    ID               NUMBER(10, 0) NOT NULL,
    SOURCE_FOLDER_ID NUMBER(10, 0) NOT NULL,
    WRITE_ACCESS     VARCHAR2(255),
    READ_ACCESS      VARCHAR2(255),
    TYPE             VARCHAR2(255),
    SUBTYPE          VARCHAR2(255),
    MODULE_NAME      VARCHAR2(255),
    MODULE_FOLDER    VARCHAR2(255),
    MAPPING_NAME_    VARCHAR2(255),
    DISPLAY_NAME_    VARCHAR2(255)
);

-- ================PMC_DOCU_CONFIG_MAPPING ================
CREATE TABLE PMC_DOCU_CONFIG_MAPPING
(
    ID              NUMBER(10, 0) NOT NULL,
    DOCU_CONFIG_ID  NUMBER(10, 0) NOT NULL,
    TYPE            VARCHAR2(400) NOT NULL,
    RECON_TYPE_ID   NUMBER(10, 0),
    REF_OBJECT_TYPE VARCHAR2(100)
);

-- ================PMC_DOCU_CONFIG_PROC_MAPPING ================
CREATE TABLE PMC_DOCU_CONFIG_PROC_MAPPING
(
    ID                  NUMBER(10, 0) NOT NULL,
    DOCU_CFG_MAPPING_ID NUMBER(10, 0) NOT NULL,
    PROC_DEF_KEY        VARCHAR2(100) NOT NULL
);

-- ================PMC_DOCU_FOLDER ================
CREATE TABLE PMC_DOCU_FOLDER
(
    ID               NUMBER(10, 0) NOT NULL,
    NAME             VARCHAR2(400) NOT NULL,
    PARENT_FOLDER_ID NUMBER(10, 0)
);

-- ================PMC_GROUP ================
CREATE TABLE PMC_GROUP
(
    GUID        NUMBER(38)             NOT NULL,
    GROUPNAME   VARCHAR2(50)           NOT NULL,
    LONGNAME    VARCHAR2(200),
    GROUPSOURCE VARCHAR2(100),
    CREATED     DATE,
    CREATEUSER  NUMBER(38, 0),
    LASTUPDATE  DATE,
    UPDATEUSER  NUMBER(38, 0),
    VERSION     NUMBER(38)             NOT NULL,
    SOURCEID    NUMBER(38, 0),
    SOURCENAME  VARCHAR2(200),
    ACTIVE      NUMBER(1, 0) DEFAULT 1 NOT NULL,
    EMAIL       VARCHAR2(100),
    PHONE       VARCHAR2(100)
);

-- ================PMC_GROUP_PERMISSION ================
CREATE TABLE PMC_GROUP_PERMISSION
(
    REF_GROUP      NUMBER(38, 0) NOT NULL,
    REF_PERMISSION NUMBER(38, 0) NOT NULL
);

-- ================PMC_GROUP_ROLE ================
CREATE TABLE PMC_GROUP_ROLE
(
    REF_GROUP NUMBER(38, 0) NOT NULL,
    REF_ROLE  NUMBER(38, 0) NOT NULL
);

-- ================PMC_HISTORY_LOG ================
CREATE TABLE PMC_HISTORY_LOG
(
    GUID             NUMBER(38)   NOT NULL,
    REF_OBJECTID     NUMBER(38),
    REF_OBJECTTYPE   VARCHAR2(40),
    TYPE             VARCHAR2(40),
    ACTION           VARCHAR2(40) NOT NULL,
    FIELD            VARCHAR2(1000),
    OLDVALUE         VARCHAR2(4000),
    NEWVALUE         VARCHAR2(4000),
    TEXT             VARCHAR2(4000),
    USERID           NUMBER(38)   NOT NULL,
    MODDATE          DATE
                                  NOT NULL,
    PROJECTID        VARCHAR2(255),
    REF_OBJECTIDNAME VARCHAR2(255),
    FIELDREF         VARCHAR2(255),
    USERNAME         VARCHAR2(255),
    PMC_PROJECTGUID  NUMBER(38, 0),
    LOGDATE          DATE
                                  NOT NULL,
    FIELD_NAME       VARCHAR2(200),
    FIELD_REF        VARCHAR2(200),
    FIELD_ID         VARCHAR2(200)
);

-- ================PMC_IDCOUNTER ================
CREATE TABLE PMC_IDCOUNTER
(
    PREFIX        VARCHAR2(255) NOT NULL,
    CURRENTNUMBER NUMBER(38, 0)
);

-- ================PMC_METRIC_ENTITY ================
CREATE TABLE PMC_METRIC_ENTITY
(
    GUID        NUMBER(38)    NOT NULL,
    VERSION     NUMBER(38)    NOT NULL,
    ENTITY_ID   VARCHAR2(200) NOT NULL,
    ENTITY_TYPE VARCHAR2(100) NOT NULL,
    STARTED     DATE,
    ENDED       DATE,
    DURATION    NUMBER(38)
);

-- ================PMC_METRIC_PROPERTY ================
CREATE TABLE PMC_METRIC_PROPERTY
(
    GUID       NUMBER(38)     NOT NULL,
    VERSION    NUMBER(38)     NOT NULL,
    REF_ENTITY NUMBER(38)     NOT NULL,
    KEY        VARCHAR2(200)  NOT NULL,
    VALUE      VARCHAR2(4000) NOT NULL,
    VALUE_TYPE VARCHAR2(100)  NOT NULL
);

-- ================PMC_MILESTONE ================
CREATE TABLE PMC_MILESTONE
(
    GUID        NUMBER(38) NOT NULL,
    IDNAME      VARCHAR2(255),
    DESCRIPTION VARCHAR2(1024),
    CREATED     DATE,
    CREATEUSER  NUMBER(38, 0),
    LASTUPDATE  DATE,
    UPDATEUSER  NUMBER(38, 0),
    VERSION     NUMBER(38) NOT NULL
);

-- ================PMC_PERMISSION ================
CREATE TABLE PMC_PERMISSION
(
    GUID    NUMBER(38, 0) NOT NULL,
    VERSION NUMBER(38, 0) NOT NULL,
    KEY     VARCHAR2(255) NOT NULL
);

-- ================PMC_PROJECT ================
CREATE TABLE PMC_PROJECT
(
    GUID               NUMBER(38)    NOT NULL,
    VERSION            NUMBER(38)    NOT NULL,
    PROJECTID          VARCHAR2(255) NOT NULL,
    REF_PMCPROJECTTYPE NUMBER(38, 0) NOT NULL,
    CUSTOMERPROJECT    NUMBER(38, 0),
    TAG                VARCHAR2(255),
    OWNER              NUMBER(38, 0),
    TITLE              VARCHAR2(255),
    DETAILS            VARCHAR2(4000),
    PROJECTCOMMENT     VARCHAR2(2000),
    RISK               NUMBER(38, 0),
    STATUS             VARCHAR2(255),
    DUEDATE            DATE,
    PRIORITY           NUMBER(38, 0),
    REF_OBJECTTYPE     VARCHAR2(255),
    REF_OBJECTID       NUMBER(38, 0),
    REF_OBJECTIDNAME   VARCHAR2(255),
    SUBTYPE            VARCHAR2(1024),
    CREATED            DATE,
    CREATEUSER         NUMBER(38, 0),
    LASTUPDATE         DATE,
    UPDATEUSER         NUMBER(38, 0),
    GUSTATUS           VARCHAR2(4000),
    RESULT_STATUS      VARCHAR2(255),
    RESULT_COMMENT     VARCHAR2(4000)
);

-- ================PMC_PROJECTCARD ================
CREATE TABLE PMC_PROJECTCARD
(
    GUID         NUMBER(38)    NOT NULL,
    REF_PROJECT  NUMBER(38, 0) NOT NULL,
    REF_CARDLIST NUMBER(38, 0) NOT NULL,
    REF_CARD     NUMBER(38, 0) NOT NULL,
    STATUS       VARCHAR2(255),
    COMMENTS     VARCHAR2(2048),
    CREATED      DATE,
    CREATEUSER   NUMBER(38, 0),
    LASTUPDATE   DATE,
    UPDATEUSER   NUMBER(38, 0),
    VERSION      NUMBER(38)    NOT NULL,
    CATEGORY     VARCHAR2(255),
    OWNER        VARCHAR2(255)
);

-- ================PMC_PROJECTTYPE ================
CREATE TABLE PMC_PROJECTTYPE
(
    GUID                         NUMBER(38)    NOT NULL,
    VERSION                      NUMBER(38)    NOT NULL,
    IDNAME                       VARCHAR2(255) NOT NULL,
    NAME                         VARCHAR2(255) NOT NULL,
    ALLOWEDTAGS                  VARCHAR2(1024),
    READRIGHTS                   VARCHAR2(255),
    WRITERIGHTS                  VARCHAR2(255),
    DELETERIGHTS                 VARCHAR2(255),
    ALLOWEDPROCESSES             VARCHAR2(255),
    STARTPROCESS                 VARCHAR2(255),
    OBJECTTYPE                   VARCHAR2(255),
    ROLES                        VARCHAR2(1024),
    ALLOWED_SUBTYPES             VARCHAR2(1024),
    ADDITIONAL_PROPERTIES        VARCHAR2(4000),
    CONFIGURATION                VARCHAR2(4000),
    LISTENERS                    VARCHAR2(2000),
    CREATERIGHTS                 VARCHAR2(255),
    DETAILS_TEMPLATE             VARCHAR2(1024),
    PROPERTIES_TEMPLATE          VARCHAR2(1024),
    CREATION_PROPERTIES_TEMPLATE VARCHAR2(1024)
);


-- ================PMC_PROJECTTYPE_CARDLIST ================
CREATE TABLE PMC_PROJECTTYPE_CARDLIST
(
    REF_PROJECTTYPE NUMBER(38, 0),
    REF_CARDLIST    NUMBER(38, 0)
);

-- ================PMC_PROJECTTYPE_CHILDTYPE ================
CREATE TABLE PMC_PROJECTTYPE_CHILDTYPE
(
    PROJECTTYPE NUMBER(38, 0),
    CHILDTYPE   NUMBER(38, 0)
);

-- ================PMC_PROJECTTYPE_DOCUCONFIG ================
CREATE TABLE PMC_PROJECTTYPE_DOCUCONFIG
(
    PROJECTTYPE NUMBER(38, 0),
    DOCUCONFIG  NUMBER(38, 0),
    SORTORDER   NUMBER(10, 0)
);

-- ================PMC_PROJECTTYPE_MILESTONE ================
CREATE TABLE PMC_PROJECTTYPE_MILESTONE
(
    PROJECTTYPE NUMBER(38, 0),
    MILESTONE   NUMBER(38, 0)
);

-- ================PMC_PROJECT_DEPENDSON ================
CREATE TABLE PMC_PROJECT_DEPENDSON
(
    CHILD  NUMBER(38, 0),
    PARENT NUMBER(38, 0)
);

-- ================PMC_PROJECT_MILESTONE ================
CREATE TABLE PMC_PROJECT_MILESTONE
(
    GUID       NUMBER(38) NOT NULL,
    PROJECT    NUMBER(38, 0),
    MILESTONE  NUMBER(38, 0),
    CREATED    DATE,
    CREATEUSER NUMBER(38, 0),
    LASTUPDATE DATE,
    UPDATEUSER NUMBER(38, 0),
    VERSION    NUMBER(38) NOT NULL,
    FC         DATE,
    ACT        DATE,
    BASELINE   DATE
);

-- ================PMC_PROJECT_PHASE ================
CREATE TABLE PMC_PROJECT_PHASE
(
    GUID                         NUMBER(38)             NOT NULL,
    PMC_PROJECT_PHASE_DEFINITION NUMBER(38),
    PMC_PROJECT                  NUMBER(38),
    ENABLED                      NUMBER(1, 0),
    ACTIVE                       NUMBER(1, 0)           NOT NULL,
    STARTDATE                    DATE,
    ENDDATE                      DATE,
    VERSION                      NUMBER(38)             NOT NULL,
    CREATED                      DATE,
    CREATEUSER                   NUMBER(38),
    LASTUPDATE                   DATE,
    UPDATEUSER                   NUMBER(38),
    FROZEN                       NUMBER(1, 0) DEFAULT 0 NOT NULL
);

-- ================PMC_PROJECT_PHASE_DEFINITION ================
CREATE TABLE PMC_PROJECT_PHASE_DEFINITION
(
    GUID             NUMBER(38)    NOT NULL,
    IDNAME           VARCHAR2(255) NOT NULL,
    PMC_PROJECTTYPE  NUMBER(38)    NOT NULL,
    DISPLAYNAME      VARCHAR2(255) NOT NULL,
    ALLOWEDPROCESSES VARCHAR2(4000),
    PREPARERIGHTS    VARCHAR2(1000),
    WRITERIGHTS      VARCHAR2(1000),
    VERSION          NUMBER(38)    NOT NULL
);

-- ================PMC_PROJECT_PROCESS ================
CREATE TABLE PMC_PROJECT_PROCESS
(
    GUID                NUMBER(38)           NOT NULL,
    PROJECT             NUMBER(38, 0)        NOT NULL,
    PROCESS_INSTANCE_ID VARCHAR2(255),
    STATUS              VARCHAR2(255),
    RELATION            VARCHAR2(255),
    WORK_DETAILS        VARCHAR2(4000),
    PROCESS_KEY         VARCHAR2(255),
    BUSINESS_OBJECT     VARCHAR2(255),
    LABEL               VARCHAR2(255),
    PARENT_EXECUTION_ID VARCHAR2(255),
    VERSION             NUMBER(38) DEFAULT 1 NOT NULL,
    CREATED             DATE,
    CREATEUSER          NUMBER(38),
    LASTUPDATE          DATE,
    UPDATEUSER          NUMBER(38),
    RESULT_STATUS       VARCHAR2(255),
    RESULT_COMMENT      VARCHAR2(4000)
);

-- ================PMC_PROPERTY_STORE ================
CREATE TABLE PMC_PROPERTY_STORE
(
    GUID            NUMBER(38)    NOT NULL,
    REF_PMC_PROJECT NUMBER(38),
    REF_ENTITY_ID   NUMBER(38),
    REF_ENTITY_TYPE VARCHAR2(255),
    KEY             VARCHAR2(255) NOT NULL,
    VALUE           VARCHAR2(4000),
    VALUE_TYPE      VARCHAR2(255),
    CREATED         DATE,
    CREATEUSER      NUMBER(38, 0),
    LASTUPDATE      DATE,
    UPDATEUSER      NUMBER(38, 0),
    VERSION         NUMBER(38)    NOT NULL
);

-- ================PMC_REPORTCONFIG ================
CREATE TABLE PMC_REPORTCONFIG
(
    GUID               NUMBER(38)    NOT NULL,
    VERSION            NUMBER(38)    NOT NULL,
    REPORTNAME         VARCHAR2(255) NOT NULL,
    RECIPIENTS         VARCHAR2(2000),
    SENDTIME           VARCHAR2(255),
    CONFIG             CLOB,
    SUBJECT            VARCHAR2(400),
    LINEPERPROC        NUMBER(1, 0),
    QUERYSTRING        VARCHAR2(2000),
    SEC_QUERYSTRING    VARCHAR2(2000),
    PRIMARY_POSTPROC   VARCHAR2(250),
    SECONDARY_POSTPROC VARCHAR2(250),
    TYPE               VARCHAR2(50)
);

-- ================PMC_ROLE ================
CREATE TABLE PMC_ROLE
(
    GUID    NUMBER(38, 0) NOT NULL,
    VERSION NUMBER(38, 0) NOT NULL,
    NAME    VARCHAR2(255) NOT NULL
);

-- ================PMC_ROLE_PERMISSION ================
CREATE TABLE PMC_ROLE_PERMISSION
(
    REF_ROLE       NUMBER(38, 0) NOT NULL,
    REF_PERMISSION NUMBER(38, 0) NOT NULL
);

-- ================PMC_USER ================
CREATE TABLE PMC_USER
(
    GUID           NUMBER(38)    NOT NULL,
    LOGINNAME      VARCHAR2(100) NOT NULL,
    FIRSTNAME      VARCHAR2(100),
    SURNAME        VARCHAR2(100),
    EMAIL          VARCHAR2(100),
    MOBILE         VARCHAR2(100),
    LOCKED         NUMBER(1, 0),
    CREATED        DATE,
    CREATEUSER     NUMBER(38, 0),
    LASTUPDATE     DATE,
    UPDATEUSER     NUMBER(38, 0),
    VERSION        NUMBER(38)    NOT NULL,
    PASSWORD       VARCHAR2(50),
    LAST_LOGIN     DATE,
    PMC_DEPARTMENT NUMBER(38, 0),
    EXTERNALGUID   NUMBER(38),
    SOURCE         VARCHAR2(100),
    COMPANY        VARCHAR2(100)
);

-- ================PMC_USER_GROUP ================
CREATE TABLE PMC_USER_GROUP
(
    REF_USER       NUMBER(38, 0)          NOT NULL,
    REF_GROUP      NUMBER(38, 0)          NOT NULL,
    SELECT_CONTACT NUMBER(1, 0) DEFAULT 0 NOT NULL
);

-- ================PMC_USER_PERMISSION ================
CREATE TABLE PMC_USER_PERMISSION
(
    REF_USER       NUMBER(38, 0) NOT NULL,
    REF_PERMISSION NUMBER(38, 0) NOT NULL
);

-- ================PMC_USER_ROLE ================
CREATE TABLE PMC_USER_ROLE
(
    REF_USER NUMBER(38, 0) NOT NULL,
    REF_ROLE NUMBER(38, 0) NOT NULL
);

-- ================REF_CONTACT_GROUP_LINK ================
CREATE TABLE REF_CONTACT_GROUP_LINK
(
    GUID               NUMBER(38, 0) NOT NULL,
    OSIRIS_USER_ID     NUMBER(38),
    OSIRIS_GROUP_ID    NUMBER(38),
    CANDIDATE_GROUP_ID NUMBER(38),
    SUPPLIER_ID        NUMBER(38),
    CREATED            DATE,
    CREATEUSER         NUMBER(38, 0),
    LASTUPDATE         DATE,
    UPDATEUSER         NUMBER(38, 0),
    VERSION            NUMBER(38, 0) DEFAULT (1),
    PROVID             NUMBER(38, 0)
);

-- ================REF_OBJECT_USER_GROUP_MAPPING ================
CREATE TABLE REF_OBJECT_USER_GROUP_MAPPING
(
    GUID            NUMBER(38)    NOT NULL,
    VERSION         NUMBER(38)    NOT NULL,
    REF_OBJECT_TYPE VARCHAR2(255) NOT NULL,
    REF_OBJECT_ID   NUMBER(38, 0) NOT NULL,
    ROLE_NAME       VARCHAR2(255) NOT NULL,
    USER_ID         NUMBER(38, 0),
    GROUP_ID        NUMBER(38, 0),
    CREATED         DATE,
    CREATEUSER      NUMBER(38, 0),
    LASTUPDATE      DATE,
    UPDATEUSER      NUMBER(38, 0)
);

-- ================TB_CLEANUP_HISTORY ================
CREATE TABLE TB_CLEANUP_HISTORY
(
    PROC_INST_ID_    NVARCHAR2(64) NOT NULL,
    PROC_DEF_ID_     NVARCHAR2(64),
    ACTIVITIES       NUMBER(38),
    PROCESSED        NUMBER(38),
    ACTIVITIES_AFTER NUMBER(10, 0)
);

-- ================PMC_COMMENT ================
CREATE TABLE PMC_COMMENT
(
    guid            NUMBER(38, 0) NOT NULL,
    subject         varchar(128),
    comments        varchar(128),
    task_id         varchar(128),
    proc_inst_id    varchar(128),
    reply_to        NUMBER(38, 0),
    comment_key     varchar(128),
    ref_object_type varchar(128),
    ref_object_id   varchar(128),
    created         DATE,
    createuser      NUMBER(38, 0),
    lastupdate      DATE,
    updateuser      NUMBER(38, 0),
    version         NUMBER(38, 0) NOT NULL,
    ref_pmcproject  NUMBER(38, 0),
    task_name       varchar(100),
    process_name    varchar(100)
);

