*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/contract/RetrieveContractAPI.resource
Resource            ../../../../interface/ibo/restapi/contract/ListAccountsForContractAPI.resource
Resource            ../../../../interface/ibo/restapi/card-contract/RetrieveCardContractAPI.resource


*** Keywords ***
API TC01 - CreateContract and Retrive Contract, Card Contract, Accounts Details
    [Documentation]                                 CreateContract and Retrive Contract, Card Contract, Accounts Details
    ${cntr_res_data}                                Run IBO Contract Cration API
    set global variable                             ${cntr_res_data}                        &{cntr_res_data}
    Run IBO Retrieve contract ext API               SIGNED
    Run IBO Retrieve contract API                   SIGNED
    Run IBO List accounts for contract ext API      NO
    Run IBO List accounts for contract API          NO
    Run IBO Retrieve card contract ext API
    Run IBO Retrieve card contract API