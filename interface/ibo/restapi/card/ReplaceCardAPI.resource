*** Settings ***
Library             REST    ssl_verify=false
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
Run IBO Replace a card API
    [Documentation]                     /issuers/{issuerId}/cards/{cardReference}/replace
    set basic Authentication
    ${JSON_FILE}=                       Replace card Json Data
    REST.POST                           ${BASE_API_URL}/issuers/${issuerId}/cards/${cntr_res_data.cardReference}/replace               body=${JSON_FILE}
    REST.Output                         response body                                                                                  also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                                                                200
    ${response}                         REST.Output                                                                                    response body                                            also_console=False
    IF                                  '${cntr_res_data.cardStatus}' == 'CREATED'
           String                       $.data.card.status                                                                             CREATED
    ELSE
           String                       $.data.card.status                                                                             ACTIVE
    END
    String                              $.data.card.panSequenceNumber                                                                  2
    String                              $.data.card.orders[0].orderType                                                                CardOrder
    String                              $.data.replacementReason                                                                       CARD_MALFUNCTION
    ${test_replaced_cardReference}=     get value from json                                                                            ${response}                                              $.data.card.cardIdentifier.cardReference
    set global variable                 ${replaced_cardReference}                                                                      ${test_replaced_cardReference[0]}
    ${test_replaced_is_crt_ext_ref}=    get value from json                                                                            ${response}                                              $.data.card.cardIdentifier.issuerCardExternalReference
    set global variable                 ${replaced_issuerCardExternalReference}                                                        ${test_replaced_is_crt_ext_ref[0]}
    ${test_replaced_card_status}=       get value from json                                                                            ${response}                                              $.data.card.status
    set global variable                 ${replaced_card_status}                                                                        ${test_replaced_card_status[0]}


Run IBO Replace a card ext API
    [Documentation]                     /issuers/{issuerId}/cards/external-cards/{issuerCardExternalReference}/replace
    set basic Authentication
    ${JSON_FILE}=                       Replace card Json Data
    REST.POST
    ...                                 ${BASE_API_URL}/issuers/${issuerId}/cards/external-cards/${cntr_res_data.issuerCardExternalReference}/replace
    ...                                 body=${JSON_FILE}
    REST.Output                         response body                                                                                  also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                                                                200
    ${response}                         REST.Output                                                                                    response body                                            also_console=False
    IF                                  '${cntr_res_data.cardStatus}' == 'CREATED'
           String                       $.data.card.status                                                                             CREATED
    ELSE
           String                       $.data.card.status                                                                             ACTIVE
    END
    String                              $.data.card.panSequenceNumber                                                                  2
    String                              $.data.card.orders[0].orderType                                                                CardOrder
    String                              $.data.replacementReason                                                                       CARD_MALFUNCTION
    ${test_replaced_cardReference}      get value from json                                                                            ${response}                                              $.data.card.cardIdentifier.cardReference
    set global variable                 ${replaced_cardReference}                                                                      ${test_replaced_cardReference[0]}
    ${test_replaced_is_crt_ext_ref}=    get value from json                                                                            ${response}                                              $.data.card.cardIdentifier.issuerCardExternalReference
    set global variable                 ${replaced_issuerCardExternalReference}                                                        ${test_replaced_is_crt_ext_ref[0]}
    ${test_replaced_card_status}=       get value from json                                                                            ${response}                                              $.data.card.status
    set global variable                 ${replaced_card_status}                                                                        ${test_replaced_card_status[0]}



Replace card Json Data
    [Documentation]   Basic Template to Replace a card
    ${JSON_FILE}=                       Load Json From File                                                                            ${CURDIR}/../../../../resources/ibo/restapi/templates/card/Replace_card.json
    ${JSON_FILE}=                       update value to json                                                                           ${JSON_FILE}                                             $.replacementReason                                                 CARD_MALFUNCTION
    ${JSON_FILE}=                       update value to json                                                                           ${JSON_FILE}                                             $.cardContract.card.issuerCardExternalReference                     RE_CARD_EXT_REF_${unique_number}
    [Return]                            ${JSON_FILE}