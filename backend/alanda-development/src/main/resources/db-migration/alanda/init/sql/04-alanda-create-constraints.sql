--liquibase formatted sql

--changeset fsa:init-alanda-constraints

-- ================PMC_DEPARTMENT ================
ALTER TABLE "PMC_DEPARTMENT"
    ADD UNIQUE ("IDNAME")
        USING INDEX ENABLE;


-- ================PMC_DEPARTMENT ================
ALTER TABLE "PMC_DEPARTMENT"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_USER_GROUP ================
ALTER TABLE "PMC_USER_GROUP"
    ADD CONSTRAINT "PMC_USER_GROUP_UNIQUE" UNIQUE ("REF_USER", "REF_GROUP")
        USING INDEX ENABLE;

-- ================PMC_METRIC_PROPERTY ================
ALTER TABLE "PMC_METRIC_PROPERTY"
    ADD CONSTRAINT "UNIQUE_PMC_METRIC_PROPERTY" UNIQUE ("REF_ENTITY", "KEY")
        USING INDEX ENABLE;

-- ================PMC_METRIC_PROPERTY ================
ALTER TABLE "PMC_METRIC_PROPERTY"
    ADD CONSTRAINT "PK_PMC_METRIC_PROPERTY" PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_METRIC_ENTITY ================
ALTER TABLE "PMC_METRIC_ENTITY"
    ADD CONSTRAINT "UNIQUE_PMC_METRIC_ENTITY" UNIQUE ("ENTITY_ID", "ENTITY_TYPE")
        USING INDEX ENABLE;

-- ================PMC_METRIC_ENTITY ================
ALTER TABLE "PMC_METRIC_ENTITY"
    ADD CONSTRAINT "PK_PMC_METRIC_ENTITY" PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_ROLE ================
ALTER TABLE "PMC_ROLE"
    ADD CONSTRAINT "uni_PMC_ROLE" UNIQUE ("NAME")
        USING INDEX ENABLE;

-- ================PMC_PROJECTTYPE_CARDLIST ================
ALTER TABLE "PMC_PROJECTTYPE_CARDLIST"
    ADD CONSTRAINT "uni_PMC_PT_CL" UNIQUE ("REF_PROJECTTYPE", "REF_CARDLIST")
        USING INDEX ENABLE;

-- ================PMC_PROJECTCARD ================
ALTER TABLE "PMC_PROJECTCARD"
    ADD CONSTRAINT "uni_PMC_P_CL_C" UNIQUE ("REF_PROJECT", "REF_CARDLIST", "REF_CARD")
        USING INDEX ENABLE;

-- ================PMC_PROJECTCARD ================
ALTER TABLE "PMC_PROJECTCARD"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_CARDLIST_CARD ================
ALTER TABLE "PMC_CARDLIST_CARD"
    ADD CONSTRAINT "uni_PMC_CL_C" UNIQUE ("REF_CARDLIST", "REF_CARD")
        USING INDEX ENABLE;

-- ================PMC_CARDLIST ================
ALTER TABLE "PMC_CARDLIST"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_CARD ================
ALTER TABLE "PMC_CARD"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_PHASE_DEFINITION ================
ALTER TABLE "PMC_PROJECT_PHASE_DEFINITION"
    ADD CONSTRAINT "IDNAME_PMC_PROJECTTYPE" UNIQUE ("IDNAME", "PMC_PROJECTTYPE")
        USING INDEX ENABLE;

-- ================PMC_ROLE_PERMISSION ================
ALTER TABLE "PMC_ROLE_PERMISSION"
    ADD CONSTRAINT "uni_PMC_ROLE_P" UNIQUE ("REF_ROLE", "REF_PERMISSION")
        USING INDEX ENABLE;

-- ================PMC_GROUP_PERMISSION ================
ALTER TABLE "PMC_GROUP_PERMISSION"
    ADD CONSTRAINT "uni_PMC_GROUP_P" UNIQUE ("REF_GROUP", "REF_PERMISSION")
        USING INDEX ENABLE;

-- ================PMC_USER_PERMISSION ================
ALTER TABLE "PMC_USER_PERMISSION"
    ADD CONSTRAINT "uni_PMC_USER_P" UNIQUE ("REF_USER", "REF_PERMISSION")
        USING INDEX ENABLE;

-- ================PMC_USER_ROLE ================
ALTER TABLE "PMC_USER_ROLE"
    ADD CONSTRAINT "uni_PMC_USER_R" UNIQUE ("REF_USER", "REF_ROLE")
        USING INDEX ENABLE;

