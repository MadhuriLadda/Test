*** Settings ***
Library             REST    ssl_verify=false
Library             Collections
Library             String
Library             JSONLibrary
Resource            ../common/AuthenticationApi.resource

*** Variables ***
${response_print_in_console} =
${BASE_API_URL}
&{cntr_res_data}
${prduct_config_file}
${issuerId}

*** Keywords ***
Run IBO Retrieve card by cardNumber and sequenceNumber and expiryDate API
    [Documentation]                     /issuers/{issuerId}/cards/search
    [Arguments]                         ${serachType}
    set basic Authentication
    IF    '${serachType}' == 'sequenceNumber'
            REST.POST                   ${BASE_API_URL}/issuers/${issuerId}/cards/search                        {"pan":"${cntr_res_data.pan}","expiryDate":"${cntr_res_data.expiryDate}","panSequenceNumber":"1"}
    ELSE
            REST.POST                   ${BASE_API_URL}/issuers/${issuerId}/cards/search                        {"pan":"${cntr_res_data.pan}","expiryDate":"${cntr_res_data.expiryDate}"}
    END

    REST.Output                         response body                                                           also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                                         200
    String                              $.data[0].cardIdentifier.cardReference                                  ${cntr_res_data.cardReference}
    String                              $.data[0].cardIdentifier.issuerCardExternalReference                    ${cntr_res_data.issuerCardExternalReference}
    String                              $.data[0].pan                                                           ${cntr_res_data.pan}
    String                              $.data[0].expiryDate                                                    ${cntr_res_data.expiryDate}
    String                              $.data[0].panSequenceNumber                                             1
    String                              $.data[0].status                                                        ${cntr_res_data.cardStatus}
    String                              $.data[0].cardContractIdentifier.cardContractReference                  ${cntr_res_data.cardContractReference}
    String                              $.data[0].cardContractIdentifier.issuerCardContractExternalReference    ${cntr_res_data.issuerCardContractExternalReference}
