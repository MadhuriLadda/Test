*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/customer/RetrieveCustomerAPI.resource
Resource            ../../../../interface/ibo/restapi/customer/ListCardContractsForCardholder.resource
Resource            ../../../../interface/ibo/restapi/customer/ListAccountsForAccountOwner.resource
Resource            ../../../../interface/ibo/restapi/customer/ListContractsForContractOwner.resource


*** Keywords ***
API TC06 - Get Customer - cardContracts - Contracts details
    [Documentation]                         Get Customer - cardContracts - Contracts details
    ${cntr_res_data}                        Run IBO Contract Cration API
    set global variable                     ${cntr_res_data}                    &{cntr_res_data}
    Run IBO Retrieve Customer API
    Run IBO List card contracts for cardholder API
    Run IBO List accounts for account owner API
    Run IBO List contracts for contract owner API