-- ================PMC_GROUP_ROLE ================
ALTER TABLE "PMC_GROUP_ROLE"
    ADD CONSTRAINT "uni_PMC_GROUP_R" UNIQUE ("REF_GROUP", "REF_ROLE")
        USING INDEX ENABLE;

-- ================PMC_PERMISSION ================
ALTER TABLE "PMC_PERMISSION"
    ADD CONSTRAINT "uni_PMC_PERM" UNIQUE ("KEY")
        USING INDEX ENABLE;

-- ================PMC_PERMISSION ================
ALTER TABLE "PMC_PERMISSION"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_ROLE ================
ALTER TABLE "PMC_ROLE"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_DEPENDSON ================
ALTER TABLE "PMC_PROJECT_DEPENDSON"
    ADD CONSTRAINT "UNIQUE_CHILD_PARENT" UNIQUE ("CHILD", "PARENT")
        USING INDEX ENABLE;

-- ================PMC_PROPERTY_STORE ================
ALTER TABLE "PMC_PROPERTY_STORE"
    ADD CONSTRAINT "UNIQUE_PROPERTY_STORE" UNIQUE ("REF_PMC_PROJECT", "REF_ENTITY_ID", "REF_ENTITY_TYPE", "KEY")
        USING INDEX ENABLE;

-- ================PMC_PROPERTY_STORE ================
ALTER TABLE "PMC_PROPERTY_STORE"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECTTYPE_CHILDTYPE ================
ALTER TABLE "PMC_PROJECTTYPE_CHILDTYPE"
    ADD CONSTRAINT "INX_PMCPTCT_UC" UNIQUE ("PROJECTTYPE", "CHILDTYPE")
        USING INDEX ENABLE;

-- ================PMC_PROJECTTYPE ================
ALTER TABLE "PMC_PROJECTTYPE"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECTTYPE ================
ALTER TABLE "PMC_PROJECTTYPE"
    ADD CONSTRAINT "INX_PMCPT_IDNAME" UNIQUE ("IDNAME")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_PROCESS ================
ALTER TABLE "PMC_PROJECT_PROCESS"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_MILESTONE ================
ALTER TABLE "PMC_PROJECT_MILESTONE"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECT ================
ALTER TABLE "PMC_PROJECT"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_REPORTCONFIG ================
ALTER TABLE "PMC_REPORTCONFIG"
    ADD CONSTRAINT "UNI_REPORTCONFIG_NAME" UNIQUE ("REPORTNAME")
        USING INDEX ENABLE;

-- ================PMC_REPORTCONFIG ================
ALTER TABLE "PMC_REPORTCONFIG"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_IDCOUNTER ================
ALTER TABLE "PMC_IDCOUNTER"
    ADD PRIMARY KEY ("PREFIX")
        USING INDEX ENABLE;

-- ================PMC_MILESTONE ================
ALTER TABLE "PMC_MILESTONE"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_DOCUMENT ================
ALTER TABLE "PMC_DOCUMENT"
    ADD PRIMARY KEY ("ID")
        USING INDEX ENABLE;

-- ================PMC_DOCU_FOLDER ================
ALTER TABLE "PMC_DOCU_FOLDER"
    ADD CONSTRAINT "PMC_DOCU_FOLDER_PK" PRIMARY KEY ("ID")
        USING INDEX ENABLE;

-- ================PMC_DOCU_CONFIG_PROC_MAPPING ================
ALTER TABLE "PMC_DOCU_CONFIG_PROC_MAPPING"
    ADD CONSTRAINT "PMC_DOCU_CONFIG_PROC_MAPPI_PK" PRIMARY KEY ("ID")
        USING INDEX ENABLE;

-- ================PMC_DOCU_CONFIG_MAPPING ================
ALTER TABLE "PMC_DOCU_CONFIG_MAPPING"
    ADD CONSTRAINT "PMC_DOCU_CONFIG_MAPPING_PK" PRIMARY KEY ("ID")
        USING INDEX ENABLE;

-- ================PMC_DOCU_CONFIG ================
ALTER TABLE "PMC_DOCU_CONFIG"
    ADD CONSTRAINT "PMC_DOCU_CONFIG_PK" PRIMARY KEY ("ID")
        USING INDEX ENABLE;

-- ================CALENDAR_PARTICIPANT ================
ALTER TABLE "CALENDAR_PARTICIPANT"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================CALENDAR_ENTITY ================
ALTER TABLE "CALENDAR_ENTITY"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_GROUP ================
ALTER TABLE "PMC_GROUP"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_USER ================
ALTER TABLE "PMC_USER"
    ADD PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_PHASE ================
