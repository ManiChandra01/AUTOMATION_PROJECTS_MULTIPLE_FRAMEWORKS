*** Settings ***
Documentation        End to end API Automation for herokuapp
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     OperatingSystem
Library     String
Library     os
Library     ../Utilities/CustomLibrary.py

*** Variables ***
${base_url}           https://restful-booker.herokuapp.com
${ping_endpoint}      /ping
${auth_endpoint}      /auth
${booking_endpoint}   /booking
${username}           admin
${correct_pwd}        password123
${incorrect_pwd}      yuyrtuop
${counter}            ${1}
${checkin}            2023-08-30
${checkout}           2023-09-10
${firstname}          India
${lastname}           Bharat
${put_firstname}      Hindustan
${put_lastname}       Jai Hind
${patch_firstname}    Konkan
${Patch_lastname}     Maharashtra

*** Test Cases ***
TC1_Verify_API_is_up_and_running_by_executing_health_job
        [Documentation]      ping server by exceuting health job using Get request
        [Tags]   Regression
        Ping server

TC2_Verify_API_is_up_and_running_by_executing_health_job_using_Head_Method
        [Documentation]      ping server by exceuting health job using Head request
        [Tags]   Regression
        Ping server using head method

TC3_Verify_Successfully_Creation_Of_Auth_Token_Using_Valid_Credentials
        [Documentation]      Sucessfully create and store auth token as a suite variable
        [Tags]   Smoke
        Creation of auth token using valid credentials

TC4_Verify_Token_Creation_Failure_Using_Bad_Creds
        [Documentation]      Verify the error message and non-creation of auth token for bad credentials
        [Tags]   Regression
        Failed Creation of auth token using invalid credentials

TC5_Verify_All_Bookings
        [Documentation]      Returns the ids of all the bookings that exist within the API
        [Tags]   Smoke
        Verify all bookings

TC6_Get_Booking_Details_Specific_Using_Id
        [Documentation]  Get and save booking details such as first name, last name, dates for further use
        [Tags]  Regression
        Get booking details using Id

TC7_Verify_Specific_Bookings_Using_FirstName_LastName_As_Query_Parameters
        [Documentation]      Returns the ids of all the bookings that exist within the API for specified first name and last name
        [Tags]   Regression
        Get booking details using firstname and lastname

TC8_Verify_Specific_Bookings_Using_ChcekinDate_As_Query_Parameter
        [Documentation]      Returns the ids of all the bookings that exist within the API for specified date
        [Tags]   Regression
        Get booking details using booking dates

TC9_Verify_Booking_endpoint_allowed_methods
        [Documentation]      Returns list of HTTP methods that exist within the API
        [Tags]   Regression
        Verify number of allowed methods for booking resource

TC10_Verify_successful_creation_of_new_booking
        [Documentation]      Creates new booking
        [Tags]   Smoke
        Creation of new booking

TC11_Verify_newly_created_booking_details_using_id
        [Documentation]  Verify booking details for newly added booking
        [Tags]  Smoke
        Verify newly created Booking details

TC12_Get_New_Booking_ID_By_Name
        [Documentation]      Returns the id of the new booking using first name
        [Tags]   Regression
        Verify new booking ID by Name

TC13_Get_New_Booking_ID_By_Booking_date
        [Documentation]      Returns the id of the new booking using checkin date
        [Tags]   Regression
        Verify new booking ID by booking date

TC14_Verify_successful_updation_of_new_booking_Via_Put_method
        [Documentation]      Updates the booking via Put Request
        [Tags]   Smoke
        Update and verify booking via Put method

TC15_Verify_successful_partial_updation_of_new_booking_Via_Patch_method
        [Documentation]      Partially Updates the booking via Patch Request
        [Tags]   Smoke
        Update and verify booking via Patch method

TC16_Verify_successful_deletion_of_new_booking
        [Documentation]      Deletes the booking
        [Tags]   Smoke
        Delete the booking

TC17_Creation_of_custom_library_and_calling_function_from_customLib
        [Documentation]      calling functions from custom library
        [Tags]   Sanity
        ${random_email} =    generate_random_email
        ${current_date} =    Get Current Date
        ${random_name} =    Generate Random Name
        Log    Random Email: ${random_email}, Random Name: ${random_name} , Current Date: ${current_date}

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

Ping server
        Create Session    ping    ${base_url}   verify=true
        ${response}=  Get On Session   ping  ${ping_endpoint}
        Log   ${response.content}
        Should Be Equal As Strings    ${response.status_code}    201
        ${response_payload}=  convert to string   ${response.content}
        Should Contain    ${response_payload}    Created

