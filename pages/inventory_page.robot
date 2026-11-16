*** Settings ***
Documentation    Page Object for the SauceDemo Products/Inventory Page.
Library          SeleniumLibrary
Library          Collections
Library          String
Resource         ../resources/testData.robot

*** Variables ***
${PAGE_TITLE}              xpath=//span[@class='title']
${PRODUCT_ITEM}            xpath=//div[@class='inventory_item']
${PRODUCT_ITEM1}    xpath=(//div[@data-test='inventory-item-name'])[1]
${productDetail_page_item}    //div[@data-test='inventory-item-name']
${ProductDetail_page_price}    //div[@data-test='inventory-item-price']
${ProductDetail_page_desc}    //div[@data-test='inventory-item-desc']
${PRODUCT_NAME}            xpath=//div[@class='inventory_item_name']                          
${PRODUCT_PRICE}           xpath=//div[@class='inventory_item_price']
${PRODUCT_IMG}             xpath=//div[@class='inventory_item_img']//img                   
${All_image}                //div[@class='inventory_item_img']//a
${image1}                  xpath=(//img[@class='inventory_item_img'])[1]
${SORT_DROPDOWN}           xpath=//select[@class='product_sort_container']
${SHOPPING_CART_LINK}      xpath=//a[@class='shopping_cart_link']
${SHOPPING_CART_BADGE}     xpath=//span[@class='shopping_cart_badge']
#${BURGER_MENU_BTN}         id=react-burger-menu-btn
${LOGOUT_SIDEBAR_LINK}     id=logout_sidebar_link
${menu}    id:react-burger-menu-btn
${All_item_menu}    id:inventory_sidebar_link
${reset_app_state}    reset_sidebar_link
${HEADINGS}    //div[text()='Swag Labs']
${PRODUCT_DESC}       //div[@data-test='inventory-item-desc']
${Add_to_cart_btn}    //button[text()='Add to cart']
${Add_to_cart_btn1}    (//button[text()='Add to cart'])[1]
${Add_to_cart_btn2}    (//button[text()='Add to cart'])[2]
${remove}    //button[text()='Remove']
${cart_count1}        //a[@aria-label='Cart, 1 items']
#${cart_count2}    //a[@aria-label='Cart, 2 items']
#${cart_count6}    //a[@aria-label='Cart, 6 items']
${LNK_PRODUCT_TITLE}    xpath=//div[@data-test='inventory-item-name' and text()='{ProductName}']
${CART_ICON}            class=shopping_cart_link
${ADD_TO_CART_BTN}      xpath=//div[text()='{ProductName}']/ancestor::div[@class='inventory_item_description']//button



*** Keywords ***
Navigate Direct To Product Page
    Go To    ${PRODUCT_URL}

Get Page Title Text
    ${title}=    Get Text    ${PAGE_TITLE}
    RETURN    ${title}

Get Inventory Item Count
    ${count}=    Get Element Count    ${PRODUCT_ITEM}
    RETURN    ${count}

Select Sort Option
    [Arguments]    ${sort_value}
    Select From List By Value    ${SORT_DROPDOWN}    ${sort_value}

Get All Product Names
    ${elements}=    Get WebElements    ${PRODUCT_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Should Not Be Empty    ${text}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Get All Product Prices
    ${elements}=    Get WebElements    ${PRODUCT_PRICE}
    ${prices}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        ${clean_price}=    Remove String    ${text}    $
        ${float_price}=    Convert To Number    ${clean_price}
        Should Not Be Empty    ${text}
        Append To List    ${prices}    ${float_price}
    END
    RETURN    ${prices}

Add Item To Cart By Name
    [Arguments]    ${product_name}
    ${locator}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button
    Click Button    ${locator}

Remove Item From Cart By Name
    [Arguments]    ${product_name}
    ${locator}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button
    Click Button    ${locator}

Get Button Text For Product
    [Arguments]    ${product_name}
    ${locator}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button
    ${btn_text}=    Get Text    ${locator}
    RETURN    ${btn_text}

Get Cart Badge Count
    ${is_badge_present}=    Run Keyword And Return Status    Element Should Be Visible    ${SHOPPING_CART_BADGE}
    IF    ${is_badge_present}
        ${badge_text}=    Get Text    ${SHOPPING_CART_BADGE}
        ${badge_num}=    Convert To Integer    ${badge_text}
        RETURN    ${badge_num}
    ELSE
        RETURN    ${0}
    END

Click Shopping Cart
    Wait Until Element Is Visible    ${SHOPPING_CART_LINK}
    Click Link    ${SHOPPING_CART_LINK}

Click Product Name Link
    [Arguments]    ${product_name}
    Click Element    xpath=//div[text()='${product_name}']

Open Menu
    Click Button    ${menu}

Click Logout Link
    Wait Until Element Is Visible    ${LOGOUT_SIDEBAR_LINK}    ${TIMEOUT}
    Click Element    ${LOGOUT_SIDEBAR_LINK}

Get First Image Source
    ${src}=    Get Element Attribute    ${PRODUCT_IMG}    src
    RETURN    ${src}


Add Backpack To Cart
    Wait Until Element Is Visible    ${Add_to_cart_btn1}
    Click Button        ${Add_to_cart_btn1}

Select Product By Name
    [Arguments]    ${product_name}
    ${count}=    Get Element Count    xpath=//*[contains(@class,'inventory_item_name')]
    Log To Console    Products Found = ${count}
    Page Should Contain Element    xpath=//*[contains(@class,'inventory_item_name')]
    ${locator}=    Replace String    ${LNK_PRODUCT_TITLE}    {ProductName}    ${product_name}
    Log To Console    Product Name = '${product_name}'
    Log To Console    Locator = ${locator}
    Click Element    ${locator}

Add Product To Cart
    [Arguments]    ${product_name}
    ${locator}=    Replace String    //div[text()='PRODUCT_PLACEHOLDER']/ancestor::div[@class='inventory_item_description']//button    PRODUCT_PLACEHOLDER    ${product_name}
    Click Button    ${locator}
