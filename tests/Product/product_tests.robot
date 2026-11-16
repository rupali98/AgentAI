*** Settings ***
Documentation    TestSuite containing ALL Positive and Negative test cases for SauceDemo Product Page.
...              All Assertions are isolated exclusively within this file.

Library          SeleniumLibrary
Library          Collections
Resource         ../../resources/testData.robot
Resource         ../../pages/login_page.robot
Resource        ../../resources/BrowserManager.robot
Resource         ../../pages/inventory_page.robot
Resource         ../../pages/cart_page.robot

Test Setup       Open Application and Login Standard User
Test Teardown    Close Application

*** Test Cases ***

# ==============================================================================
# POSITIVE TEST SCENARIOS
# ==============================================================================

TC01_Verify Product Page Elements Loaded Successfully
    [Documentation]    Verify title and standard 6 items exist on product page.
    ${title}=    Get Page Title Text
    Should Be Equal As Strings    ${title}    Products

    ${count}=    Get Inventory Item Count
    Should Be Equal As Integers    ${count}    6

TC02_Verify cart badge is displayed
    Element Should Be Visible    ${SHOPPING_CART_LINK}

TC03_Verify Swag Labs Logo Is Displayed
    Element Text Should Be    ${HEADINGS}    Swag Labs

TC04_Verify Hamburger Menu Is Displayed
    Element Should Be Visible    ${menu}
    Element Should Be Enabled    ${menu}

TC05_Verify Shopping Cart Icon Is Displayed
    Element Should Be Visible    ${SHOPPING_CART_LINK}

TC06_Verify Sort Dropdown Is Displayed
    Element Should Be Visible    ${sort_dropdown}

TC07_Verify All Products Are Displayed
    ${count}=    Get Element Count    ${PRODUCT_ITEM}
    Should Be Equal As Integers    ${count}    6


TC08_Verify Each Product Has product_name,product_image,product_decription,product,product_price,Add_To_Cart_Button
    Sleep    4s
    Element Should Be Visible    ${PRODUCT_IMG}
    Element Should Be Visible    ${PRODUCT_ITEM}
    Element Should Be Visible    ${PRODUCT_DESC}
    Element Should Be Visible    ${PRODUCT_PRICE}
    Element Should Be Visible    ${Add_to_cart_btn}


TC09_Verify Sort Products By Name A to Z
    [Documentation]    Verify product sorting alphabetically ascending.
    Select Sort Option    az
    ${names}=    Get All Product Names
    ${sorted_names}=    Copy List    ${names}
    Sort List    ${sorted_names}
    Lists Should Be Equal    ${names}    ${sorted_names}

TC10_Verify Sort Products By Name Z to A
    [Documentation]    Verify product sorting alphabetically descending.
    Select Sort Option    za
    ${names}=    Get All Product Names
    ${sorted_names}=    Copy List    ${names}
    Sort List    ${sorted_names}
    Reverse List    ${sorted_names}
    Lists Should Be Equal    ${names}    ${sorted_names}


TC11_Verify Sort Products By Price Low to High
    [Documentation]    Verify sorting products by price ascending.
    Select Sort Option    lohi
    ${prices}=    Get All Product Prices
    ${sorted_prices}=    Copy List    ${prices}
    Sort List    ${sorted_prices}
    Lists Should Be Equal    ${prices}    ${sorted_prices}

TC12_Verify Sort Products By Price High to Low
    [Documentation]    Verify sorting products by price descending.
    Select Sort Option    hilo
    ${prices}=    Get All Product Prices
    Log    ${prices}
    ${sorted_prices}=    Copy List    ${prices}
    Sort List    ${sorted_prices}
    Reverse List    ${sorted_prices}
    Lists Should Be Equal    ${prices}    ${sorted_prices}


TC13_Verify Add to Cart button is displayed for all products
    @{cart_btn}=    Get Webelements    ${Add_to_cart_btn}
    ${count}=    Get Length    ${cart_btn}
    Log To Console    ${count}
    Should Be Equal As Integers    ${count}    6

    FOR    ${cart}    IN    ${cart_btn}
        Element Should Be Visible    ${cart}
    END

TC14_Verify Add to Cart button is enabled
    ${cart_btn}=    Get Webelements    ${Add_to_cart_btn}
    ${count}=    Get Length    ${cart_btn}
    Log To Console    ${count}

    FOR    ${cart}    IN    ${cart_btn}
        Element Should Be Enabled    ${cart}
    END


TC15_Verify Add to Cart changes to Remove after click
    Click Element    ${Add_to_cart_btn1}
    Element Should Be Visible    ${remove}    Remove

TC16_Verify cart badge count increments by 1
    Click Element    ${Add_to_cart_btn1}
    Element Text Should Be    ${cart_count1}    1


