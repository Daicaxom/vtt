*** Variables ***
# Cách 1: Sử dụng class và placeholder
${LOGIN_USERNAME}    xpath://input[@placeholder='Username']
${LOGIN_PASSWORD}    xpath://input[@placeholder='Password']
${LOGIN_BUTTON}     xpath://button[text()=' Login ']

# Cách 2: Sử dụng full xpath
# ${LOGIN_USERNAME}    xpath://*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[1]/div/div[2]/input
# ${LOGIN_PASSWORD}    xpath://*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[2]/div/div[2]/input

# Cách 3: Sử dụng CSS selector
# ${LOGIN_USERNAME}    css:input[name='username']
# ${LOGIN_PASSWORD}    css:input[type='password'] 