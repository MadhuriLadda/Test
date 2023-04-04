*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/card-contract/RetrieveCardholderForCardContractAPI.resource
Resource            ../../../../interface/ibo/restapi/card-contract/RetrieveContractForACardContractAPI.resource
Resource            ../../../../interface/ibo/restapi/card-contract/RetrieveCardContractAPI.resource
Resource            ../../../../interface/ibo/restapi/card/RetrieveCardContractForACardAPI.resource

*** Keywords ***
API TC02 - Get CardHolder, Contract, card Contract Details
    [Documentation]                         Get Card Holder, Contract, card Contract Details
    ${cntr_res_data}                        Run IBO Contract Cration API
    set global variable                     ${cntr_res_data}            &{cntr_res_data}
    Run IBO Retrieve cardholder for a card contract ext API
    Run IBO Retrieve cardholder for a card contract API
    Run IBO Retrieve contract for a card contract ext API
    Run IBO Retrieve contract for a card contract API
    Run IBO Retrieve card contract ext API
    Run IBO Retrieve card contract API
    Run IBO Retrieve card contract for a card ext API
    Run IBO Retrieve card contract for a card API