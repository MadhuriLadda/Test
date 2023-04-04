*** Settings ***
Library             REST    ssl_verify=false
Library             Collections
Library             String
Library             JSONLibrary
Library             BuiltIn
#Resource            ./../../configuration/ibo/andromeda/V2_EnvAndProductDetails.json
#Resource            ./../../configuration/ibo/andromeda/V2_AuthorizationType.json

*** Variables ***
${auth_mode} =          Baisc
${platfrom} =           andromeda
${issuerId} =           6500
${product} =            None
# AuthenticationApi.resource


#robot -d reports ./testsuite/ibo/GetDataOfJsonV2.robot
*** Test Cases ***
Test All Data
    Get Product Details



*** Keywords ***
Get Product Details
      ${JSON_FILE}=    Load Json From File    ${CURDIR}/../../configuration/ibo/andromeda/V2_EnvAndProductDetails.json
      IF    "${platfrom}" == "andromeda"
            log to console    we are in Andromeda platfrom
            IF   "${issuerId}" == "None"
                log to console    started API for All Issuers
                ${data}                 get value from json             ${JSON_FILE}                $.platforms.andromeda
                ${numberOFIssuers}      get length                      @{data}
                ${x}=                   Set Variable                    ${0}
                WHILE    ${x} < ${numberOFIssuers}
                    ${get_issuerID}     get value from json             ${JSON_FILE}                $.platforms.andromeda[${x}].issuerId
                    ${get_productRef}   get value from json             ${JSON_FILE}                $.platforms.andromeda[${x}].product
                    log to console      ${get_issuerID}
                    log to console      ${get_productRef}
                    ${x}=               Evaluate                        ${x} + 1
                END
            ELSE IF    "${issuerId}" != "None"
                log to console    started API for ${issuerId} Issuers
                ${data}                 get value from json             ${JSON_FILE}                $.platforms.andromeda
                ${numberOFIssuers}      get length                      @{data}
                ${x}=                   Set Variable                    ${0}
                WHILE    ${x} < ${numberOFIssuers}
                    log to console      we are in elseIF>while>
                    ${check_issuerID}   get value from json             ${JSON_FILE}                $.platforms.andromeda[${x}].issuerId
                    IF                  "${check_issuerID}" != "${issuerId}"
                                        log to console      we are in elseIF>while>if
                                        ${get_issuerID}     get value from json             ${JSON_FILE}                $.platforms.andromeda[${x}].issuerId
                                        ${get_productRef}   get value from json             ${JSON_FILE}                $.platforms.andromeda[${x}].product
                                        log to console      ${get_issuerID}
                                        log to console      ${get_productRef}
                    END
                    log to console      we re in out side if
                    ${x}=               Evaluate                        ${x} + 1
                END
            ELSE
                log to console    please check configuration
            END
      ELSE IF    "${platfrom}" == "sandbox"
            log to console    we are in Sandbox platfrom
      ELSE
            log to console    ${platfrom} configuration not set, please check with Team
      END


