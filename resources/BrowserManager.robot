*** Settings ***
Library             SeleniumLibrary
Resource            ../resources/testData.robot



*** Keywords ***
Launch Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    20s

Close Application
    Close Browser

