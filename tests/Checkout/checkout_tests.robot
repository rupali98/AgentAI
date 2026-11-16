*** Settings ***
Documentation    Suite to validate the complete checkout workflow using Excel-driven data.
Library          SeleniumLibrary
Library          DataDriver    file=../../Data/LoginData.xlsx    sheet_name=CheckoutData

Resource         ../../resources/testData.robot
Resource         ../../pages/login_page.robot
Resource         ../../pages/cart_page.robot
Resource         ../../pages/checkout_page.robot
Resource        ../../pages/inventory_page.robot

Test Setup       Launch Browser
Test Teardown    Close Application
Test Template    Successful Checkout Workflow

*** Test Cases ***
Verify User Can Complete Checkout Scenario With Excel Data    ${username}    ${password}    ${firstName}    ${lastName}    ${postalCode}

*** Keywords ***
Successful Checkout Workflow
    [Arguments]    ${username}    ${password}    ${firstName}    ${lastName}    ${postalCode}

    # 1. Login Step
    Login To Application    ${username}    ${password}
    Sleep    2s
    # Assert Login Success
    Location Should Contain    inventory.html

    # 2. Add Product and Proceed to Checkout
    Add Backpack To Cart
    Click Shopping Cart
    Location Should Contain    cart.html

    Click Checkout Button
    Location Should Contain    checkout-step-one.html

    # 3. Fill Checkout Details
    Enter First Name     ${firstName}
    Enter Last Name      ${lastName}
    Enter Postal Code    ${postalCode}
    Click Continue Button

    # Assert Overview Step
    Location Should Contain    checkout-step-two.html

    # 4. Finish Purchase
    Click Finish Button

    # Assert Completion Page & Success Text (Assertions ONLY in Test File)
    Location Should Contain    checkout-complete.html
    ${actual_header}=    Get Confirmation Message Text
    Should Be Equal As Strings    ${actual_header}    ${SUCCESS_HEADER_TEXT}