ALTER TABLE "PMC_PROJECT_PHASE"
    ADD CONSTRAINT "UNIQUE_PPP" UNIQUE ("PMC_PROJECT_PHASE_DEFINITION", "PMC_PROJECT")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_PHASE ================
ALTER TABLE "PMC_PROJECT_PHASE"
    ADD CONSTRAINT "PK_PPP" PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_PHASE_DEFINITION ================
ALTER TABLE "PMC_PROJECT_PHASE_DEFINITION"
    ADD CONSTRAINT "PK_PPPD" PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================REF_OBJECT_USER_GROUP_MAPPING ================
ALTER TABLE "REF_OBJECT_USER_GROUP_MAPPING"
    ADD CONSTRAINT "REF_OBJ_USER_GROUP_MAPP_PK" PRIMARY KEY ("GUID")
        USING INDEX ENABLE;

-- ================PMC_PROJECT_PHASE ================
ALTER TABLE "PMC_PROJECT_PHASE"
    ADD CONSTRAINT "FK_PPP_PPPD" FOREIGN KEY ("PMC_PROJECT_PHASE_DEFINITION")
        REFERENCES "PMC_PROJECT_PHASE_DEFINITION" ("GUID") ENABLE;

-- ================REF_CONTACT_GROUP_LINK ================
-- ToDo: resolve reference to pmc-base project problem
-- ALTER TABLE "REF_CONTACT_GROUP_LINK"
--     ADD CONSTRAINT "FK_CONGRPLNK_2_SPPLR" FOREIGN KEY ("SUPPLIER_ID")
--         REFERENCES "BA_SUPPLIER" ("GUID") ENABLE;

-- ================CALENDAR_PARTICIPANT ================
ALTER TABLE "CALENDAR_PARTICIPANT"
    ADD CONSTRAINT "FKEY_CAL_PARTICIPANT_REF" FOREIGN KEY ("CALENDAR_ID")
        REFERENCES "CALENDAR_ENTITY" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_DOCUCONFIG ================
ALTER TABLE "PMC_PROJECTTYPE_DOCUCONFIG"
    ADD CONSTRAINT "fk_PMC_DOCUCONFIG" FOREIGN KEY ("DOCUCONFIG")
        REFERENCES "PMC_DOCU_CONFIG" ("ID") ENABLE;

-- ================PMC_DOCU_CONFIG_MAPPING ================
ALTER TABLE "PMC_DOCU_CONFIG_MAPPING"
    ADD CONSTRAINT "FK_PMC_DOCU_MAPPING_CONFIG" FOREIGN KEY ("DOCU_CONFIG_ID")
        REFERENCES "PMC_DOCU_CONFIG" ("ID") ENABLE;

-- ================PMC_DOCU_CONFIG ================
ALTER TABLE "PMC_DOCU_CONFIG"
    ADD CONSTRAINT "FK_PMC_DOCU_CONFIG_FOLDER" FOREIGN KEY ("SOURCE_FOLDER_ID")
        REFERENCES "PMC_DOCU_FOLDER" ("ID") ENABLE;

-- ================PMC_DOCU_FOLDER ================
ALTER TABLE "PMC_DOCU_FOLDER"
    ADD CONSTRAINT "FK_PMC_DOCU_FOLDER_PARENT" FOREIGN KEY ("PARENT_FOLDER_ID")
        REFERENCES "PMC_DOCU_FOLDER" ("ID") ENABLE;

-- ================PMC_PROJECT_MILESTONE ================
ALTER TABLE "PMC_PROJECT_MILESTONE"
    ADD CONSTRAINT "fk_PMC_MILESTONE" FOREIGN KEY ("MILESTONE")
        REFERENCES "PMC_MILESTONE" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_MILESTONE ================
ALTER TABLE "PMC_PROJECTTYPE_MILESTONE"
    ADD CONSTRAINT "fk_PMC_TYPE_MILE" FOREIGN KEY ("MILESTONE")
        REFERENCES "PMC_MILESTONE" ("GUID") ENABLE;

-- ================PMC_PROJECT_PHASE_DEFINITION ================
ALTER TABLE "PMC_PROJECT_PHASE_DEFINITION"
    ADD CONSTRAINT "FK_PPPD_PT" FOREIGN KEY ("PMC_PROJECTTYPE")
        REFERENCES "PMC_PROJECTTYPE" ("GUID") ENABLE;

-- ================PMC_PROJECT ================
ALTER TABLE "PMC_PROJECT"
    ADD CONSTRAINT "fk_PMC_PROJECT_TYPE" FOREIGN KEY ("REF_PMCPROJECTTYPE")
        REFERENCES "PMC_PROJECTTYPE" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_CHILDTYPE ================
