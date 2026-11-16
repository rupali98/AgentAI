*** Settings ***
Documentation    Test Suite to verify functionality on the Cart Page using Data-Driven Testing.
Library          SeleniumLibrary
Library          DataDriver    file=../../Data/LoginData.xlsx    sheet_name=Products
Resource         ../../pages/login_page.robot
Resource         ../../pages/inventory_page.robot
Resource         ../../pages/cart_page.robot
Resource        ../../resources/BrowserManager.robot

Test Setup       Setup Test Session
Test Teardown    Teardown Test Session
Test Template    Verify Adding Product To Cart Test

*** Keywords ***
Setup Test Session
    Launch Browser

Teardown Test Session
    Close Browser

Verify Adding Product To Cart Test
    [Arguments]     ${ProductName}    ${ExpectedPrice}

    # 1. Login to Application
    Login To Application    ${VALID_USER}    ${VALID_PASSWORD}
    Wait Until Location Contains    inventory.html    10s

    # 2. Add product to cart and navigate to cart page
    Add Product To Cart    ${ProductName}
    Click Shopping Cart

    # 3. Assertions strictly performed in Test file
    ${actual_title}=    Get Page Title Text
    Should Be Equal As Strings    ${actual_title}    Your Cart    msg=Page title does not match 'Your Cart'

    ${actual_product_name}=    Get Added Item Name In Cart
    Should Be Equal As Strings    ${actual_product_name}    ${ProductName}    msg=Expected product '${ProductName}' was not found in the cart.

    Sleep    2s
    # 4. Action: Remove Item & Assert Cart is Empty
    Click Remove Button
    ${items_count}=    Get Cart Items Count
    Should Be Equal As Integers    ${items_count}    0    msg=Cart was expected to be empty after removing the item.


*** Test Cases ***
Verify Product cart Page Data For ${product_name}
    [Documentation]    Data-driven test template execution. Rows from Excel file will populate here.
    NONE


