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
Run IBO Retrieve Customer API
    [Documentation]                 /issuers/{issuerId}/customers/{customerReference}
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/customers/${cntr_res_data.customerReference}
    REST.Output                     response body                                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                             200
    String                          $.data.customerIdentifier.customerReference                                 ${cntr_res_data.customerReference}
    String                          $.data.customerIdentifier.issuerCustomerExternalReference                   ${cntr_res_data.issuerCustomerExternalReference}
    String                          $.data.firstName                                                            ${cntr_res_data.firstName}
    String                          $.data.lastName                                                             ${cntr_res_data.lastName}

