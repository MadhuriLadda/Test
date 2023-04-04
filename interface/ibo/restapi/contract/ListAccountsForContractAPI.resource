*** Settings ***
Documentation       List accounts for contract API
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
Run IBO List accounts for contract API
    [Documentation]                 /issuers/{issuerId}/contracts/{contractReference}/accounts
    [Arguments]                     ${QUERY_PARAMS}
    set basic Authentication
    IF                              '${QUERY_PARAMS}' == 'NO'
            REST.GET                ${BASE_API_URL}/issuers/${issuerId}/contracts/${cntr_res_data.contractReference}/accounts
    ELSE IF                         '${QUERY_PARAMS}' == 'YES'
            REST.GET                ${BASE_API_URL}/issuers/${issuerId}/contracts/${cntr_res_data.contractReference}/accounts                                       query={"filter":"accountIdentifier,status"}
    END
    REST.Output                     response body                                               also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                         response status                                             200
    String                          $.data[0].accountIdentifier.accountReference                ${cntr_res_data.root_accountReference}                              ${cntr_res_data.child_accountReference}
    String                          $.data[1].accountIdentifier.accountReference                ${cntr_res_data.root_accountReference}                              ${cntr_res_data.child_accountReference}
    IF                              '${QUERY_PARAMS}' == 'NO'
            String                  $.data[0].workingCurrencyCode                               EUR
            String                  $.data[0].contractIdentifier.contractReference              ${cntr_res_data.contractReference}
    END

Run IBO List accounts for contract ext API
    [Documentation]                 /issuers/{issuerId}/contracts/external-contracts/{issuerContractExternalReference}/accounts
    [Arguments]                     ${QUERY_PARAMS}
    set basic Authentication
    IF                              '${QUERY_PARAMS}' == 'NO'
            REST.GET                ${BASE_API_URL}/issuers/${issuerId}/contracts/external-contracts/${cntr_res_data.issuerContractExternalReference}/accounts
    ELSE IF                         '${QUERY_PARAMS}' == 'YES'
            REST.GET                ${BASE_API_URL}/issuers/${issuerId}/contracts/external-contracts/${cntr_res_data.issuerContractExternalReference}/accounts      query={"filter":"accountIdentifier,status"}
    END
     # ******** Verification *******
    Integer                         response status                                             200
    String                          $.data[0].accountIdentifier.accountReference                ${cntr_res_data.root_accountReference}                              ${cntr_res_data.child_accountReference}
    String                          $.data[1].accountIdentifier.accountReference                ${cntr_res_data.root_accountReference}                              ${cntr_res_data.child_accountReference}
    IF                              '${QUERY_PARAMS}' == 'NO'
            String                  $.data[0].workingCurrencyCode                               EUR
            String                  $.data[0].contractIdentifier.contractReference              ${cntr_res_data.contractReference}
    END