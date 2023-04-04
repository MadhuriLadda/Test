*** Variables ***
@{COUNTRIES}    USA    UK

*** Test Cases ***
Test Scenario 1
    [Template]    Test Scenario 1 Template
    FOR    ${country}    IN    @{COUNTRIES}
        ${country}
    END

Test Scenario 2
    [Template]    Test Scenario 2 Template
    FOR    ${country}    IN    @{COUNTRIES}
        ${country}
    END

Test Scenario 3
    [Template]    Test Scenario 3 Template
    FOR    ${country}    IN    @{COUNTRIES}
        ${country}
    END
   
*** Keywords ***
Test Scenario 1 Template
    [Arguments]    ${country}
    Log    ${country}
    Run Keyword If    $country == 'UK'    Fail    Simulate failure.

Test Scenario 2 Template
    [Arguments]    ${country}
    Log    ${country}
    Run Keyword If    $country == 'USA'   Fail    Simulate failure.

Test Scenario 3 Template
    [Arguments]    ${country}
    Run Keyword If    $country == 'USA'    Log    Passed
    Log    ${country}