Ping server using head method
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

Creation of auth token using valid credentials
        Create Session    fetch_token    ${base_url}   disable_warnings=1
        ${headers}=   Create Dictionary   Content-Type=application/json  User-Agent=RobotFramework
        ${request_payload}  Create Dictionary   username=${username}   password=${correct_pwd}
        ${response}=  Post On Session   fetch_token  ${auth_endpoint}   json=${request_payload}  headers=${headers}
        Log    ${response.content}
        Should Be Equal As Strings    ${response.status_code}    200
        ${token}=           Get From Dictionary     ${response.json()}      token
        Set Suite Variable    ${token}          ${token}

Failed Creation of auth token using invalid credentials
        Create Session    badCreds    ${base_url}   disable_warnings=1
        ${headers}=   Create Dictionary   Content-Type=application/json  User-Agent=RobotFramework
        ${request_payload}  Create Dictionary   username=${username}   password=${incorrect_pwd}
        ${response}=  Post On Session   badCreds  ${auth_endpoint}   json=${request_payload}  headers=${headers}

        Should Be Equal As Strings    ${response.status_code}    200
        ${response_payload}=   Convert To String    ${response.content}
        Should Not Contain    ${response_payload}    token
        ${msg}=           Get From Dictionary     ${response.json()}      reason
        Should Be Equal As Strings    ${msg}    Bad credentials


Verify all bookings
        Create Session    AllBookings    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   AllBookings  ${booking_endpoint}
        @{booking_Ids} =   Create List
        FOR    ${element}    IN    @{response.json()}
           Insert Into List    ${booking_Ids}    ${counter}    ${element}[bookingid]
           ${counter}=  Set Variable    ${counter+1}
        END
        ${first_bookingId}=    Get From List    ${booking_Ids}    0
        Log    First booking id: ${first_bookingId}
        ${bookings_num}=   Set Variable      Number of bookings:    ${counter}
        Log    Number of bookings are: ${bookings_num}
        Should Be Equal As Strings    ${response.status_code}    200
        Set Suite Variable    ${first_bookingId}     ${first_bookingId}

Get booking details using Id
       Create Session    bookingDetails    ${base_url}  verify=true  disable_warnings=true
       ${response}=  GET On Session   bookingDetails   ${booking_endpoint}/${first_bookingId}
       Should Be Equal As Strings    ${response.status_code}    200
       ${firstName}=  Get Data From JSON  ${response}  firstname
       ${lastName}=  Get Data From JSON  ${response}  lastname
       ${checkinDate}=  Get Data From JSON  ${response}  bookingdates.checkin
       ${checkoutDate}=  Get Data From JSON  ${response}  bookingdates.checkout
       Set Suite Variable    ${firstName}     ${firstName}
       Set Suite Variable    ${lastName}     ${lastName}
       Set Suite Variable    ${checkinDate}     ${checkinDate}
       Set Suite Variable    ${checkoutDate}     ${checkoutDate}

Get booking details using firstname and lastname
        ${query_params}=  Create Dictionary  firstname=${firstName}  lastname=${lastName}
        Create Session    SpecificBookings    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   SpecificBookings  ${booking_endpoint}  params=${query_params}

        @{booking_Ids} =   Create List
        FOR    ${element}    IN    @{response.json()}
           Insert Into List    ${booking_Ids}    ${counter}    ${element}[bookingid]
           ${counter}=  Set Variable    ${counter+1}
        END

        ${bookings_num}=   Set Variable      Number of bookings for firstname and lastname:    ${counter}
        Log    ${bookings_num}

        Should Be Equal As Strings    ${response.status_code}    200

Get booking details using booking dates
        ${query_params}=  Create Dictionary  checkin=${checkinDate}
        Create Session    SpecificBookings    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   SpecificBookings  ${booking_endpoint}  params=${query_params}
        Should Be Equal As Strings    ${response.status_code}    200
        @{booking_Ids} =   Create List
        FOR    ${element}    IN    @{response.json()}
           Insert Into List    ${booking_Ids}    ${counter}    ${element}[bookingid]
           ${counter}=  Set Variable    ${counter+1}
        END
        ${bookings_num}=   Set Variable      Number of bookings for booking dates :    ${counter}
        Log    ${bookings_num}

Verify number of allowed methods for booking resource
        Create Session    bookingMethods    ${base_url}   disable_warnings=1
        ${response}=  Options On Session   bookingMethods  ${booking_endpoint}
        Log   Allowed HTTP methods are: ${response.content}
        Should Be Equal As Strings    ${response.status_code}    200

