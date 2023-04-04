*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/contract/CloseContractAPI.resource
Resource            ../../../../interface/ibo/restapi/contract/RetrieveContractAPI.resource
Resource            ../../../../interface/ibo/restapi/contract/ListAccountsForContractAPI.resource


*** Keywords ***
API TC07 - Close Contract - Get Contract and Account Details
    [Documentation]                             CreateContract - Close Contract - Get Contract and Account Details
    ${cntr_res_data}                            Run IBO Contract Cration API
    set global variable                         ${cntr_res_data}                        &{cntr_res_data}
    Run IBO Close contract API
    Run IBO Retrieve contract API               CLOSED
    Run IBO List accounts for contract API      NO
    Run IBO List accounts for contract API      YES
    ${cntr_res_data}                            Run IBO Contract Cration API
    set global variable                         ${cntr_res_data}                        &{cntr_res_data}
    Run IBO Close contract ext API
    Run IBO Retrieve contract ext API           CLOSED
    Run IBO List accounts for contract ext API  NO
    Run IBO List accounts for contract ext API  YES