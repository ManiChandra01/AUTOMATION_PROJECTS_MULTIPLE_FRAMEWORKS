*** Settings ***
Documentation        End to end API Automation for herokuapp
Resource    ../Common/keywords.robot

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