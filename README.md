# devires_utl_jwt
Oracle PLSQL Package for JWT handling.

Validates JWT using JWKS endpoint and RS256 signatures.

Dependencies:
- PACKAGE APEX_WEB_SERVICE
- PACKAGE AS_CRYPTO Devires (https://github.com/Devires/as_crypto)

## Usage Example

```sql
SET DEFINE OFF;

DECLARE
  P_TOKEN      VARCHAR2(4000);
  P_VALID_AUDS VARCHAR2(255);
  P_IS_VALID   BOOLEAN;
BEGIN
  
  /*
    Steps to test using Microsoft Azure AD:
    1) Set JWKS endpoint at package interface constant C_JWKS_URL (eg. https://login.microsoftonline.com/common/discovery/v2.0/keys)
    2) Generate the token (https://login.microsoftonline.com/<tenantId>/oauth2/v2.0/authorize?client_id=<appId>&nonce=defaultNonce&redirect_uri=https%3A%2F%2Fjwt.ms&scope=openid%20profile%20email%20offline_access%20user.read&response_type=token&prompt=login)
    3) Get access_token o id_token and paste bellow to test
  */
  
  -- Sample access_token or id_token to validate
  P_TOKEN := 'eyJ0eXAiOiJKV...';

  -- Optional: audiences to validate (comma separated values)
  P_VALID_AUDS := 'a0ef95a2-c876-...,00000003-0000-0000-c000-000000000000';

  DEVIRES_UTL_JWT.VALIDATE_JWT (
    P_TOKEN      => P_TOKEN,
    P_VALID_AUDS => P_VALID_AUDS,
    P_IS_VALID   => P_IS_VALID
  );

  IF NOT P_IS_VALID THEN
    DBMS_OUTPUT.PUT_LINE('INVALID TOKEN: ' || P_TOKEN);
    -- EG. SET ORDS HTTP FORBIDDEN (:status => X-ORDS-STATUS-CODE)
    -- :status := 401;
    -- :error_message := 'Invalid or expired token'
    RETURN;
  END IF;

END;
```