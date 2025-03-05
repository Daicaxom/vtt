*** Settings ***
Library    SeleniumLibrary
Resource   ../pages/login_page.robot

*** Keywords ***
Open Orange HRM Website
    Open Browser    https://opensource-demo.orangehrmlive.com    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_USERNAME}    10s

Close Orange HRM Website
    Close Browser 