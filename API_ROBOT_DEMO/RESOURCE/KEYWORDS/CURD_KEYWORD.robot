*** Settings ***
Resource    ../../LIBRARY/common.robot
Resource    ../VARIABLE/Common_variable.robot


*** Keywords ***
Generating the test_json with all feilds
    [arguments]     ${Resquest_Json}        ${Payload_name}
    set log level  DEBUG
    ${Resquest}=    load json from file          ${Resquest_json}
    ${Final_payload}    get from dictionary       ${Resquest}        ${Payload_name}
    log  ${Final_payload}
    set global variable     ${Final_payload}

Execute POST Request And Fetch Response
       [arguments]     ${url}
       Create Session  POST_demo    ${url}
       ${payload}    set to dictionary     ${Final_payload}
       ${response}  Post On Session   POST_demo     ${url}  json=${payload}
       log     ${response.json()}
       ${responsesbody}=   set variable  ${response.json()}







#
#Creating endpoint for PUT/GET/PATCH API
#    [Arguments]     ${uri}
#
#Create Demo Session
#    Create Session    get_demo    ${base_url}${query_parametert}
#
#Get phones
#    ${response}=   GET On Session    get_demo    /
#    [Return]    ${response}
#
#Log API Response
#    [Arguments]    ${response}
#    Log To Console    ${response.status_code}
#    Log To Console    ${response.content}
#    Log To Console    ${response.json()}
#    Log To Console    ${response.headers}
#    Log    ${response.status_code}
#    Log    ${response.content}
#    Log    ${response.json()}
#    Log    ${response.headers}
#
#Validate Status Code
#    [Arguments]    ${response}    ${expected_status}
#    ${status_code}=   Convert To String    ${response.status_code}
#    Should Be Equal    ${status_code}    ${expected_status}
#    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
#
#Validate Headers
#    [Arguments]    ${response}    ${expected_server}
#    ${header_X}=   Get From Dictionary    ${response.headers}    Server
#    Should Be Equal    ${header_X}    ${expected_server}
#
#Validate Response Payload
#    [Arguments]    ${response}
#    ${jsonResponse}=  Set Variable   ${response.json()}
#    ${ids}=    Get Value From Json    ${jsonResponse}    $..id
#    ${names}=  Get Value From Json    ${jsonResponse}    $..name
#    ${ids_Extract_Index_wise}=  Get From List    ${ids}    0
#    Should Be Equal    ${ids_Extract_Index_wise}    3
#    Should Contain    ${names}    Apple iPhone 12 Pro Max