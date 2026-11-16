*** Settings ***
Documentation    Test suite for SauceDemo Product Details Page functionality.
...              Data-driven using Excel sheet. All assertions remain strictly within this test file.

Library          SeleniumLibrary
Library          DataDriver    file=../../Data/LoginData.xlsx    sheet_name=Products

Resource         ../../resources/testData.robot
Resource         ../../pages/login_page.robot
Resource         ../../pages/inventory_page.robot
Resource         ../../pages/product_detail_page.robot

Test Setup       Setup Test Suite
Test Teardown    Teardown Test Suite
Test Template    Verify Product Details And Add To Cart Flow

*** Keywords ***
Setup Test Suite
    Launch Browser

Teardown Test Suite
    Close Browser

Verify Product Details And Add To Cart Flow
    [Arguments]     ${ProductName}    ${ExpectedPrice}

    # Step 1: Login
    Login To Application    ${VALID_USER}    ${VALID_PASSWORD}
    Wait Until Location Contains    inventory.html    10s

    # Step 2: Navigate to Product Detail Page
    Select Product By Name    ${ProductName}
    

    # --- ASSERTIONS SECTION ---

    # Assertion 1: Validate Selected Product Title
    ${actual_name}=    product_detail_page.Get Product Name Text
    Should Be Equal As Strings    ${actual_name}    ${ProductName}    msg=Product name on detail page does not match expected!

    # Assertion 2: Validate Selected Product Price
    ${actual_price}=    product_detail_page.Get Product Price Text
    #Log To Console    ${actual_price}
    #Log To Console    ${ExpectedPrice}
    ${actual_price}=      Strip String    ${actual_price}
    ${ExpectedPrice}=     Strip String    ${ExpectedPrice}
    Should Be Equal As Strings    ${actual_price}    ${ExpectedPrice}    msg=Product price on detail page does not match expected!

    # Assertion 3: Add product to cart and verify cart badge update
    product_detail_page.Click Add To Cart Button
    ${cart_count}=    product_detail_page.Get Cart Item Count
    Should Be Equal As Strings    ${cart_count}    1    msg=Cart badge count should be 1 after adding product!

    # Assertion 4: Verify 'Remove' button displays after adding to cart
    ${remove_btn}=    product_detail_page.Get Remove Button Element
    Element Should Be Visible    ${remove_btn}    msg=Remove button should be visible after adding product to cart!

    # Assertion 5: Remove product and verify product cart state reset
    product_detail_page.Click Remove Button
    ${add_btn}=    product_detail_page.Get Add To Cart Button Element
    Element Should Be Visible    ${add_btn}    msg=Add to Cart button should re-appear after removing item!

    # Assertion 6: Verify Navigation back to Inventory Page
    product_detail_page.Click Back To Products Button
    Location Should Be    https://www.saucedemo.com/inventory.html    msg=Did not navigate back to Inventory page!

*** Test Cases ***
Verify Product Detail Page Data For ${product_name}
    [Documentation]    Data-driven test template execution. Rows from Excel file will populate here.
    NONE