ALTER TABLE "PMC_PROJECTTYPE_CHILDTYPE"
    ADD CONSTRAINT "fk_PMC_CHILDTYPE" FOREIGN KEY ("CHILDTYPE")
        REFERENCES "PMC_PROJECTTYPE" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_CHILDTYPE ================
ALTER TABLE "PMC_PROJECTTYPE_CHILDTYPE"
    ADD CONSTRAINT "fk_PMC_PROJECTTYPE_CHILD" FOREIGN KEY ("PROJECTTYPE")
        REFERENCES "PMC_PROJECTTYPE" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_DOCUCONFIG ================
ALTER TABLE "PMC_PROJECTTYPE_DOCUCONFIG"
    ADD CONSTRAINT "fk_PMC_PROJECTTYPE" FOREIGN KEY ("PROJECTTYPE")
        REFERENCES "PMC_PROJECTTYPE" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_MILESTONE ================
ALTER TABLE "PMC_PROJECTTYPE_MILESTONE"
    ADD CONSTRAINT "fk_PMC_PROJECTTYPE_MILE" FOREIGN KEY ("PROJECTTYPE")
        REFERENCES "PMC_PROJECTTYPE" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_CARDLIST ================
ALTER TABLE "PMC_PROJECTTYPE_CARDLIST"
    ADD CONSTRAINT "fk_PMC_PROJECTTYPE_CL" FOREIGN KEY ("REF_PROJECTTYPE")
        REFERENCES "PMC_PROJECTTYPE" ("GUID") ENABLE;

-- ================PMC_PROJECT_PHASE ================
ALTER TABLE "PMC_PROJECT_PHASE"
    ADD CONSTRAINT "FK_PPP_PP" FOREIGN KEY ("PMC_PROJECT")
        REFERENCES "PMC_PROJECT" ("GUID") ENABLE;

-- ================PMC_PROJECT_DEPENDSON ================
ALTER TABLE "PMC_PROJECT_DEPENDSON"
    ADD CONSTRAINT "fk_PMC_DEPENDSON" FOREIGN KEY ("PARENT")
        REFERENCES "PMC_PROJECT" ("GUID") ENABLE;

-- ================PMC_PROJECT_DEPENDSON ================
ALTER TABLE "PMC_PROJECT_DEPENDSON"
    ADD CONSTRAINT "fk_PMC_PROJECT" FOREIGN KEY ("CHILD")
        REFERENCES "PMC_PROJECT" ("GUID") ENABLE;

-- ================PMC_PROJECT_MILESTONE ================
ALTER TABLE "PMC_PROJECT_MILESTONE"
    ADD CONSTRAINT "fk_PMC_PROJECT_MILE" FOREIGN KEY ("PROJECT")
        REFERENCES "PMC_PROJECT" ("GUID") ENABLE;

-- ================PMC_PROJECT_PROCESS ================
ALTER TABLE "PMC_PROJECT_PROCESS"
    ADD CONSTRAINT "fk_PMC_PROJECT_PROCESS" FOREIGN KEY ("PROJECT")
        REFERENCES "PMC_PROJECT" ("GUID") ENABLE;

-- ================PMC_PROPERTY_STORE ================
ALTER TABLE "PMC_PROPERTY_STORE"
    ADD CONSTRAINT "fk_PMC_PROPERTY_PROJECT" FOREIGN KEY ("REF_PMC_PROJECT")
        REFERENCES "PMC_PROJECT" ("GUID") ENABLE;

-- ================PMC_PROJECTCARD ================
ALTER TABLE "PMC_PROJECTCARD"
    ADD CONSTRAINT "fk_PMC_PROJECT_C" FOREIGN KEY ("REF_PROJECT")
        REFERENCES "PMC_PROJECT" ("GUID") ENABLE;

-- ================PMC_USER_ROLE ================
ALTER TABLE "PMC_USER_ROLE"
    ADD CONSTRAINT "fk_PMC_USER_R" FOREIGN KEY ("REF_USER")
        REFERENCES "PMC_USER" ("GUID") ENABLE;

-- ================PMC_USER_PERMISSION ================
ALTER TABLE "PMC_USER_PERMISSION"
    ADD CONSTRAINT "fk_PMC_USER_P" FOREIGN KEY ("REF_USER")
        REFERENCES "PMC_USER" ("GUID") ENABLE;

