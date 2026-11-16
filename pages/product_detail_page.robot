*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LBL_PRODUCT_NAME}     xpath=//div[contains(@class,'inventory_details_name')]
${LBL_PRODUCT_DESC}     xpath=//div[contains(@class,'inventory_details_desc')]
${LBL_PRODUCT_PRICE}    xpath=//div[contains(@class,'inventory_details_price')]
${BTN_ADD_TO_CART}      id=add-to-cart
${BTN_REMOVE}           id=remove
${BTN_BACK_TO_PRODUCTS}  id=back-to-products
${BADGE_CART_COUNT}     xpath=//span[@class='shopping_cart_badge']

*** Keywords ***
Get Product Name Text
    ${name}=    Get Text    ${LBL_PRODUCT_NAME}
    RETURN    ${name}

Get Product Price Text
    ${price}=    Get Text    ${LBL_PRODUCT_PRICE}
    RETURN    ${price}

Click Add To Cart Button
    Click Button    ${BTN_ADD_TO_CART}

Click Remove Button
    Click Button    ${BTN_REMOVE}

Click Back To Products Button
    Click Button    ${BTN_BACK_TO_PRODUCTS}

Get Cart Item Count
    ${count}=    Get Text    ${BADGE_CART_COUNT}
    RETURN    ${count}

Get Add To Cart Button Element
    RETURN    ${BTN_ADD_TO_CART}

Get Remove Button Element
    RETURN    ${BTN_REMOVE}