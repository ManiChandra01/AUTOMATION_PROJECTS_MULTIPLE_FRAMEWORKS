*** Settings ***
Resource    ../LIBRARY/common.robot
Resource    ../RESOURCE/KEYWORDS/CURD_KEYWORD.robot
Resource    ../RESOURCE/VARIABLE/Common_variable.robot


#*** Test Cases ***
#TC001_WelcomeToBookApi
#        Create Session    get_demo    ${base_url}${query_parametert}
#        ${response}=   GET On Session    get_demo    /
#
#        #Print status code, response body and headers in console
#        Log To Console    ${response.status_code}
#        Log To Console    ${response.content}
#        Log To Console    ${response.json()}
#        Log To Console    ${response.headers}
#
#        Log    ${response.status_code}
#        Log    ${response.content}
#        Log    ${response.json()}
#        Log    ${response.headers}
#
#        #Assertions
#        ${status_code}=   convert to string    ${response.status_code}
#        ${response_body}=   convert to string    ${response.content}
#        ${header_X}=   Get From Dictionary  ${response.headers}    Server
#        #Assertion: Status Code
#        Should Be Equal    ${status_code}    200
#        Should Be Equal As Strings    ${response.status_code}    200
#
#        #Assertion: Headers
#        Should Be Equal    ${header_X}    cloudflare
#
#        #Assertion: Response Payload
#        ${jsonResponse}=  set Variable   ${response.json()}
#        ${ids}=    Get Value From Json    ${jsonResponse}    $..id
#        ${names}=   get value from json     ${jsonResponse}    $..name
#        ${ids_Extract_Index_wise}=  Get From List    ${ids}    0
#        Should Be Equal    ${ids_Extract_Index_wise}    3
#        Should Contain    ${names}    Apple iPhone 12 Pro Max


#*** Test Cases ***
#TC001_Welcome_RobotPhonestore_API_validate
#    Create Demo Session
#    ${response}=    Get phones
#    Log API Response    ${response}
#    Validate Status Code    ${response}    200
#    Validate Headers    ${response}    cloudflare
#    Validate Response Payload    ${response}

*** Test Cases ***
#TC-01 Post MacBook Data
#    [Documentation]    This test posts MacBook data to the API
#    Create Session    mysession    ${base_url}
#    ${body}=           Get File    ${payload}
#    ${response}=       POST On Session    mysession    /    json=${body}
#    Log     \nResponse Status: ${response.status_code}
#    Log     \nResponse Body: ${response.json()}
#    Should Be Equal As Integers    ${response.status_code}    200



TC-01 Post MacBook Data
    [Documentation]    This test posts MacBook data to the API
    Generating the test_json with all feilds    ${payload}
    Execute POST Request And Fetch Response       ${base_url}

