*** Settings ***
Documentation      API Test for creating the auth token
Library   RequestsLibrary
Library    Collections

*** Variables ***
${base_url}  https://restful-booker.herokuapp.com
${auth_endpoint}   /auth
${username}  admin
${correct_pwd}  password123
${incorrect_pwd}  yuyrtuop
${CONTENT_TYPE}         application/json
${error_msg}   Bad credentials


*** Test Cases ***
TC_Verify_Successfully_Creation_Of_Auth_Token_Using_Valid_Credentials
        [Documentation]      Sucessfully create and store auth token as a suite variable
        [Tags]   SmokeTest
        Create Session    fetch_token    ${base_url}   disable_warnings=1
        ${headers}=   Create Dictionary   Content-Type=${CONTENT_TYPE}  User-Agent=RobotFramework
        ${request_payload}  Create Dictionary   username=${username}   password=${correct_pwd}
        ${response}=  Post On Session   fetch_token  ${auth_endpoint}   json=${request_payload}  headers=${headers}
        Log    ${response.content}

        #Assertions
        Should Be Equal As Strings    ${response.status_code}    200
        ${response_payload}=   Convert To String    ${response.content}
        Should Contain    ${response_payload}    token

        #Get Token and store as suite variable
        ${token}=           Get From Dictionary     ${response.json()}      token
        Log To Console    ${token}
        Set Suite Variable    ${token}          ${token}

TC_Verify_Token_Creation_Failure_Using_Bad_Creds
        [Documentation]      Verify the error message and non-creation of auth token for bad credentials
        [Tags]   NegativeScenario
        Create Session    badCreds    ${base_url}   disable_warnings=1
        ${headers}=   Create Dictionary   Content-Type=${CONTENT_TYPE}  User-Agent=RobotFramework
        ${request_payload}  Create Dictionary   username=${username}   password=${incorrect_pwd}
        ${response}=  Post On Session   badCreds  ${auth_endpoint}   json=${request_payload}  headers=${headers}
        Log    ${response.content}

        #Assertions
        Should Be Equal As Strings    ${response.status_code}    200
        ${response_payload}=   Convert To String    ${response.content}
        Should Contain    ${response_payload}    ${error_msg}
        Should Not Contain    ${response_payload}    token
        ${msg}=           Get From Dictionary     ${response.json()}      reason
        Should Be Equal As Strings    ${msg}    ${error_msg}