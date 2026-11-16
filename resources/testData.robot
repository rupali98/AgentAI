*** Settings ***
Documentation    Global variables and configuration settings for SauceDemo automation.
Resource        ../resources/BrowserManager.robot
Resource         ../pages/login_page.robot

*** Variables ***
# Application URLs & Browser Config
${URL}                  https://www.saucedemo.com/
${BROWSER}              chrome
${TIMEOUT}              10s
${PRODUCT_URL}          https://www.saucedemo.com/inventory.html

${PDP_URL_PREFIX}       https://www.saucedemo.com/inventory-item.html?id=


# Target Product IDs for Testing
${SAUCE_LABS_BACKPACK_ID}    4

# Static UI Expected Values
${EXPECTED_ADD_TO_CART_TXT}  Add to cart
${EXPECTED_REMOVE_TXT}       Remove

# System Test Users
${VALID_USER}        standard_user
${VALID_PASSWORD}       secret_sauce
${LOCKED_OUT_USER}      locked_out_user
${PROBLEM_USER}         problem_user
${PERF_GLITCH_USER}     performance_glitch_user
${INVALID_PASSWORD}     invalid_pass



*** Keywords ***
Open Application and Login Standard User
    Launch Browser
    Login To Application    ${VALID_USER}    ${VALID_PASSWORD}