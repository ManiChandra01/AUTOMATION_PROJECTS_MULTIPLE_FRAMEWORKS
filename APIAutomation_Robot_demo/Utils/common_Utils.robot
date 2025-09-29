*** Settings ***
Library   RequestsLibrary
Library   JSONLibrary
Library   Collections
Library   String


*** Variables ***


*** Keywords ***
Get Data From JSON
    [Arguments]  ${response}  ${jsonpath}
    ${jsonResponse}=  set Variable   ${response.json()}
    ${msg}=  Get Value From Json  ${jsonResponse}  ${jsonpath}
    [Return]  ${msg}

Create Random Email
  ${date}  Get Time  year month day
  ${srinked_date}  Set Variable  ${date[2]}${date[1]}${date[0]}
  ${usr_prefix}=  Generate Random String  3  [LOWER]
  ${random_user}=  Catenate  SEPARATOR=  ${usr_prefix}  robot  ${srinked_date}  @autotest.com
  [Return]  ${random_user}

Verify Message Is include
    [Arguments]    ${actual}    ${expected}
    Should contain    ${actual}    ${expected}

Verify text is equal
    [Arguments]   ${actual}    ${exp}
    Should Be Equal    ${actual}    ${exp}

Verify JSON payload
     [Arguments]  ${response}   ${jsonpath}  ${expected_message}
     ${jsonResponse}=  set Variable   ${response.json()}
     @{msg}=  Get Value From Json    ${jsonResponse}    ${jsonpath}
     ${msgString}=  Get From List    ${msg}    0
     Should Be Equal    ${msgString}    ${expected_message}
