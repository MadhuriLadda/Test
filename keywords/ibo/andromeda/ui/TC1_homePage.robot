*** Settings ***
Resource   Click.resource          
Library    SeleniumLibrary

*** Variables *** 
${isScreenshotNeeded}


*** Test Cases ***
Upwotk_homepage
    Open Browser    https://www.upwork.com/    chrome
    Maximize Browser Window
    Sleep  10s
    ClickCustom    //*[@class='nav-logo']
    Sleep    10s
    ClickCustom    //*[@data-cy="nav-secondary-menu"]//a[contains(text(),'Development & IT')]
    
*** Keywords ***

