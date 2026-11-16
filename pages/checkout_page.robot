*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Step One Locators
${TXT_FIRST_NAME}        id=first-name
${TXT_LAST_NAME}         id=last-name
${TXT_POSTAL_CODE}       id=postal-code
${BTN_CONTINUE}          id=continue
${SUCCESS_HEADER_TEXT}  Thank you for your order!

# Step Two Locators
${BTN_FINISH}            id=finish

# Confirmation Locators
${LBL_COMPLETE_HEADER}   class=complete-header

*** Keywords ***
Enter First Name
    [Arguments]    ${firstName}
    Input Text    ${TXT_FIRST_NAME}    ${firstName}

Enter Last Name
    [Arguments]    ${lastName}
    Input Text    ${TXT_LAST_NAME}    ${lastName}

Enter Postal Code
    [Arguments]    ${postalCode}
    Input Text    ${TXT_POSTAL_CODE}    ${postalCode}

Click Continue Button
    Click Button    ${BTN_CONTINUE}

Click Finish Button
    Click Button    ${BTN_FINISH}

Get Confirmation Message Text
    ${message}=    Get Text    ${LBL_COMPLETE_HEADER}
    RETURN    ${message}
