*** Settings ***
Documentation       Retrieve contract API
# RetrieveContractAPI.resource
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

Run IBO Retrieve contract API
    [Documentation]                 /issuers/{issuerId}/contracts/{contractReference}
    [Arguments]                     ${contract_status}
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/contracts/${cntr_res_data.contractReference}
    REST.Output                     response body                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                             200
    String                          $.data.status                                               ${contract_status}
    String                          $.data.rootAccountIdentifier.accountReference               ${cntr_res_data.root_accountReference}


Run IBO Retrieve contract ext API
    [Documentation]                 /issuers/{issuerId}/contracts/external-contracts/{issuerContractExternalReference}
    [Arguments]                     ${contract_status}
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/contracts/external-contracts/${cntr_res_data.issuerContractExternalReference}
    REST.Output                     response body                                               also_console=${response_print_in_console}
     # ******** Verification *******
    Integer                         response status                                             200
    String                          $.data.status                                               ${contract_status}
    String                          $.data.rootAccountIdentifier.accountReference               ${cntr_res_data.root_accountReference}