*** Settings ***
Resource    ../pages/login_page.robot
Library     SeleniumLibrary

*** Keywords ***
Login To Application
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LOGIN_USERNAME}    10s
    Input Text      ${LOGIN_USERNAME}    ${username}
    Wait Until Element Is Visible    ${LOGIN_PASSWORD}    10s
    Input Text      ${LOGIN_PASSWORD}    ${password}
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    10s
    Click Element   ${LOGIN_BUTTON}
    Sleep    2s 