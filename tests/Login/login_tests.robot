*** Settings ***
Documentation       Data-driven test suite for SauceDemo Login scenarios.
...                 All assertions are kept strictly within this test file.

Library             SeleniumLibrary
Library             DataDriver    file=../../Data/LoginData.xlsx    sheet_name=LoginScenarios

Resource            ../../resources/testData.robot
Resource            ../../resources/BrowserManager.robot
Resource            ../../pages/login_page.robot


Test Setup         Launch Browser
Test Teardown      Close Application
Test Template       Execute Data-Driven Login Scenario



*** Test Cases ***
SauceDemo Login Data Driven Test


*** Keywords ***
Reset Application State
    Go To    ${URL}
    Wait Until Element Is Visible    ${TXT_USERNAME}    10s
    Clear Credentials Fields

Execute Data-Driven Login Scenario
    [Arguments]    ${Username}    ${Password}    ${Expected}
    Login To Application    ${Username}    ${Password}


    IF    '${Expected}' == 'Pass'
        Validate Successful Login
        Close Application
    ELSE
        Validate Failed Login
        ${actual_error}=    Get Text    ${ERR_CONTAINER}
        Log To Console    Actual Error: ${actual_error}
        Log To Console    Expected Error: ${Expected}
        Should Be Equal As Strings    ${actual_error}    ${Expected}
    END




