*** Settings ***
Library             REST    ssl_verify=false
Library             Collections
Library             String
Library             JSONLibrary
Library             BuiltIn

*** Variables ***
${API_USERNAME} =
${API_PASSWORD} =
# AuthenticationApi.resource

*** Keywords ***
set basic Authentication
    Set Client Authentication    Basic    ${API_USERNAME}    ${API_PASSWORD}

