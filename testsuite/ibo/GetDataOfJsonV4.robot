*** Settings ***
Library             REST    ssl_verify=false
Library             Collections
Library             String
Library             JSONLibrary
Library             BuiltIn
Resource            ../../interface/ibo/restapi/common/AuthenticationApi.resource

*** Variables ***
${BASE_URL} =               https://tdfuji24s.sys.meshcore.net:11550
${ibo_API} =                /api/v2
${base_business_url}=       /api/business-admin/v1
${auth_mode} =              Baisc
${platfrom} =               andromeda
${issuerId} =               10004
${productReference} =       PDT_6500_VISA_DEBIT_CLASSIC
${API_USERNAME} =           admin/WLP/DEFAULT_MANDATOR
${API_PASSWORD} =           Test123
@{testCaseProductDetails}
@{listOfIssuers}



#robot -d reports ./testsuite/ibo/GetDataOfJsonV4.robot
#robot -d reports -t TC01 ./testsuite/ibo/GetDataOfJsonV4.robot
*** Test Cases ***
TC01
    Get Product Details


*** Keywords ***
Get Product Details
    [Documentation]     /issuers/{issuerId}/products/{productReference}
    set basic Authentication
    # ******** API Request *******
    REST.GET
    ...     ${BASE_URL}${base_business_url}/issuers/${issuerId}/products/${productReference}
    REST.Output
    ...     response body
    ...     also_console=True
    # ******** Verification *******
    Integer
    ...     response status        200
    ${response}
    ...     REST.Output            response body            also_console=False
    log     ${response}





