*** Settings ***

Library   RequestsLibrary
Library   JSONLibrary
Library   Collections
Library   String
Library   BuiltIn
Resource    ../Utils/common_Utils.robot

*** Variables ***

${base_url}   https://simple-books-api.glitch.me
${fetch_accessToken}  /api-clients
${book_order}   /Orders

*** Test Cases ***
TC01_FetchTokenForPlacingOrder
        ${email}=      Create Random Email
        Log To Console    ${email}
        Create Session    fetchToken    ${base_url}
        ${body}=   Create Dictionary   clientName=Postman    clientEmail=${email}
        ${header}=  Create Dictionary    Content-Type=application/json
        ${response}=   POST On Session    fetchToken    ${fetch_accessToken}   json=${body}  headers=${header}

        #Assertions
        Should Be Equal As Strings    ${response.status_code}    201
        ${headerConn}=   Get From Dictionary    ${response.headers}    Connection
        Should Be Equal    ${headerConn}    keep-alive

        #Print the accessToken
        ${token}=   Get Data From JSON    ${response}   accessToken  #list with a single string element
        Log To Console    ${token}

        #Set access token as global variab le so that can be used in following test cases
        Set Suite Variable    ${tokenGlobalUse}     ${token[0]}
TC02_Place_Order
        Log To Console    ${tokenGlobalUse}
        Create Session    placeOrder    https://simple-books-api.glitch.me
        ${body}=   Create Dictionary      bookId=5    customerName=randomFullName"
        ${header}=  Create Dictionary    Authorization=Bearer ${tokenGlobalUse}   Content-Type=application/json
        ${response}=    POST On Session  placeOrder    /Orders   json=${body}   headers=${header}
        Should Be Equal As Strings    ${response.status_code}    201
        ${order_Id}=   Get Data From JSON    ${response}    orderId
        Log To Console    ${order_Id}

#*** Keywords ***
#Get Data From JSON
#    [Arguments]  ${response}  ${jsonpath}
#    ${jsonResponse}=  set Variable   ${response.json()}
#    ${msg}=  Get Value From Json  ${jsonResponse}  ${jsonpath}
#    [Return]  ${msg}
#
#Create Random Email
#  ${date}  Get Time  year month day
#  ${srinked_date}  Set Variable  ${date[2]}${date[1]}${date[0]}
#  ${usr_prefix}=  Generate Random String  3  [LOWER]
#  ${random_user}=  Catenate  SEPARATOR=  ${usr_prefix}  robot  ${srinked_date}  @autotest.com
#  [Return]  ${random_user}