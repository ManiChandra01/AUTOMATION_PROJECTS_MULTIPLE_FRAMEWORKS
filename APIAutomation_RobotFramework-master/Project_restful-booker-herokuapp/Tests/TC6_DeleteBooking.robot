*** Settings ***
Documentation      API Test for deleting and verifying the booking not exists
Library   RequestsLibrary
Library   Collections
Library   JSONLibrary
Library    Process


*** Variables ***
${base_url}           https://restful-booker.herokuapp.com
${booking_endpoint}   /booking
${checkin}            2023-08-30
${checkout}           2023-09-10
${firstname}      India
${lastname}       Bharat
${auth_endpoint}   /auth
${username}  admin
${correct_pwd}  password123
${CONTENT_TYPE}         application/json

*** Test Cases ***

TC1_Verify_successful_deletion_of_new_booking
        [Documentation]      Deletes the booking
        [Tags]   SanityTest
        ${token}=  Create Auth token
        Set Suite Variable    ${token}          ${token}
        ${id}=  Get newly created booking id
        Set Suite Variable    ${id}          ${id}

        ${request_headers}=   Create Dictionary  Content-Type=application/json  Cookie=token=${token}
        Create Session    updateBooking    ${base_url}   disable_warnings=1
        ${response}=  Delete On Session   updateBooking  ${booking_endpoint}/${id}   headers=${request_headers}
        Log To Console  ${response.content}
        Should Be Equal As Strings    ${response.status_code}    201
        ${response_payload}=  Convert To String    ${response.content}
        Should Contain    ${response_payload}    Created
        Should Not Contain    ${response_payload}    ${firstname}
        Should Not Contain    ${response_payload}    ${lastname}

*** Keywords ***
Get Data From JSON
        [Arguments]     ${response}   ${json_path}
        ${json_response}=  Set Variable  ${response.json()}
        ${value}=  Get Value From Json  ${json_response}  ${json_path}
        [Return]  ${value[0]}

Create Auth token
        Create Session    fetch_token    ${base_url}   disable_warnings=1
        ${headers}=   Create Dictionary   Content-Type=${CONTENT_TYPE}  User-Agent=RobotFramework
        ${request_payload}  Create Dictionary   username=${username}   password=${correct_pwd}
        ${response}=  Post On Session   fetch_token  ${auth_endpoint}   json=${request_payload}  headers=${headers}
        ${token}=           Get From Dictionary     ${response.json()}      token
        Log To Console    ${token}
        [Return]  ${token}

Get newly created booking id
        ${bookingDates}=  Create Dictionary
...                       checkin= ${checkin}
...                       checkout= ${checkout}

        ${request_payload}=   Create Dictionary
...                           firstname= ${firstname}
...                           lastname= ${lastname}
...                           totalprice= 789
...                           depositpaid=true
...                           bookingdates=${bookingDates}
...                           additionalneeds= Breakfast

        ${request_headers}=   Create Dictionary  Content-Type=application/json  Accept=application/json
        Create Session    AddBooking    ${base_url}   disable_warnings=1
        ${response}=  Post On Session   AddBooking  ${booking_endpoint}  json=${request_payload}
        ${id}=   Get Data From JSON  ${response}  bookingid
        Log To Console   Newly created booking id is: ${id}
        [Return]   ${id}