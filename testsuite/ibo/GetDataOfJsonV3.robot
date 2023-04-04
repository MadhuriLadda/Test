*** Settings ***
Library             REST    ssl_verify=false
Library             Collections
Library             String
Library             JSONLibrary
Library             BuiltIn
#Resource            ./../../configuration/ibo/andromeda/V3_EnvAndProductDetails.json
#Resource            ./../../configuration/ibo/andromeda/V3_AuthorizationType.json

*** Variables ***
${auth_mode} =          Baisc
${platfrom} =           andromeda
${issuerId} =           None
${product} =            None
@{testCaseProductDetails}
@{listOfIssuers}
# AuthenticationApi.resource


#robot -d reports ./testsuite/ibo/GetDataOfJsonV3.robot
*** Test Cases ***
TC01
    Get Product Details


#robot -d reports -t TC01 ./testsuite/ibo/GetDataOfJsonV3.robot
Demmu
     FOR    ${i}   IN RANGE    0    10
            log to console    ${i}
     END

*** Keywords ***
Get Product Details
    ${JSON_FILE}=    Load Json From File    ${CURDIR}/../../configuration/ibo/andromeda/V3_EnvAndProductDetails.json
    log list    ${listOfIssuers}
    log list    ${testCaseProductDetails}
    IF    "${platfrom}" == "andromeda"
        log to console     ==========> RUNING JOBS in ${platfrom} PLATFORM
        IF    "${issuerId}" == "None"
              ${getALLIssusrs}          get value from json     ${JSON_FILE}            $.platforms.andromeda
              ${numberOFIssuers}        get length              @{getALLIssusrs}
              FOR    ${i}   IN RANGE    0    ${numberOFIssuers}
                     ${getIssuerID}             get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].issuerId
                     ${getIssuerName}           get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].issuerName
                     ${getALLProducts}          get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].listOfProductsInIssuer
                     ${numberOFProducts}        get length              @{getALLProducts}
                     FOR    ${j}    IN RANGE    0     ${numberOFProducts}
                            ${getProductName}      get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].listOfProductsInIssuer[${j}].product
                            log to console         ${getIssuerID[0]}.${getProductName[0]}
                            log to console         ${getIssuerName[0]}.${getProductName[0]}
                            APPEND TO LIST         ${listOfIssuers}                                 ${getIssuerName[0]}
                            APPEND TO LIST         ${testCaseProductDetails}                        ${getProductName[0]}
                     END
              END
        ELSE IF    "${issuerId}" != "None"
              ${getALLIssusrs}          get value from json     ${JSON_FILE}            $.platforms.andromeda
              ${numberOFIssuers}        get length              @{getALLIssusrs}
              FOR    ${i}   IN RANGE    0    ${numberOFIssuers}
                     ${getIssuerID}             get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].issuerId
                     ${getIssuerName}           get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].issuerName
                     IF     "${getIssuerID[0]}" == "${issuerId}"
                            ${getALLProducts}         get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].listOfProductsInIssuer
                            ${numberOFProducts}       get length              @{getALLProducts}
                            FOR    ${j}    IN RANGE    0     ${numberOFProducts}
                                    ${getProductName}      get value from json     ${JSON_FILE}            $.platforms.andromeda[${i}].listOfProductsInIssuer[${j}].product
                                    log to console         ${getIssuerID[0]}.${getProductName[0]}
                                    APPEND TO LIST         ${listOfIssuers}                                 ${getIssuerName[0]}
                                    APPEND TO LIST         ${testCaseProductDetails}                        ${getProductName[0]}
                            END
                     END
              END
        END
    ELSE IF    "${platfrom}" == "sandbox"
        log to console     ==========> RUNING JOBS in ${platfrom} PLATFORM
        IF    "${issuerId}" == "None"
              ${getALLIssusrs}          get value from json     ${JSON_FILE}            $.platforms.sandbox
              ${numberOFIssuers}        get length              @{getALLIssusrs}
              FOR    ${i}   IN RANGE    0    ${numberOFIssuers}
                     ${getIssuerID}             get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].issuerId
                     ${getIssuerName}           get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].issuerName
                     ${getALLProducts}          get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].listOfProductsInIssuer
                     ${numberOFProducts}        get length              @{getALLProducts}
                     FOR    ${j}    IN RANGE    0     ${numberOFProducts}
                            ${getProductName}      get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].listOfProductsInIssuer[${j}].product
                            log to console    ${getIssuerID[0]}.${getProductName[0]}
                            APPEND TO LIST         ${listOfIssuers}                                 ${getIssuerName[0]}
                            APPEND TO LIST         ${testCaseProductDetails}                        ${getProductName[0]}
                     END
              END
        ELSE IF    "${issuerId}" != "None"
              ${getALLIssusrs}          get value from json     ${JSON_FILE}            $.platforms.sandbox
              ${numberOFIssuers}        get length              @{getALLIssusrs}
              FOR    ${i}   IN RANGE    0    ${numberOFIssuers}
                     ${getIssuerID}             get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].issuerId
                     ${getIssuerName}           get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].issuerName
                     IF     "${getIssuerID[0]}" == "${issuerId}"
                            ${getALLProducts}         get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].listOfProductsInIssuer
                            ${numberOFProducts}       get length              @{getALLProducts}
                            FOR    ${j}    IN RANGE    0     ${numberOFProducts}
                                    ${getProductName}      get value from json     ${JSON_FILE}            $.platforms.sandbox[${i}].listOfProductsInIssuer[${j}].product
                                    log to console    ${getIssuerID[0]}.${getProductName[0]}
                                    APPEND TO LIST         ${listOfIssuers}                                 ${getIssuerName[0]}
                                    APPEND TO LIST         ${testCaseProductDetails}                        ${getProductName[0]}
                            END
                     END
              END
        END
    ELSE
        log     JOBS Yet To Configure for ${platfrom} PLATFORM
    END
    log list    ${listOfIssuers}
    log list    ${testCaseProductDetails}





