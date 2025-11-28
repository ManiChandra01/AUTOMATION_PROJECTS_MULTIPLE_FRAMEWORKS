*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections

Suite Setup     Create Session    api    https://api.restful-api.dev

*** Variables ***
${BASE_URL}     https://api.restful-api.dev
${OBJECT_ID}

*** Test Cases ***
TC_01 Get Multiple Objects
    [Documentation]    Validate GET Objects by multiple IDs
    ${response}=    Get Request    api    /objects?id=3&id=5&id=10
    Status Should Be    200    ${response}
    Log To Console    ${response.text}

TC_02 Create New Object (POST)
    [Documentation]    Create an object and store ID for further requests
    ${body}=    Create Dictionary
    ...    name=Apple MacBook Pro 16
    ...    data=${{"year":2019,"price":1849.99,"CPU model":"Intel Core i9","Hard disk size":"1 TB"}}
    ${response}=    Post Request    api    /objects    json=${body}
    Status Should Be    200    ${response}
    ${json}=    To Json    ${response.text}
    ${created_id}=    Get From Dictionary    ${json}    id
    Set Suite Variable    ${OBJECT_ID}    ${created_id}
    Log To Console    Created Object ID: ${OBJECT_ID}

TC_03 Update Object (PUT)
    [Documentation]    Update created object and verify response
    ${body}=    Create Dictionary
    ...    name=Apple MacBook Pro 16
    ...    data=${{"year":2019,"price":2049.99,"CPU model":"Intel Core i9","Hard disk size":"1 TB","color":"silver"}}
    ${response}=    Put Request    api    /objects/${OBJECT_ID}    json=${body}
    Status Should Be    200    ${response}
    Log To Console    ${response.text}

TC_04 Partially Update Object (PATCH)
    [Documentation]    Update only name using PATCH
    ${body}=    Create Dictionary    name=Apple MacBook Pro 14 (Updated Name)
    ${response}=    Patch Request    api    /objects/${OBJECT_ID}    json=${body}
    Status Should Be    200    ${response}
    Log To Console    ${response.text}

TC_05 Delete Object (DELETE)
    [Documentation]    Delete object by ID
    ${response}=    Delete Request    api    /objects/${OBJECT_ID}
    Status Should Be    200    ${response}
    Log To Console    Deleted ID: ${OBJECT_ID}
