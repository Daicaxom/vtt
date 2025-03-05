*** Variables ***
${PIM_MENU}              xpath://span[text()='PIM']
${ADD_EMPLOYEE_BUTTON}    xpath://button[contains(.,'Add')]//i
${FIRST_NAME_INPUT}      xpath://input[@name='firstName']
${MIDDLE_NAME_INPUT}     xpath://input[@name='middleName']
${LAST_NAME_INPUT}       xpath://input[@name='lastName']
${SAVE_BUTTON}           xpath://button[text()=' Save ']

# Locator cho job title search
${JOB_TITLE_DROPDOWN}      xpath:/html/body/div/div[1]/div[2]/div[2]/div/div[1]/div[2]/form/div[1]/div/div[6]/div/div[2]/div/div/div[2]/i
${SEARCH_BUTTON}           xpath://button[text()=' Search ']

# Locator cho profile name
${PROFILE_NAME}           xpath://h6[contains(@class,'--strong')]

# Locator cho bảng kết quả
${TABLE_ROWS}            xpath://div[@role='row']
${NO_RECORDS_MESSAGE}    xpath://span[text()='No Records Found']
${JOB_TITLE_CELL}       xpath://div[@role='cell'][4]//div 