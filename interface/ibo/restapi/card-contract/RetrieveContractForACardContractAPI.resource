*** Settings ***
Documentation       Retrieve card contract API
# RetrieveCardContractAPI.resource
Library             REST    ssl_verify=false
Library             RequestsLibrary
Library             Collections
Library             String
Library             JSONLibrary
Resource            ../common/AuthenticationApi.resource
Resource            ../../../../libraries/RandomDataGeneration.resource

*** Variables ***
${response_print_in_console} =
${BASE_API_URL}
&{cntr_res_data}
${prduct_config_file}
${issuerId}

*** Keywords ***
Run IBO Retrieve contract for a card contract API
    [Documentation]    /issuers/{issuerId}/card-contracts/{cardContractReference}/contract
    set basic Authentication
    REST.GET                            ${BASE_API_URL}/issuers/${issuerId}/card-contracts/${cntr_res_data.cardContractReference}/cardholder
    REST.Output                         response body                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                             200
    String                              $.data.customerIdentifier.customerReference                 ${cntr_res_data.customerReference}
    String                              $.data.firstName                                            ${first_name}

Run IBO Retrieve contract for a card contract ext API
    [Documentation]    /issuers/{issuerId}/card-contracts/external-card-contracts/{issuerCardContractExternalReference}/contract
    set basic Authentication
    REST.GET                            ${BASE_API_URL}/issuers/${issuerId}/card-contracts/external-card-contracts/${cntr_res_data.issuerCardContractExternalReference}/cardholder
    REST.Output                         response body                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                             200
    String                              $.data.customerIdentifier.customerReference                 ${cntr_res_data.customerReference}
    String                              $.data.firstName                                            ${first_name}