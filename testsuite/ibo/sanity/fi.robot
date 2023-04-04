*** Settings ***
# APITest.robot
Library             REST    ssl_verify=false
Resource            ../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../interface/ibo/restapi/contract/RetrieveContractAPI.resource
Resource            ../../../interface/ibo/restapi/common/AuthenticationApi.resource
Resource            ../../../interface/ibo/restapi/common/GetProductDetails.resource
Resource            ../../../interface/ibo/restapi/contract/ListAccountsForContractAPI.resource
Resource            ../../../interface/ibo/restapi/card-contract/RetrieveCardContractAPI.resource
Resource            ../../../interface/ibo/restapi/card-contract/RetrieveCardholderForCardContractAPI.resource
Resource            ../../../interface/ibo/restapi/card-contract/RetrieveContractForACardContractAPI.resource
Resource            ../../../interface/ibo/restapi/card/RetrieveCardContractForACardAPI.resource
Resource            ../../../interface/ibo/restapi/card/CardLifeCycleAPI.resource
Library             Collections
Library             String
Library             JSONLibrary
Test Setup          Get Api Version and Product Details


*** Variables ***
${HOST} =                                   https://tdfuji24s.sys.meshcore.net:11550
${API_URL} =                                /api/v2
${BUSINESS_API_URL} =                       /api/business-admin/v1
${API_USERNAME} =                           admin/WLP/DEFAULT_MANDATOR
${API_PASSWORD} =                           test123
${response_print_in_console} =              False
${productReference} =                       PDT_10004_MCD_DEBIT_PHYS     #PDT_6500_VISA_DEBIT_CLASSIC
${BASE_API_URL} =                           ${HOST}${API_URL}
${BASE_BUSINESS_API_URL} =                  ${HOST}${BUSINESS_API_URL}



#robot -d Reports -t "API TC01" ./testsuite/ibo/sanity/fi.robot
*** Test Cases ***
AP01
    log                                     ${BASE_API_URL}
    log to console    ${BASE_API_URL}
    Get IBO Retrieve API Metadata Information

AP02
    log                                     ${BASE_API_URL}
    log to console    ${BASE_API_URL}
    Get IBO IssuesID from Product
    Get IBO Product Details By Product Reference

API TC01
    [Documentation]                         CreateContract and Retrive Contract, Card Contract, Accounts Details
    [Tags]    sanity    apiv2   cardCreation
    log                                     ${BASE_API_URL}
    ${cntr_res_data}                        Run IBO Contract Cration API
    set global variable                     ${cntr_res_data}            &{cntr_res_data}
    Run IBO Retrieve contract ext API
    Run IBO Retrieve contract API
    Run IBO List accounts for contract ext API
    Run IBO List accounts for contract API
    Run IBO Retrieve card contract ext API
    Run IBO Retrieve card contract API



*** Keywords ***
Get Api Version and Product Details
    log                                     ${BASE_API_URL}
    log to console    ${BASE_API_URL}
    Get IBO IssuesID from Product
    Get IBO Product Details By Product Reference
