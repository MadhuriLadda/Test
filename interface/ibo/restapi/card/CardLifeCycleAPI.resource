*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             String
Library             JSONLibrary
Resource            ../common/AuthenticationApi.resource
Resource            ../../../../libraries/RandomDataGeneration.resource

*** Variables ***
${response_print_in_console} =
&{cntr_res_data}
${prduct_config_file}
${BASE_API_URL}
${issuerId}

*** Keywords ***
Run IBO Activate a card API
    [Documentation]                 /issuers/{issuerId}/cards/{cardReference}/activate
    set basic Authentication
    ${JSON_FILE}=                   Activate card Json Data
    REST.POST                       ${BASE_API_URL}/issuers/${issuerId}/cards/${cntr_res_data.cardReference}/activate               body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   ACTIVE
    String                          $.data.reason                                                                                   CARD_CREATION


Run IBO Block a card API
    [Documentation]                 /issuers/{issuerId}/cards/{cardReference}/block
    set basic Authentication
    ${JSON_FILE}=                   Block card Json Data
    REST.POST                       ${BASE_API_URL}/issuers/${issuerId}/cards/${cntr_res_data.cardReference}/block                  body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   BLOCKED


Run IBO UnBlock a card API
    [Documentation]                 /issuers/{issuerId}/cards/{cardReference}/unblock
    set basic Authentication
    ${JSON_FILE}=                   Unblock card Json Data
    REST.POST                       ${BASE_API_URL}/issuers/${issuerId}/cards/${cntr_res_data.cardReference}/unblock                body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   ACTIVE


Run IBO Deactivate a card API
    [Documentation]                 /issuers/{issuerId}/cards/{cardReference}/deactivate
    set basic Authentication
    ${JSON_FILE}=                   Deactivate card Json Data
    REST.POST                       ${BASE_API_URL}/issuers/${issuerId}/cards/${cntr_res_data.cardReference}/deactivate             body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   DEACTIVATED




Run IBO Activate a card ext API
    [Documentation]                 /issuers/{issuerId}/cards/external-cards/{issuerCardExternalReference}/activate
    set basic Authentication
    ${JSON_FILE}=                   Activate card Json Data
    REST.POST
    ...     ${BASE_API_URL}/issuers/${issuerId}/cards/external-cards/${cntr_res_data.issuerCardExternalReference}/activate          body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   ACTIVE
    String                          $.data.reason                                                                                   CARD_CREATION


Run IBO Block a card ext API
    [Documentation]                 /issuers/{issuerId}/cards/external-cards/{issuerCardExternalReference}/block
    set basic Authentication
    ${JSON_FILE}=                   Block card Json Data
    REST.POST
    ...     ${BASE_API_URL}/issuers/${issuerId}/cards/external-cards/${cntr_res_data.issuerCardExternalReference}/block             body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   BLOCKED



Run IBO UnBlock a card ext API
    [Documentation]                 /issuers/{issuerId}/cards/external-cards/{issuerCardExternalReference}/unblock
    set basic Authentication
    ${JSON_FILE}=                   Unblock card Json Data
    REST.POST
    ...     ${BASE_API_URL}/issuers/${issuerId}/cards/external-cards/${cntr_res_data.issuerCardExternalReference}/unblock           body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   ACTIVE



Run IBO Deactivate a card ext API
    [Documentation]                 /issuers/{issuerId}/cards/external-cards/{issuerCardExternalReference}/deactivate
    set basic Authentication
    ${JSON_FILE}=                   Deactivate card Json Data
    REST.POST
    ...     ${BASE_API_URL}/issuers/${issuerId}/cards/external-cards/${cntr_res_data.issuerCardExternalReference}/deactivate        body=${JSON_FILE}
    REST.Output                     response body                                                                                   also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                                                 200
    String                          $.data.status                                                                                   DEACTIVATED





Block card Data Preparation
    Generate Street Name
    Generate ParisCurrentTime


Activate card Json Data with 2.7.X
    [Documentation]   Basic Template to Activate a card
    ${JSON_FILE}=               Load Json From File                 ${CURDIR}/../../../../resources/ibo/restapi/templates/card/Activate_card.json
    ${JSON_FILE}=               update value to json                ${JSON_FILE}                                                                    $.activationReasonCode              CARD_CREATION
    [Return]                    ${JSON_FILE}


Activate card Json Data
    [Documentation]   Basic Template to Activate a card
    ${JSON_FILE}=               Load Json From File                 ${CURDIR}/../../../../resources/ibo/restapi/templates/card/Activate_card.json
    ${JSON_FILE}=               update value to json                ${JSON_FILE}                                                                    $.activationReasonCode              CARD_CREATION
    [Return]                    ${JSON_FILE}


Block card Json Data
    [Documentation]   Basic Template to Block a card
    Block card Data Preparation
    ${JSON_FILE}=               Load Json From File                 ${CURDIR}/../../../../resources/ibo/restapi/templates/card/Block_card.json
    IF    '${issuerId}' == '6500'
            ${JSON_FILE}=       update value to json                ${JSON_FILE}                                                                    $.blockingReason                    SHIPPING_BLOCK
    ELSE
            ${JSON_FILE}=       update value to json                ${JSON_FILE}                                                                    $.blockingReason                    LOST
    END
    ${JSON_FILE}=               update value to json                ${JSON_FILE}                                                                    $.lostStolenDate                    ${PARIS_CURRENT_DATE_TIME}
    ${JSON_FILE}=               update value to json                ${JSON_FILE}                                                                    $.lossPlace                         paris ${STREET_NAME}
    [Return]                    ${JSON_FILE}


Unblock card Json Data
    [Documentation]   Basic Template to Unblock a card
    ${JSON_FILE}=               Load Json From File                 ${CURDIR}/../../../../resources/ibo/restapi/templates/card/UnBlock_card.json
    [Return]                    ${JSON_FILE}


Deactivate card Json Data
    [Documentation]   Basic Template to DeActivate a card
    ${JSON_FILE}=               Load Json From File                 ${CURDIR}/../../../../resources/ibo/restapi/templates/card/DeActivate_card.json
    ${JSON_FILE}=               update value to json                ${JSON_FILE}                                                                    $.reason                            DEACT_CTRT_CLOSING
    [Return]                    ${JSON_FILE}