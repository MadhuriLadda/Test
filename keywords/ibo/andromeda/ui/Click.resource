*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${isScreenshotNeeded}
${Element_to _click}

*** Keywords ***
ClickCustom
    [Arguments]    ${arg1}
    Set Global Variable    ${isScreenshotNeeded}
    Click Element       ${arg1}        
    
    