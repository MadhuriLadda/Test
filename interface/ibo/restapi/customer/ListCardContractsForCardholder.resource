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
Run IBO List card contracts for cardholder API
    [Documentation]                 /issuers/{issuerId}/customers/{customerReference}/card-contracts
    set basic Authentication
    REST.GET                        ${BASE_API_URL}/issuers/${issuerId}/customers/${cntr_res_data.customerReference}/card-contracts
    REST.Output                     response body                                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                                             200
    String                          $.data[0].cardContractIdentifier.cardContractReference                      ${cntr_res_data.cardContractReference}
    String                          $.data[0].cardContractIdentifier.issuerCardContractExternalReference        ${cntr_res_data.issuerCardContractExternalReference}
    String                          $.data[0].status                                                            ACTIVE
    String                          $.data[0].contractIdentifier.contractReference                              ${cntr_res_data.contractReference}
    String                          $.data[0].contractIdentifier.issuerContractExternalReference                ${cntr_res_data.issuerContractExternalReference}

