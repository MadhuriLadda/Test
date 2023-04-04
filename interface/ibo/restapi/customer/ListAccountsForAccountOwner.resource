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
Run IBO List accounts for account owner API
    [Documentation]                 /issuers/{issuerId}/customers/{customerReference}/accounts
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/customers/${cntr_res_data.customerReference}/accounts
    REST.Output                     response body                                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                             200
    String                          $.data[0].rootAccountIdentifier.accountReference                            ${cntr_res_data.root_accountReference}
    String                          $.data[0].rootAccountIdentifier.issuerAccountExternalReference              ${cntr_res_data.root_issuerAccountExternalReference}
    String                          $.data[0].status                                                            ACTIVE

