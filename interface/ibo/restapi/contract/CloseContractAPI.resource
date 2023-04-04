*** Settings ***
Documentation       List accounts for contract API
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
Run IBO Close contract API
    [Documentation]                             /issuers/{issuerId}/contracts/{contractReference}/close
    set basic Authentication
    ${JSON_FILE}=                               Close contract Json Data
    REST.POST                                   ${BASE_API_URL}/issuers/${issuerId}/contracts/${cntr_res_data.contractReference}/close      body=${JSON_FILE}
    REST.Output                                 response body                                                                               also_console=False
    # ******** Verification *******
    Integer                                     response status                                                                             200
    String                                      $.data.contract.contractIdentifier.contractReference                                        ${cntr_res_data.contractReference}
    String                                      $.data.contract.status                                                                      CLOSED
    String                                      $.data.contract.accounts[0].status                                                          BEING_CLOSED
    String                                      $.data.contract.cardContracts[0].cardContractIdentifier.cardContractReference               ${cntr_res_data.cardContractReference}
    String                                      $.data.contract.cardContracts[0].status                                                     CLOSED
    String                                      $.data.contract.cardContracts[0].cards[0].cardIdentifier.cardReference                      ${cntr_res_data.cardReference}
    String                                      $.data.contract.cardContracts[0].cards[0].status                                            CANCELLED



Run IBO Close contract ext API
    [Documentation]                             /issuers/{issuerId}/contracts/external-contracts/{issuerContractExternalReference}/close
    set basic Authentication
    ${JSON_FILE}=                               Close contract Json Data
    REST.POST
    ...    ${BASE_API_URL}/issuers/${issuerId}/contracts/external-contracts/${cntr_res_data.issuerContractExternalReference}/close          body=${JSON_FILE}
    REST.Output                                 response body                                                                               also_console=False
    # ******** Verification *******
    Integer                                     response status                                                                             200
    String                                      $.data.contract.contractIdentifier.contractReference                                        ${cntr_res_data.contractReference}
    String                                      $.data.contract.status                                                                      CLOSED
    String                                      $.data.contract.accounts[0].status                                                          BEING_CLOSED
    String                                      $.data.contract.cardContracts[0].cardContractIdentifier.cardContractReference               ${cntr_res_data.cardContractReference}
    String                                      $.data.contract.cardContracts[0].status                                                     CLOSED
    String                                      $.data.contract.cardContracts[0].cards[0].cardIdentifier.cardReference                      ${cntr_res_data.cardReference}
    String                                      $.data.contract.cardContracts[0].cards[0].status                                            CANCELLED



Close contract Json Data
    [Documentation]                     Basic Template to Close contract
    ${JSON_FILE}=                       Load Json From File                                                                            ${CURDIR}/../../../../resources/ibo/restapi/templates/contract/close_contract.json
    [Return]                            ${JSON_FILE}