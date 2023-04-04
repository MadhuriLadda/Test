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


*** Keywords ***
Run IBO List contracts for contract owner API
    [Documentation]                 /issuers/{issuerId}/customers/{customerReference}/contracts
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/customers/${cntr_res_data.customerReference}/contracts
    REST.Output                     response body                                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                             200
    String                          $.data[0].contractIdentifier.contractReference                              ${cntr_res_data.contractReference}
    String                          $.data[0].contractIdentifier.issuerContractExternalReference                ${cntr_res_data.issuerContractExternalReference}
    String                          $.data[0].rootAccountIdentifier.accountReference                            ${cntr_res_data.root_accountReference}
    String                          $.data[0].rootAccountIdentifier.issuerAccountExternalReference              ${cntr_res_data.root_issuerAccountExternalReference}
    String                          $.data[0].status                                                            SIGNED
