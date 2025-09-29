*** Settings ***
Documentation      API Test for adding and verifying the new booking
Library   RequestsLibrary
Library   Collections
Library   JSONLibrary
Library   ../Utilities/CustomLibrary.py
Library  OperatingSystem
Library  String
Library    os

*** Variables ***
${base_url}           https://restful-booker.herokuapp.com
${booking_endpoint}   /booking
${checkin}            2023-08-30
${checkout}           2023-09-10
${firstname}          India
${lastname}           Bharat
${counter}            ${1}
*** Test Cases ***

TC1_Verify_successful_creation_of_new_booking
        [Documentation]      Creates new booking
        [Tags]   SmokeTest
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
        Log   ${response.content}
        Should Be Equal As Strings    ${response.status_code}    200
        ${newBookingId}=   Get Data From JSON  ${response}  bookingid
        Log To Console   Newly created booking id is: ${newBookingId}
        Set Global Variable    ${newBookingId}   ${newBookingId}
        Verify value in JSON    ${response}  booking.firstname   ${firstname}
        Verify value in JSON    ${response}  booking.lastname   ${lastname}
        Verify value in JSON    ${response}  booking.bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  booking.bookingdates.checkout   ${checkout}

# create custom functions in python and call them as below
        ${random_email} =    generate_random_email
        Log To Console   Random Email: ${random_email}

        ${current_date} =    Get Current Date
        Log To Console    Current Date: ${current_date}

        ${random_name} =    Generate Random Name
        Log To Console    Random Name: ${random_name}

TC2_Verify_Booking_details_using_newly_created_booking_id
       [Documentation]  Verify booking details for newly added booking
       [Tags]  SmokeTest
       Create Session    newBookingDetails    ${base_url}  verify=true  disable_warnings=true
       ${response}=  GET On Session   newBookingDetails   ${booking_endpoint}/${newBookingId}
       Log   ${response.content}
       Should Be Equal As Strings    ${response.status_code}    200

        Verify value in JSON    ${response}  firstname   ${firstname}
        Verify value in JSON    ${response}  lastname   ${lastname}
        Verify value in JSON    ${response}  bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  bookingdates.checkout   ${checkout}

TC3_Get_New_Booking_ID_By_Name
        [Documentation]      Returns the id of the new booking using first name
        [Tags]   SmokeTest
        ${query_params}=  Create Dictionary  firstname=${firstname}
        Create Session    getNewBooking    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   getNewBooking  ${booking_endpoint}  params=${query_params}
        Should Be Equal As Strings    ${response.status_code}    200
        Log To Console    ${response.content}
        @{bookingIds}=   Create List
        FOR    ${element}    IN    @{response.json()}
            Insert Into List    ${bookingIds}    ${counter}    ${element}[bookingid]
            ${counter}=   Set Variable    ${counter+1}
        END
        List Should Contain Value    ${bookingIds}    ${newBookingId}



TC4_Get_New_Booking_ID_By_Booking_date
        [Documentation]      Returns the id of the new booking using checkin date
        [Tags]   SmokeTest
        ${query_params}=  Create Dictionary  checkin=${checkin}
        Create Session    getNewBooking    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   getNewBooking  ${booking_endpoint}  params=${query_params}
        Should Be Equal As Strings    ${response.status_code}    200
        Log To Console    ${response.content}

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