*** Settings ***
Documentation    Page Object containing locators and raw actions for the Login Page.
...              NOTE: No assertions are performed here.
Library          SeleniumLibrary

*** Variables ***
${TXT_USERNAME}         id=user-name
${TXT_PASSWORD}         id=password
${BTN_LOGIN}            id=login-button
${ERR_CONTAINER}        css=h3[data-test="error"]

*** Keywords ***
Enter Username
    [Arguments]    ${username}
    Clear Element Text    ${TXT_USERNAME}
    Input Text     ${TXT_USERNAME}    ${username}

Enter Password
    [Arguments]    ${password}
    Clear Element Text    ${TXT_PASSWORD}
    Input Text     ${TXT_PASSWORD}    ${password}

Click Login Button
    Click Element    ${BTN_LOGIN}

Login To Application    
    [Arguments]    ${username}    ${password}
    Enter Username    ${username}    
    Enter Password    ${password}
    Click Login Button

Get Login Error Text
    Wait Until Element Is Visible    ${ERR_CONTAINER}    timeout=5s
    ${error_text}=    Get Text       ${ERR_CONTAINER}
    RETURN            ${error_text}

Clear Credentials Fields
    Clear Element Text    ${TXT_USERNAME}
    Clear Element Text    ${TXT_PASSWORD}

Validate Successful Login
    Wait Until Location Contains    inventory.html    10s

Validate Failed Login
    Wait Until Element Is Visible      ${ERR_CONTAINER}    10s