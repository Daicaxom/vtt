*** Settings ***
Resource          ../Resources/keywords/common_keywords.robot
Resource          ../Resources/keywords/login_keywords.robot
Resource          ../Resources/keywords/employee_keywords.robot
Test Setup        Open Orange HRM Website
Test Teardown     Close Orange HRM Website
Test Tags         employee

*** Test Cases ***
TC01 - Add New Employee
    [Documentation]    Verify that can add new employee successfully
    [Tags]    add_employee
    Given Login To Application    Admin    admin123
    When Navigate To PIM Page
    And Add New Employee    John    Doe    Smith
    Then Verify Employee Profile    John    Doe

TC02 - Search Employee By Job Title
    [Documentation]    Verify search employee functionality with different job titles
    [Tags]    search_employee
    [Template]    Verify Search Employee By Job Title
    # Test Data    Expected Result
    QA Engineer    # Search with specific job title
    ${EMPTY}       # Search with random job title
    Non Existent Job    # Search with non-existent job title

*** Keywords ***
Verify Search Employee By Job Title
    [Arguments]    ${job_title}
    Given Login To Application    Admin    admin123
    When Navigate To PIM Page
    ${selected_title}=    Search Employee By Job Title    ${job_title}
    Log    Selected/Input Job Title: ${selected_title} 