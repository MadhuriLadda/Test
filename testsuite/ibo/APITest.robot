*** Settings ***
# APITest.robot
Library             ssl_verify=false
Resource            ./../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ./../../interface/ibo/restapi/contract/RetrieveContractAPI.resource
Resource            ./../../interface/ibo/restapi/common/AuthenticationApi.resource
Resource            ./../../interface/ibo/restapi/contract/ListAccountsForContractAPI.resource
Resource            ./../../interface/ibo/restapi/card-contract/RetrieveCardContractAPI.resource
Resource            ./../../interface/ibo/restapi/card-contract/RetrieveCardholderForCardContractAPI.resource
Resource            ./../../interface/ibo/restapi/card-contract/RetrieveContractForACardContractAPI.resource
Resource            ./../../interface/ibo/restapi/card/RetrieveCardContractForACardAPI.resource
Resource            ./../../interface/ibo/restapi/card/CardLifeCycleAPI.resource
Library             Collections
Library             String
Library             JSONLibrary



*** Variables ***
${BASE_URL} =                               https://tdfuji24s.sys.meshcore.net:11550/api/v2
${API_USERNAME} =                           admin/WLP/DEFAULT_MANDATOR
${API_PASSWORD} =                           test123
${response_print_in_console} =              False
${prduct_config_file}
${api_version}


