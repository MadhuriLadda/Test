*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/contract/AddCardsAndAccountsToContractAPI.resource


*** Keywords ***
API TC08 - Add card and Account To existing Contract
    [Documentation]                                     CreateContract - Add card and Account To Parent Contract
    ${cntr_res_data}                                    Run IBO Contract Cration API
    set global variable                                 ${cntr_res_data}                        &{cntr_res_data}
    Run Add cards and accounts to a contract API
    ${cntr_res_data}                                    Run IBO Contract Cration API
    set global variable                                 ${cntr_res_data}                        &{cntr_res_data}
    Run Add cards and accounts to a contract ext API