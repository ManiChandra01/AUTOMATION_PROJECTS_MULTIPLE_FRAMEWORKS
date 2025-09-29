*** Settings ***
Documentation      A simple health check endpoint to confirm whether the API is up and running
Library   RequestsLibrary
Library    Collections

*** Variables ***
${base_url}  https://restful-booker.herokuapp.com
${ping_endpoint}   /ping

*** Test Cases ***
TC_Verify_API_is_up_and_running_by_executing_health_job
        [Tags]   SmokeTest
        Create Session    ping    ${base_url}   verify=true
        ${response}=  Get On Session   ping  ${ping_endpoint}
        Log   ${response.content}

        #Assertions
        Should Be Equal As Strings    ${response.status_code}    201
        ${response_payload}=  convert to string   ${response.content}
        Should Contain    ${response_payload}    Created
        
TC_Verify_API_is_up_and_running_by_executing_health_job_using_Head_Method
        [Tags]   SmokeTest
        Create Session    ping    ${base_url}   verify=true
        ${response}=  Head On Session   ping  ${ping_endpoint}

        #Assertions
        Should Be Equal As Strings    ${response.status_code}    201
        ${header_1}=   Get From Dictionary    ${response.headers}    Server
        ${header_2}=   Get From Dictionary    ${response.headers}    Connection
        ${header_3}=   Get From Dictionary    ${response.headers}    Content-Type

        Should Be Equal    ${header_1}    Cowboy
        Should Be Equal    ${header_2}    keep-alive
        Should Be Equal    ${header_3}    text/plain; charset=utf-8