TC17_Verify Adding Single Product To Cart
    [Documentation]    Verify badge count updates to 1 and button toggles to 'Remove'.
    Add Item To Cart By Name    Sauce Labs Backpack

    ${badge_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${badge_count}    1

    ${btn_text}=    Get Button Text For Product    Sauce Labs Backpack
    Should Be Equal As Strings    ${btn_text}    Remove

TC18_Verify Adding Multiple Products To Cart
    [Documentation]    Verify adding multiple products updates cart counter incrementally.
    Add Item To Cart By Name    Sauce Labs Backpack
    Add Item To Cart By Name    Sauce Labs Bike Light
    Add Item To Cart By Name    Sauce Labs Bolt T-Shirt

    ${badge_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${badge_count}    3

TC19_Verify Removing Product From Cart
    [Documentation]    Verify removing an item decrements badge count and toggles button to 'Add to cart'.
    Add Item To Cart By Name    Sauce Labs Backpack
    Add Item To Cart By Name    Sauce Labs Bike Light
    Remove Item From Cart By Name    Sauce Labs Backpack

    ${badge_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${badge_count}    1

    ${btn_text}=    Get Button Text For Product    Sauce Labs Backpack
    Should Be Equal As Strings    ${btn_text}    Add to cart

TC20_Verify Empty Cart Badge Disappears
    [Documentation]    Verify cart badge disappears completely when cart becomes empty.
    Add Item To Cart By Name    Sauce Labs Backpack
    Remove Item From Cart By Name    Sauce Labs Backpack

    ${badge_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${badge_count}    0

TC21_Verify Navigation To Cart Page
    [Documentation]    Verify clicking shopping cart icon opens cart page.
    Click Shopping Cart
    ${current_url}=    Get Current Page URL
    Should Be Equal As Strings    ${current_url}    ${CART_URL}

    ${cart_title}=    Get Page Title Text
    Should Be Equal As Strings    ${cart_title}    Your Cart


TC22_Verify clicking product name opens Product Details page
    [Documentation]    Verify clicking product name opens product detail page
    Click Element    ${PRODUCT_ITEM1}
    Element Should Be Visible    ${productDetail_page_item}
    Element Should Be Visible    ${ProductDetail_page_price}
    Element Should Be Visible    ${ProductDetail_page_desc}


TC23_Verify clicking image opens Product Details page
    ${Expected_Item_Name}=    Get Text    ${PRODUCT_ITEM1}

    Click Element    ${image1}

    Wait Until Location Contains    inventory-item.html    10s
    Sleep    2s

    ${actual_Item_Name}=    Get Text    ${productDetail_page_item}

    Should Be Equal    ${actual_Item_Name}    ${Expected_Item_Name}

    Element Should Be Visible    ${productDetail_page_item}
    Element Should Be Visible    ${ProductDetail_page_price}
    Element Should Be Visible    ${ProductDetail_page_desc}


TC24_Verify All Items option is displayed
    [Documentation]    Verify All Items option is displayed
    Click Element    ${menu}
    Wait Until Element Is Visible    ${All_item_menu}

TC25_Verify Logout Functionality
    [Documentation]    Verify user can logout successfully via side menu.
    Open Menu
    Click Logout Link
    ${current_url}=    Get Location
    Should Be Equal As Strings    ${current_url}    ${URL}

TC26_Verify Reset App State option is displayed
    [Documentation]    Verify Reset App State option is displayed
    Click Element    ${menu}
    Wait Until Element Is Visible    ${reset_app_state}

# ==============================================================================
# NEGATIVE TEST SCENARIOS
# ==============================================================================

TC27_Negative_Direct URL Access Without Authentication
    [Documentation]    Verify unauthorized user is redirected/blocked when accessing inventory page directly.
    [Setup]    Launch Browser
    Navigate Direct To Product Page

    ${error_msg}=    Get Login Error Text
    Should Contain    ${error_msg}    Epic sadface: You can only access '/inventory.html' when you are logged in.

TC27_Negative_Problem User Broken Images Validation
    [Documentation]    Verify problem user encounters broken image assets on inventory page.
    [Setup]    Launch Browser
    Login To Application    ${PROBLEM_USER}    ${VALID_PASSWORD}

    ${img_src}=    Get First Image Source
    # Problem user displays broken link: '/static/media/sl-404.168b1cce.jpg'
    Should Contain    ${img_src}    sl-404


TC28_Verify product names are not empty
    Get All Product Names


TC29_Verify no product has a blank price
    Get All Product Prices

TC30_Verify image is clickable
    @{images}=    Get Webelements   ${All_image}
    ${count}=    Get Length    ${images}
    Log To Console    ${count}

    FOR    ${INDEX}    IN RANGE    1    7
        Click Element    (${All_image})[${INDEX}]
        Wait Until Location Contains        inventory-item.html        10s
        Go Back
        Wait Until Element Is Visible       ${image1}
    END


