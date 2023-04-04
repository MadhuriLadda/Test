*** Settings ***
Documentation       Retrieve card contract API
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
Run IBO Retrieve card contract for a card API
    [Documentation]                     /issuers/{issuerId}/cards/{cardReference}/card-contract
    set basic Authentication
    REST.GET                            ${BASE_API_URL}/issuers/${issuerId}/cards/${cntr_res_data.cardReference}/card-contract
    REST.Output                         response body                                                           also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                                         200
    String                              $.data.cardContractIdentifier.cardContractReference                     ${cntr_res_data.cardContractReference}
    String                              $.data.cardContractIdentifier.issuerCardContractExternalReference       ${cntr_res_data.issuerCardContractExternalReference}


Run IBO Retrieve card contract for a card ext API
    [Documentation]                     /issuers/{issuerId}/cards/external-cards/{issuerCardExternalReference}/card-contract
    set basic Authentication
    REST.GET                            ${BASE_API_URL}/issuers/${issuerId}/cards/external-cards/${cntr_res_data.issuerCardExternalReference}/card-contract
    REST.Output                         response body                                                           also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                                         200
    String                              $.data.cardContractIdentifier.cardContractReference                     ${cntr_res_data.cardContractReference}
    String                              $.data.cardContractIdentifier.issuerCardContractExternalReference       ${cntr_res_data.issuerCardContractExternalReference}