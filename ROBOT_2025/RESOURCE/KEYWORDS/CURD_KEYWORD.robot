*** Settings ***
Resource    ../../LIBRARY/common.robot
Resource    ../VARIABLE/Common_variable.robot

#
#${}= Variable == Scalar Variable
#
#@{List}= Create List  PM CM DM
#
#&{ }




*** Keywords ***
Generating the test_json with all feilds
    [arguments]     ${Resquest_Json}        ${payload_name}
    ${Resquest}=    load json from file          ${Resquest_json}
    ${Final_payload}=   get from dictionary     ${Resquest}     ${payload_name}
    log  ${Final_payload}
    set global variable     ${Final_payload}

#Execute POST Request And Fetch Response
#       [arguments]     ${url}
#       Create Session  POST_demo    ${url}
#       ${payload}    set to dictionary     ${Final_payload}
#       ${response}  Post On Session   POST_demo     ${url}  json=${payload}
#       log     ${response.json()}
#       ${responsesbody}=   set variable  ${response.json()}
Execute CURD Request And Fetch Response
    [Arguments]    ${url}
    Create Session    demo    ${url}
    ${payload}=    Set To Dictionary    ${Final_payload}
    ${response}=   Post On Session    demo    ${url}    json=${payload}
    Log    ${response.json()}
    ${responsebody}=    Set Variable    ${response.json()}
    ${id}=    Get From Dictionary    ${responsebody}    id
    Set Suite Variable    ${ID}    ${id}
    Log     ID returned from response: ${id}
Execute GET Request And Fetch Response
    [Arguments]    ${url}
    ${get_url}=    Catenate    SEPARATOR=/    ${url}    ${ID}
    ${get_response}=    Get On Session    demo    ${get_url}
    Log    ${get_response.json()}


Execute PUT Request
    [Arguments]    ${url}    ${payload}
    ${put_url}=    Set Variable    ${url}/${ID}
    ${response}=    Put On Session    demo    ${put_url}    json=${payload}
    Log    ${response.text}

Execute PATCH Request
    [Arguments]    ${url}    ${payload}
    ${patch_url}=    Set Variable    ${url}/${ID}
    ${response}=    PATCH On Session    demo    ${patch_url}    json=${payload}
    Log    ${response.text}

Execute delete Request
    [Arguments]    ${url}    ${payload}
    ${delete_url}=    Set Variable    ${url}/${ID}
    ${response}=    delete On Session    demo    ${delete_url}    json=${payload}
    Log    ${response.text}
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