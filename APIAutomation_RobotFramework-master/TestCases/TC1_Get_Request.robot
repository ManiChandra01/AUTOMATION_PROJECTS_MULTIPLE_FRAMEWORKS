*** Settings ***

Library   RequestsLibrary
Library   Collections
Library   JSONLibrary
Resource  ../Utils/common_Utils.robot

*** Variables ***

${base_url}   https://simple-books-api.glitch.me
${get_status}  /status
${get_books}   /books
${book_type}   non-fiction
${getbooksParams}    /books?type=non-fiction
${expected_message}   Welcome to the Simple Books API.   # Variable for the expected message
${getSingleBook}   /books/5

*** Test Cases ***
TC001_WelcomeToBookApi
        Create Session    welcomePage    ${base_url}
        ${response}=   GET On Session    welcomePage    /

        #Print status code, response body and headers in console
        Log To Console    ${response.status_code}
        Log To Console    ${response.content}
        Log To Console    ${response.json()}
        Log To Console    ${response.headers}

        #Assertions
        ${status_code}=   convert to string    ${response.status_code}
        ${response_body}=   convert to string    ${response.content}
        ${header_X}=   Get From Dictionary  ${response.headers}    X-Powered-By
        #Assertion: Status Code
        Should Be Equal    ${status_code}    200
        Should Be Equal As Strings    ${response.status_code}    200

        #Assertion: Headers
        Should Be Equal    ${header_X}    Express

        #Assertion: Response Payload
        ${jsonResponse}=  set Variable   ${response.json()}
        @{msg}=  Get Value From Json    ${jsonResponse}    message
        ${msgString}=  Get From List    ${msg}    0
        Should Be Equal    ${msgString}    ${expected_message}
        Should Contain    ${response_body}    Welcome to the Simple Books API

        #By creating custom keywords
        Verify Message Is include    ${response_body}    ${expected_message}
        Verify text is equal    ${msgString}    ${expected_message}

TC002_GetStatus
        Create Session    statusPage    ${base_url}
        ${response}=  GET On Session    statusPage    ${get_status}
        ${status_code}=   convert to string    ${response.status_code}
        Should Be Equal    ${status_code}    200
        Verify JSON payload    ${response}    status    OK

#Query Parameters
TC003_GetListOfBooks
        Create Session    books    ${base_url}
        ${params}=   Create Dictionary   type=${book_type}
        ${response}=  GET On Session   books    ${get_books}   params=${params}
        Should Be Equal As Strings     ${response.status_code}   200
        ${book_id}=  Get Data From JSON  ${response}  [1].id
        Log To Console    ${book_id}
        ${book_id_value}=    Get From List    ${book_id}    0
        ${book_id_string}=   convert to string   ${book_id_value}
        Verify text is equal     ${book_id_string}    5


#*** Keywords ***
#Verify Message Is include
#    [Arguments]    ${actual}    ${expected}
#    Should contain    ${actual}    ${expected}
#
#Verify text is equal
#    [Arguments]   ${actual}    ${exp}
#    Should Be Equal    ${actual}    ${exp}
#
#Verify JSON payload
#     [Arguments]  ${response}   ${jsonpath}  ${expected_message}
#     ${jsonResponse}=  set Variable   ${response.json()}
#     @{msg}=  Get Value From Json    ${jsonResponse}    ${jsonpath}
#     ${msgString}=  Get From List    ${msg}    0
#     Should Be Equal    ${msgString}    ${expected_message}
#
#Get Data From JSON
#    [Arguments]  ${response}  ${jsonpath}
#    ${jsonResponse}=  set Variable   ${response.json()}
#    ${msg}=  Get Value From Json  ${jsonResponse}  ${jsonpath}
#    [Return]  ${msg}