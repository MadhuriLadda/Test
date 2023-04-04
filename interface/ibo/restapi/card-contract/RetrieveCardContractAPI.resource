*** Settings ***
Documentation       Retrieve card contract API
# RetrieveCardContractAPI.resource
Library             REST    ssl_verify=false
Library             RequestsLibrary
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
Run IBO Retrieve card contract API
    [Documentation]                     /issuers/{issuerId}/card-contracts/{cardContractReference}
    set basic Authentication
    REST.GET                            ${BASE_API_URL}/issuers/${issuerId}/card-contracts/${cntr_res_data.cardContractReference}
    REST.Output                         response body                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                             200
    String                              $.data.cardContractIdentifier.cardContractReference         ${cntr_res_data.cardContractReference}

Run IBO Retrieve card contract ext API
    [Documentation]                     /issuers/{issuerId}/card-contracts/external-card-contracts/{issuerCardContractExternalReference}
    set basic Authentication
    REST.GET                            ${BASE_API_URL}/issuers/${issuerId}/card-contracts/external-card-contracts/${cntr_res_data.issuerCardContractExternalReference}
    REST.Output                         response body                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                             response status                                             200
    String                              $.data.cardContractIdentifier.cardContractReference         ${cntr_res_data.cardContractReference}