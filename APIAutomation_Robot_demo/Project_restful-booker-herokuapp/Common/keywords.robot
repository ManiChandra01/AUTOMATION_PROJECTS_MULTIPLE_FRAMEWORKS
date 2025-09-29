*** Settings ***

Resource   common.robot

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