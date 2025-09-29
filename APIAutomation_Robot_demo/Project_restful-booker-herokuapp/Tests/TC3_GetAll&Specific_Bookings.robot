*** Settings ***
Documentation      API Test for getting id's for all bookings and specific bookings
Library   RequestsLibrary
Library    Collections
Library   JSONLibrary

*** Variables ***
${base_url}  https://restful-booker.herokuapp.com
${booking_endpoint}   /booking
${counter}              ${1}

*** Test Cases ***

TC1_Verify_All_Bookings
        [Documentation]      Returns the ids of all the bookings that exist within the API
        [Tags]   SmokeTest
        Create Session    AllBookings    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   AllBookings  ${booking_endpoint}

        @{booking_Ids} =   Create List
        FOR    ${element}    IN    @{response.json()}
           Insert Into List    ${booking_Ids}    ${counter}    ${element}[bookingid]
           ${counter}=  Set Variable    ${counter+1}
        END

        ${first_bookingId}=    Get From List    ${booking_Ids}    0
        Log To Console    First booking id: ${first_bookingId}
        ${bookings_num}=   Set Variable      Number of bookings:    ${counter}
        Log To Console    ${bookings_num}
        #Assertions
        Should Be Equal As Strings    ${response.status_code}    200

        Set Suite Variable    ${booking_Ids}     ${booking_Ids}
        Set Suite Variable    ${first_bookingId}     ${first_bookingId}

TC2_Get_Booking_Details_Using_Id_as_path_parameter
       [Documentation]  Get and save booking details such as first name, last name, dates for further use
       [Tags]  SmokeTest
       Create Session    bookingDetails    ${base_url}  verify=true  disable_warnings=true
       ${response}=  GET On Session   bookingDetails   ${booking_endpoint}/${first_bookingId}
       Log   ${response.content}
       Should Be Equal As Strings    ${response.status_code}    200

       ${firstName}=  Get Data From JSON  ${response}  firstname
       ${lastName}=  Get Data From JSON  ${response}  lastname
       ${checkinDate}=  Get Data From JSON  ${response}  bookingdates.checkin
       ${checkoutDate}=  Get Data From JSON  ${response}  bookingdates.checkout
       Set Suite Variable    ${firstName}     ${firstName}
       Set Suite Variable    ${lastName}     ${lastName}
       Set Suite Variable    ${checkinDate}     ${checkinDate}
       Set Suite Variable    ${checkoutDate}     ${checkoutDate}

TC3_Verify_Specific_Bookings_Using_FirstName_LastName_As_Query_Parameters
        [Documentation]      Returns the ids of all the bookings that exist within the API for specified first name and last name
        [Tags]   SmokeTest
        ${query_params}=  Create Dictionary  firstname=${firstName}  lastname=${lastName}
        Create Session    SpecificBookings    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   SpecificBookings  ${booking_endpoint}  params=${query_params}

        @{booking_Ids} =   Create List
        FOR    ${element}    IN    @{response.json()}
           Insert Into List    ${booking_Ids}    ${counter}    ${element}[bookingid]
           ${counter}=  Set Variable    ${counter+1}
        END

        ${bookings_num}=   Set Variable      Number of bookings:    ${counter}
        Log To Console    ${bookings_num}
        #Assertions
        Should Be Equal As Strings    ${response.status_code}    200

TC4_Verify_Specific_Bookings_Using_ChcekinDate_As_Query_Parameter
        [Documentation]      Returns the ids of all the bookings that exist within the API for specified date
        [Tags]   SmokeTest
        ${query_params}=  Create Dictionary  checkin=${checkinDate}
        Create Session    SpecificBookings    ${base_url}   disable_warnings=1
        ${response}=  Get On Session   SpecificBookings  ${booking_endpoint}  params=${query_params}
        Should Be Equal As Strings    ${response.status_code}    200
        @{booking_Ids} =   Create List
        FOR    ${element}    IN    @{response.json()}
           Insert Into List    ${booking_Ids}    ${counter}    ${element}[bookingid]
           ${counter}=  Set Variable    ${counter+1}
        END

        ${bookings_num}=   Set Variable      Number of bookings:    ${counter}
        Log To Console    ${bookings_num}

TC5_Verify_Booking_endpoint_methods
        [Documentation]      Returns list of HTTP methods that exist within the API
        [Tags]   RegressionTest
        Create Session    bookingMethods    ${base_url}   disable_warnings=1
        ${response}=  Options On Session   bookingMethods  ${booking_endpoint}
        Log To Console   Allowed HTTP methods are: ${response.content}
        #Assertions
        Should Be Equal As Strings    ${response.status_code}    200

*** Keywords ***
Get Data From JSON
        [Arguments]     ${response}   ${json_path}
        ${json_response}=  Set Variable  ${response.json()}
        ${value}=  Get Value From Json  ${json_response}  ${json_path}
        [Return]  ${value}