Creation of new booking
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
        Should Be Equal As Strings    ${response.status_code}    200
        ${newBookingId}=   Get Data From JSON  ${response}  bookingid
        Log   Newly created booking id is: ${newBookingId}
        Set Suite Variable    ${newBookingId}   ${newBookingId}
        Verify value in JSON    ${response}  booking.firstname   ${firstname}
        Verify value in JSON    ${response}  booking.lastname   ${lastname}
        Verify value in JSON    ${response}  booking.bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  booking.bookingdates.checkout   ${checkout}

Verify newly created Booking details
        Create Session    newBookingDetails    ${base_url}  verify=true  disable_warnings=true
        ${response}=  GET On Session   newBookingDetails   ${booking_endpoint}/${newBookingId}
        Should Be Equal As Strings    ${response.status_code}    200
        Verify value in JSON    ${response}  firstname   ${firstname}
        Verify value in JSON    ${response}  lastname   ${lastname}
        Verify value in JSON    ${response}  bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  bookingdates.checkout   ${checkout}

Verify new booking ID by Name
        ${query_params}=  Create Dictionary  firstname=${firstname}
        Create Session    getNewBooking    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   getNewBooking  ${booking_endpoint}  params=${query_params}
        Should Be Equal As Strings    ${response.status_code}    200
        @{bookingIds}=   Create List
        FOR    ${element}    IN    @{response.json()}
            Insert Into List    ${bookingIds}    ${counter}    ${element}[bookingid]
            ${counter}=   Set Variable    ${counter+1}
        END
        List Should Contain Value    ${bookingIds}    ${newBookingId}

Verify new booking ID by booking date
        ${query_params}=  Create Dictionary  checkin=${checkin}
        Create Session    getNewBooking    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   getNewBooking  ${booking_endpoint}  params=${query_params}
        Should Be Equal As Strings    ${response.status_code}    200

Update and verify booking via Put method
        ${bookingDates}=  Create Dictionary
...                       checkin= ${checkin}
...                       checkout= ${checkout}

        ${request_payload}=   Create Dictionary
...                           firstname=${put_firstname}
...                           lastname=${put_lastname}
...                           totalprice= 789
...                           depositpaid=true
...                           bookingdates=${bookingDates}
...                           additionalneeds=Breakfast

        ${request_headers}=   Create Dictionary  Content-Type=application/json  Cookie=token=${token}
        Create Session    updateBooking    ${base_url}   disable_warnings=1
        ${response}=  Put On Session   updateBooking  ${booking_endpoint}/${newBookingId}  json=${request_payload}  headers=${request_headers}

        Should Be Equal As Strings    ${response.status_code}    200
        Verify value in JSON    ${response}  firstname   ${put_firstname}
        Verify value in JSON    ${response}  lastname   ${put_lastname}
        Verify value in JSON    ${response}  bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  bookingdates.checkout   ${checkout}
        ${response_payload}=  Convert To String    ${response.content}
        Should Not Contain    ${response_payload}    ${firstname}
        Should Not Contain    ${response_payload}    ${lastname}

Update and verify booking via Patch method
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
        ${response}=  Patch On Session   partialUpdate  ${booking_endpoint}/${newBookingId}  json=${request_payload}  headers=${request_headers}
        Should Be Equal As Strings    ${response.status_code}    200
        Verify value in JSON    ${response}  firstname   ${patch_firstname}
        Verify value in JSON    ${response}  lastname   ${patch_lastname}
        Verify value in JSON    ${response}  bookingdates.checkin   ${checkin}
        Verify value in JSON    ${response}  bookingdates.checkout   ${checkout}
        ${response_payload}=  Convert To String    ${response.content}
        Should Not Contain    ${response_payload}    ${put_firstname}
        Should Not Contain    ${response_payload}    ${put_lastname}

Delete the booking
        ${request_headers}=   Create Dictionary  Content-Type=application/json  Cookie=token=${token}
        Create Session    updateBooking    ${base_url}   disable_warnings=1
        ${response}=  Delete On Session   updateBooking  ${booking_endpoint}/${newBookingId}   headers=${request_headers}
        Should Be Equal As Strings    ${response.status_code}    201
        ${response_payload}=  Convert To String    ${response.content}
        Should Contain    ${response_payload}    Created
        Should Not Contain    ${response_payload}    ${firstname}
        Should Not Contain    ${response_payload}    ${lastname}