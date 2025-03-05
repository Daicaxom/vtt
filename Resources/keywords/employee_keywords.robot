*** Settings ***
Resource    ../pages/employee_page.robot
Resource    ../data/job_titles.robot
Library     SeleniumLibrary
Library     String
Library     Collections
Library     BuiltIn
Library     random

*** Keywords ***
Navigate To PIM Page
    Wait Until Element Is Visible    ${PIM_MENU}    10s
    Click Element    ${PIM_MENU}
    Sleep    2s

Add New Employee
    [Arguments]    ${firstName}    ${lastName}    ${middleName}=${EMPTY}
    Wait Until Element Is Visible    ${ADD_EMPLOYEE_BUTTON}    10s
    Click Element    ${ADD_EMPLOYEE_BUTTON}
    Sleep    2s
    Wait Until Element Is Visible    ${FIRST_NAME_INPUT}    10s
    Input Text    ${FIRST_NAME_INPUT}    ${firstName}
    Run Keyword If    '${middleName}' != '${EMPTY}'    Run Keywords
    ...    Wait Until Element Is Visible    ${MIDDLE_NAME_INPUT}    10s    AND
    ...    Input Text    ${MIDDLE_NAME_INPUT}    ${middleName}
    Wait Until Element Is Visible    ${LAST_NAME_INPUT}    10s
    Input Text    ${LAST_NAME_INPUT}    ${lastName}
    Wait Until Element Is Visible    ${SAVE_BUTTON}    10s
    Click Element    ${SAVE_BUTTON}
    Sleep    3s
    Verify Employee Profile    ${firstName}    ${lastName}

Verify Employee Profile
    [Arguments]    ${firstName}    ${lastName}
    Wait Until Element Is Visible    ${PROFILE_NAME}    10s
    ${expected_name}=    Set Variable    ${firstName} ${lastName}
    Wait Until Element Contains    ${PROFILE_NAME}    ${expected_name}    10s    
    ...    msg=Employee name '${expected_name}' not found after 10 seconds
    ${actual_name}=    Get Text    ${PROFILE_NAME}
    Should Not Be Empty    ${actual_name}    msg=Employee name is empty
    Should Be Equal    ${actual_name}    ${expected_name}    
    ...    msg=Employee name verification failed. Expected: '${expected_name}', but got: '${actual_name}'
    Sleep    1s

Get Random Job Title
    ${random_index}=    Evaluate    random.randint(0, len($JOB_TITLES)-1)    random
    ${selected_title}=    Get From List    ${JOB_TITLES}    ${random_index}
    Wait Until Element Is Visible    ${JOB_TITLE_DROPDOWN}    10s
    Click Element    ${JOB_TITLE_DROPDOWN}
    Sleep    1s
    Wait Until Element Is Visible    xpath://span[text()='${selected_title}']    10s
    Click Element    xpath://span[text()='${selected_title}']
    [Return]    ${selected_title}

Search Employee By Job Title
    [Arguments]    ${jobTitle}=${EMPTY}
    ${selected_job_title}=    Set Variable If    
    ...    '${jobTitle}'=='${EMPTY}'    ${EMPTY}    ${jobTitle}
    
    IF    '${selected_job_title}'=='${EMPTY}'
        ${selected_job_title}=    Get Random Job Title
    ELSE
        # Verify job title is valid
        List Should Contain Value    ${JOB_TITLES}    ${jobTitle}    
        ...    msg=Invalid job title: '${jobTitle}'. Valid titles are: ${JOB_TITLES}
        Wait Until Element Is Visible    ${JOB_TITLE_DROPDOWN}    10s
        Click Element    ${JOB_TITLE_DROPDOWN}
        Sleep    1s
        Wait Until Element Is Visible    xpath://span[text()='${jobTitle}']    10s
        Click Element    xpath://span[text()='${jobTitle}']
    END
    
    Wait Until Element Is Visible    ${SEARCH_BUTTON}    10s
    Click Element    ${SEARCH_BUTTON}
    Sleep    2s
    Verify Search Results    ${selected_job_title}
    [Return]    ${selected_job_title}

Verify Search Results
    [Arguments]    ${expectedJobTitle}
    Wait Until Element Is Visible    ${TABLE_ROWS}    10s    OR    Wait Until Element Is Visible    ${NO_RECORDS_MESSAGE}    10s
    ${records_exist}=    Run Keyword And Return Status    Page Should Not Contain Element    ${NO_RECORDS_MESSAGE}
    
    IF    ${records_exist}
        @{job_titles}=    Get WebElements    ${JOB_TITLE_CELL}
        FOR    ${title}    IN    @{job_titles}
            Wait Until Element Is Visible    ${title}    10s
            ${actual_title}=    Get Text    ${title}
            Should Be Equal    ${actual_title}    ${expectedJobTitle}    
            ...    msg=Job title mismatch. Expected: ${expectedJobTitle}, but got: ${actual_title}
        END
        Log    Found ${records_exist} records with job title '${expectedJobTitle}'
    ELSE
        Page Should Contain Element    ${NO_RECORDS_MESSAGE}
        Log    No records found for job title '${expectedJobTitle}'
    END 