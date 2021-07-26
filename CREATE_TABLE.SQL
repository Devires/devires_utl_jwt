CREATE TABLE UTL_JWKS_CACHE (
    KEY_ID              VARCHAR2(1000)        NOT NULL,
    KEY_MOD             VARCHAR2(4000)        NOT NULL,
    KEY_EXP             VARCHAR2(30)          NOT NULL,
    LAST_UPDATED_AT     TIMESTAMP             NOT NULL,
    PRIMARY KEY (KEY_ID)
);