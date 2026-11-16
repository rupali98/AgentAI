Here is a complete, production-ready Page Object Model (POM) automation framework built with **Robot Framework**, **SeleniumLibrary**, and **DataDriver (Excel)** for the **SauceDemo Checkout Scenario**.

---

### File Structure Overview
```text
├── resources/
│   └── testData.robot
├── pages/
│   ├── login_page.robot
│   ├── inventory_page.robot
│   ├── cart_page.robot
│   └── checkout_page.robot
├── data/
│   └── LoginData.xlsx
└── tests/
    └── checkout_tests.robot
```

---

### 1. `resources/testData.robot`
Contains global/common configuration variables used across the project.

```robotframework
*** Variables ***
${URL}                  https://www.saucedemo.com
${BROWSER}              chrome
${EXCEL_FILE_PATH}      ${CURDIR}/../data/LoginData.xlsx
${SUCCESS_HEADER_TEXT}  Thank you for your order!
```

---

### 2. `pages/login_page.robot`
Contains locators and interaction keywords for the Login Page.

```robotframework
*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/testData.robot

*** Variables ***
${TXT_USERNAME}        id=user-name
${TXT_PASSWORD}        id=password
${BTN_LOGIN}           id=login-button

*** Keywords ***
Open SauceDemo Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Enter Username
    [Arguments]    ${username}
    Input Text    ${TXT_USERNAME}    ${username}

Enter Password
    [Arguments]    ${password}
    Input Text    ${TXT_PASSWORD}    ${password}

Click Login Button
    Click Button    ${BTN_LOGIN}
```

---

### 3. `pages/inventory_page.robot`
Contains locators and interaction keywords for the Inventory/Products Page.

```robotframework
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BTN_ADD_TO_CART_BACKPACK}    id=add-to-cart-sauce-labs-backpack
${ICON_CART}                   class=shopping_cart_link

*** Keywords ***
Add Backpack To Cart
    Click Button    ${BTN_ADD_TO_CART_BACKPACK}

Click Shopping Cart Icon
    Click Element    ${ICON_CART}
```

---

### 4. `pages/cart_page.robot`
Contains locators and interaction keywords for the Cart Page.

```robotframework
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BTN_CHECKOUT}    id=checkout

*** Keywords ***
Click Checkout Button
    Click Button    ${BTN_CHECKOUT}
```

---

### 5. `pages/checkout_page.robot`
Contains locators and interaction keywords for all Checkout steps (Information, Overview, Complete). *No assertions are included here.*

```robotframework
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Step One Locators
${TXT_FIRST_NAME}        id=first-name
${TXT_LAST_NAME}         id=last-name
${TXT_POSTAL_CODE}       id=postal-code
${BTN_CONTINUE}          id=continue

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
```

---

### 6. `tests/checkout_tests.robot`
Contains the test suite utilizing the `DataDriver` library for Excel data-driven testing. **All assertions are kept strictly inside this test file.**

```robotframework
*** Settings ***
Documentation    Suite to validate the complete checkout workflow using Excel-driven data.
Library          SeleniumLibrary
Library          DataDriver    file=../data/LoginData.xlsx    sheet_name=CheckoutData

Resource         ../resources/testData.robot
Resource         ../pages/login_page.robot
Resource         ../pages/inventory_page.robot
Resource         ../pages/cart_page.robot
Resource         ../pages/checkout_page.robot

Test Setup       Open SauceDemo Login Page
Test Teardown    Close Browser
Test Template    Successful Checkout Workflow

*** Test Cases ***
Verify User Can Complete Checkout Scenario With Excel Data    ${username}    ${password}    ${firstName}    ${lastName}    ${postalCode}

*** Keywords ***
Successful Checkout Workflow
    [Arguments]    ${username}    ${password}    ${firstName}    ${lastName}    ${postalCode}

    # 1. Login Step
    Enter Username    ${username}
    Enter Password    ${password}
    Click Login Button

    # Assert Login Success
    Location Should Contain    inventory.html

    # 2. Add Product and Proceed to Checkout
    Add Backpack To Cart
    Click Shopping Cart Icon
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
```

---

### 7. `data/LoginData.xlsx` (Data Structure Representation)

Create an Excel file named **`LoginData.xlsx`** inside the `data/` directory with a worksheet named **`CheckoutData`**.

#### Excel Sheet Structure (`CheckoutData`):

| ${username} | ${password} | ${firstName} | ${lastName} | ${postalCode} |
| :--- | :--- | :--- | :--- | :--- |
| standard_user | secret_sauce | John | Doe | 12345 |
| performance_glitch_user | secret_sauce | Jane | Smith | 90210 |

---

### Prerequisites & Execution Instructions

1. **Install Required Packages:**
   ```bash
   pip install robotframework robotframework-seleniumlibrary robotframework-datadriver pandas openpyxl
   ```

2. **Run Tests:**
   ```bash
   robot -d results tests/checkout_tests.robot
   ```