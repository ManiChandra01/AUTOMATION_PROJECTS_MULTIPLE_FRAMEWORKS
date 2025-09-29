*** Settings ***
Documentation      API Test for updating and verifying the new booking {Put, Patch}
Library   RequestsLibrary
Library   Collections
Library   JSONLibrary
Library    Process


*** Variables ***
${base_url}           https://restful-booker.herokuapp.com
${booking_endpoint}   /booking
${checkin}            2023-08-30
${checkout}           2023-09-10
${old_firstname}      India
${old_lastname}       Bharat
${firstname}          Hindustan
${lastname}           Jai Hind
${patch_firstname}    Konkan
${Patch_lastname}     Maharashtra
${auth_endpoint}   /auth
${username}  admin
${correct_pwd}  password123
${CONTENT_TYPE}         application/json

*** Test Cases ***

TC1_Verify_successful_updation_of_new_booking_Via_Put_method
        [Documentation]      Updates the booking via Put Request
        [Tags]   RegressionTest
        ${token}=  Create Auth token
        Set Suite Variable    ${token}          ${token}
        ${id}=  Get newly created booking id
        Set Suite Variable    ${id}          ${id}

        ${bookingDates}=  Create Dictionary
...                       checkin= ${checkin}
...                       checkout= ${checkout}

        ${request_payload}=   Create Dictionary
...                           firstname=${firstname}
...                           lastname=${lastname}
...                           totalprice= 789
...                           depositpaid=true
...                           bookingdates=${bookingDates}
...                           additionalneeds=Breakfast

        ${request_headers}=   Create Dictionary  Content-Type=application/json  Cookie=token=${token}
        Create Session    updateBooking    ${base_url}   disable_warnings=1
        ${response}=  Put On Session   updateBooking  ${booking_endpoint}/${id}  json=${request_payload}  headers=${request_headers}
        Log To Console  ${response.content}
        Should Be Equal As Strings    ${response.status_code}    200

        Verify value in JSON    ${response}  firstname   ${firstname}
        Verify value in JSON    ${response}  lastname   ${lastname}
        Verify value in JSON    ${response}  bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  bookingdates.checkout   ${checkout}
        ${response_payload}=  Convert To String    ${response.content}
        Should Not Contain    ${response_payload}    ${old_firstname}
        Should Not Contain    ${response_payload}    ${old_lastname}

TC2_Verify_successful_partial_updation_of_new_booking_Via_Patch_method
        [Documentation]      Partially Updates the booking via Patch Request
        [Tags]   RegressionTest

        ${bookingDates}=  Create Dictionary
...                       checkin= ${checkin}
...                       checkout= ${checkout}

        ${request_payload}=   Create Dictionary
...                           firstname=${patch_firstname}
...                           lastname=${patch_lastname}
...                           totalprice= 789
...                           depositpaid=true
...                           bookingdates=${bookingDates}
...                           additionalneeds=lunch

        ${request_headers}=   Create Dictionary  Content-Type=application/json  Cookie=token=${token}
        Create Session    partialUpdate    ${base_url}   disable_warnings=1
        ${response}=  Patch On Session   partialUpdate  ${booking_endpoint}/${id}  json=${request_payload}  headers=${request_headers}
        Log To Console  ${response.content}
        Should Be Equal As Strings    ${response.status_code}    200

        Verify value in JSON    ${response}  firstname   ${patch_firstname}
        Verify value in JSON    ${response}  lastname   ${patch_lastname}
        Verify value in JSON    ${response}  bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  bookingdates.checkout   ${checkout}
        ${response_payload}=  Convert To String    ${response.content}
        Should Not Contain    ${response_payload}    ${firstname}
        Should Not Contain    ${response_payload}    ${lastname}

*** Keywords ***
Get Data From JSON
        [Arguments]     ${response}   ${json_path}
        ${json_response}=  Set Variable  ${response.json()}
        ${value}=  Get Value From Json  ${json_response}  ${json_path}
        [Return]  ${value[0]}

Verify value in JSON
         [Arguments]     ${response}   ${json_path}  ${expectedValue}
         ${actualValue}=   Get Data From JSON  ${response}  ${json_path}
         Should Be Equal    ${actualValue}    ${expectedValue}

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
...                           firstname= ${old_firstname}
...                           lastname= ${old_lastname}
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