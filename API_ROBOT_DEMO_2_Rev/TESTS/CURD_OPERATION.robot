*** Settings ***
Resource    ../LIBRARY/common.robot
Resource    ../RESOURCE/KEYWORDS/CURD_KEYWORD.robot
Resource    ../RESOURCE/VARIABLE/Common_variable.robot

*** Test Cases ***
TC 1 - Create the dummy POST resquest
    [Documentation]     In ths request we are going to perform POST request in API Testing
     Creating the request payload       ${payload}      POST_DATA
     Hitting/Execute POST Request And Fetch Response with valid Url     ${base_url}
     Validation check from the responses body   ${post_response}     200

TC 2 - Validate the resposes After GET request
    Hitting/Execute GET Request And Fetch Response with valid Url   ${base_url}

TC 3 - Validate the resposes After PUT request
    Creating the request payload       ${payload}      POST_DATA
    set to dictionary  ${Final_payload ['data']}        year=33333Nitka
    Hitting/Execute PUT Request And Fetch Response with valid Url       ${base_url}      ${Final_payload}
    Hitting/Execute GET Request And Fetch Response with valid Url   ${base_url}

TC 4 - Validate the resposes After Delete request
    Creating the request payload       ${payload}      POST_DATA
    Hitting/Execute DELETE Request And Fetch Response with valid Url    ${base_url}     ${Final_payload}
#    Hitting/Execute GET Request And Fetch Response with valid Url   ${base_url}

