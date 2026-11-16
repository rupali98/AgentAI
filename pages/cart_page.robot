*** Settings ***
Documentation    Page object containing locators and getter actions for the Cart Page.
...              No assertions are contained within this file.
Library          SeleniumLibrary

*** Variables ***
${PAGE_TITLE}          class=title
${CART_ITEM_NAME}      class=inventory_item_name
${BTN_REMOVE}          xpath=//button[text()='Remove']
${BTN_CHECKOUT}        id=checkout
${CART_URL}             https://www.saucedemo.com/cart.html

*** Keywords ***
#Get Cart Page Title
 #   ${title}=    Get Text    ${PAGE_TITLE}
  #  RETURN    ${title}

Get Added Item Name In Cart
    ${item_name}=    Get Text    ${CART_ITEM_NAME}
    RETURN    ${item_name}

Click Remove Button
    Click Button    ${BTN_REMOVE}

Click Checkout Button
    Click Button    ${BTN_CHECKOUT}

Get Cart Items Count
    ${count}=    Get Element Count    ${CART_ITEM_NAME}
    RETURN    ${count}
    
Get Current Page URL 
    ${url}=    Get Location    
    RETURN    ${url}