*** Settings ***
Library             REST    ssl_verify=false
Resource            ../../../keywords/ibo/andromeda/api/TC00 - Get API Version and Product Details.resource
Resource            ../../../keywords/ibo/andromeda/api/TC01 - CreateContract and Retrive Contract and Card ContractAccounts Details.resource
Resource            ../../../keywords/ibo/andromeda/api/TC02 - Get CardHolder, Contract, card Contract Details.resource
Resource            ../../../keywords/ibo/andromeda/api/TC03 - Card lifecycle.resource
Resource            ../../../keywords/ibo/andromeda/api/TC04 - Card lifecycle External.resource
Resource            ../../../keywords/ibo/andromeda/api/TC05 - Replace card.resource
Resource            ../../../keywords/ibo/andromeda/api/TC06 - Get Customer, cardContracts, Contracts details.resource
Resource            ../../../keywords/ibo/andromeda/api/TC07 - Close Contract & Get Contract and Account Details.resource
Resource            ../../../keywords/ibo/andromeda/api/TC08 - Add Cards and Accounts To Contract.resource
Resource            ../../../keywords/ibo/andromeda/api/TC09 - Card Activation & Deactivation.resource
Resource            ../../../keywords/ibo/andromeda/api/TC10 - Card Activation & Deactivation External.resource
Resource            ../../../keywords/ibo/andromeda/api/TC11 - Serach By Card Details.resource
Resource            ../../../keywords/ibo/andromeda/api/TC12 - Retrieve card Details.resource
Resource            ../../../configuration/ibo/andromeda/listOfProducts.resource

*** Variables ***
${HOST} =                                   https://tdfuji24s.sys.meshcore.net:15550
${API_URL} =                                /api/v2
${BUSINESS_API_URL} =                       /api/business-admin/v1
${API_USERNAME} =                           admin/WLP/DEFAULT_MANDATOR
${API_PASSWORD} =                           test123
${response_print_in_console} =              False
${productReference} =                       PDT_10004_MCD_CREDIT_PHYS
${BASE_API_URL} =                           ${HOST}${API_URL}
${BASE_BUSINESS_API_URL} =                  ${HOST}${BUSINESS_API_URL}
${PLATFORM}=                                andromeda
@{andromeda_products_list}

#PDT_10004_MCD_DEBIT_PHYS, PDT_10004_MCD_DEBIT_VIRT, PDT_10004_MCD_CREDIT_PHYS, PDT_10004_MCD_CREDIT_VIRT, PDT_10004_DMC_DEBIT_PHYS, PDT_10004_DMC_DEBIT_VIRT
#PDT_6500_VISA_DEBIT_CLASSIC, PDT_6500_VISA_DEBIT_CLASSIC_SHARE
#robot -d Reports -v productReference:PDT_10004_MCD_CREDIT_VIRT ./testsuite/ibo/sanity/andromeda.robot
#robot -d Reports -v productReference:PDT_6500_VISA_DEBIT_CLASSIC ./testsuite/ibo/sanity/andromeda.robot
#robot --name=API -d Reports -i "my" ./testsuite/ibo/sanity/andromeda.robot
#robot --name=API -d Reports -i "apiv2" ./testsuite/ibo/sanity/andromeda.robot
#robot --name=API -d Reports ./testsuite/ibo/sanity/andromeda.robot


*** Test Cases ***
REST API TC00 - Get Api Version and Product Details
    [Tags]    apiv2    my
    API TC00 - Get Api Version and Product Details

REST API TC01 - CreateContract - Retrive Contract - Card Contract - Accounts Details
    [Tags]    apiv2
    API TC01 - CreateContract and Retrive Contract, Card Contract, Accounts Details

REST API TC02 - Get CardHolder - Contract - card Contract Details
    [Tags]    apiv2
    API TC02 - Get CardHolder, Contract, card Contract Details

REST API TC03 - Card lifecycle
    [Tags]    apiv2
    API TC03 - Card lifecycle

REST API TC04 - Card lifecycle External
    [Tags]    apiv2
    API TC04 - Card lifecycle External

REST API TC05 - Replace card
    [Tags]    apiv2
    API TC05 - Replace card

REST API TC06 - Get Customer - cardContracts - Contracts details
    [Tags]    apiv2
    API TC06 - Get Customer - cardContracts - Contracts details

REST API TC07 - Close Contract - Get Contract - Account Details
    [Tags]    apiv2
    API TC07 - Close Contract - Get Contract and Account Details

REST API TC08 - Add card and Account To existing Contract
    [Tags]    apiv2
    API TC08 - Add card and Account To existing Contract

REST API TC09 - Card Activation - Deactivation
    [Tags]    apiv2
    API TC09 - Card Activation - Deactivation

REST API TC10 - Card Activation - Deactivation External
    [Tags]    apiv2
    API TC10 - Card Activation - Deactivation External

REST API TC11 - Serach By card Details
    [Tags]    apiv2
    API TC11 - Retrieve card by cardNumber and sequenceNumber and expiryDate

REST API TC12 - Retrieve card Details
    [Tags]    apiv2     my
    API TC12 - Retrieve card Details