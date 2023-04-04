*** Settings ***
Library             REST    ssl_verify=false
Library             Collections
Library             String
Library             JSONLibrary
Resource            ../common/AuthenticationApi.resource

*** Variables ***
${response_print_in_console} =
&{cntr_res_data}
${prduct_config_file}
${BASE_API_URL}
${issuerId}
${replaced_cardReference}
${replaced_issuerCardExternalReference}

*** Keywords ***
Run IBO Retrieve card API
    [Documentation]                 /issuers/{issuerId}/cards/{cardReference}
    [Arguments]                     ${cardReference}    ${card_status}    ${panSequenceNumber}    ${issuerCardExternalReference}
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/cards/${cardReference}
    REST.Output                     response body                                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                             200
    String                          $.data.status                                                               ${card_status}
    String                          $.data.pan                                                                  ${cntr_res_data.pan}
    String                          $.data.panSequenceNumber                                                    ${panSequenceNumber}
    String                          $.data.cardIdentifier.cardReference                                         ${cardReference}
    String                          $.data.cardIdentifier.issuerCardExternalReference                           ${issuerCardExternalReference}
    String                          $.data.cardContractIdentifier.cardContractReference                         ${cntr_res_data.cardContractReference}
    String                          $.data.cardContractIdentifier.issuerCardContractExternalReference           ${cntr_res_data.issuerCardContractExternalReference}


Run IBO Retrieve card ext API
    [Documentation]                 /issuers/{issuerId}/cards/external-cards/{issuerCardExternalReference}
    [Arguments]                     ${cardReference}    ${card_status}    ${panSequenceNumber}    ${issuerCardExternalReference}
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/cards/external-cards/${issuerCardExternalReference}
    REST.Output                     response body                                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                             200
    String                          $.data.status                                                               ${card_status}
    String                          $.data.pan                                                                  ${cntr_res_data.pan}
    String                          $.data.panSequenceNumber                                                    ${panSequenceNumber}
    String                          $.data.cardIdentifier.cardReference                                         ${cardReference}
    String                          $.data.cardIdentifier.issuerCardExternalReference                           ${issuerCardExternalReference}
    String                          $.data.cardContractIdentifier.cardContractReference                         ${cntr_res_data.cardContractReference}
    String                          $.data.cardContractIdentifier.issuerCardContractExternalReference           ${cntr_res_data.issuerCardContractExternalReference}