-- ================PMC_GROUP_ROLE ================
ALTER TABLE "PMC_GROUP_ROLE"
    ADD CONSTRAINT "fk_PMC_GROUP_R" FOREIGN KEY ("REF_GROUP")
        REFERENCES "PMC_GROUP" ("GUID") ENABLE;

-- ================PMC_GROUP_PERMISSION ================
ALTER TABLE "PMC_GROUP_PERMISSION"
    ADD CONSTRAINT "fk_PMC_GROUP_P" FOREIGN KEY ("REF_GROUP")
        REFERENCES "PMC_GROUP" ("GUID") ENABLE;

-- ================PMC_GROUP_ROLE ================
ALTER TABLE "PMC_GROUP_ROLE"
    ADD CONSTRAINT "fk_PMC_ROLE_G" FOREIGN KEY ("REF_ROLE")
        REFERENCES "PMC_ROLE" ("GUID") ENABLE;

-- ================PMC_USER_ROLE ================
ALTER TABLE "PMC_USER_ROLE"
    ADD CONSTRAINT "fk_PMC_ROLE_U" FOREIGN KEY ("REF_ROLE")
        REFERENCES "PMC_ROLE" ("GUID") ENABLE;

-- ================PMC_ROLE_PERMISSION ================
ALTER TABLE "PMC_ROLE_PERMISSION"
    ADD CONSTRAINT "fk_PMC_ROLE_P" FOREIGN KEY ("REF_ROLE")
        REFERENCES "PMC_ROLE" ("GUID") ENABLE;

-- ================PMC_USER_PERMISSION ================
ALTER TABLE "PMC_USER_PERMISSION"
    ADD CONSTRAINT "fk_PMC_PERM_U" FOREIGN KEY ("REF_PERMISSION")
        REFERENCES "PMC_PERMISSION" ("GUID") ENABLE;

-- ================PMC_GROUP_PERMISSION ================
ALTER TABLE "PMC_GROUP_PERMISSION"
    ADD CONSTRAINT "fk_PMC_PERM_G" FOREIGN KEY ("REF_PERMISSION")
        REFERENCES "PMC_PERMISSION" ("GUID") ENABLE;

-- ================PMC_ROLE_PERMISSION ================
ALTER TABLE "PMC_ROLE_PERMISSION"
    ADD CONSTRAINT "fk_PMC_PERM_R" FOREIGN KEY ("REF_PERMISSION")
        REFERENCES "PMC_PERMISSION" ("GUID") ENABLE;

-- ================PMC_CARDLIST_CARD ================
ALTER TABLE "PMC_CARDLIST_CARD"
    ADD CONSTRAINT "fk_PMC_C_CL" FOREIGN KEY ("REF_CARD")
        REFERENCES "PMC_CARD" ("GUID") ENABLE;

-- ================PMC_PROJECTCARD ================
ALTER TABLE "PMC_PROJECTCARD"
    ADD CONSTRAINT "fk_PMC_C" FOREIGN KEY ("REF_CARD")
        REFERENCES "PMC_CARD" ("GUID") ENABLE;

-- ================PMC_CARDLIST_CARD ================
ALTER TABLE "PMC_CARDLIST_CARD"
    ADD CONSTRAINT "fk_PMC_CL_C" FOREIGN KEY ("REF_CARDLIST")
        REFERENCES "PMC_CARDLIST" ("GUID") ENABLE;

-- ================PMC_PROJECTCARD ================
ALTER TABLE "PMC_PROJECTCARD"
    ADD CONSTRAINT "fk_PMC_CL" FOREIGN KEY ("REF_CARDLIST")
        REFERENCES "PMC_CARDLIST" ("GUID") ENABLE;

-- ================PMC_PROJECTTYPE_CARDLIST ================
ALTER TABLE "PMC_PROJECTTYPE_CARDLIST"
    ADD CONSTRAINT "fk_PMC_CL_PT" FOREIGN KEY ("REF_CARDLIST")
        REFERENCES "PMC_CARDLIST" ("GUID") ENABLE;

-- ================PMC_METRIC_PROPERTY ================
ALTER TABLE "PMC_METRIC_PROPERTY"
    ADD CONSTRAINT "FK_PMC_METRIC_ENTITY" FOREIGN KEY ("REF_ENTITY")
        REFERENCES "PMC_METRIC_ENTITY" ("GUID") ENABLE;

-- ================PMC_USER ================
ALTER TABLE "PMC_USER"
    ADD CONSTRAINT "FK_PMC_USER_DEPARTMENT" FOREIGN KEY ("PMC_DEPARTMENT")
        REFERENCES "PMC_DEPARTMENT" ("GUID") ENABLE;

