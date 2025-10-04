
*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary


*** Variables ***
${base_url}     https://api.restful-api.dev/objects
${qury_param}   ?id=3&id=5&id=10

*** Test Cases ***
TC-01 Validate the MObile shop GET API
        Create Session  get_demo    ${base_url}${qury_param}
        ${response}=  GET On Session  get_demo    /

# Print on console/termimal
        log to console      ${response.status_code}
        log to console      ${response.content}   # Raw response (byte (b))
        log to console      ${response.json()}    # parsed json (dict)
        log to console      ${response.headers}

#Print in report

        log     ${response.status_code}
        log     ${response.content}
        log     ${response.json()}
        log     ${response.headers}

#Validate Status Code

        ${status_code}=     convert to string  ${response.status_code}
        ${response_content}=     convert to string  ${response.content}
        ${headres_r}=   get from dictionary  ${response.headers}    server

#Assertion
        should be equal  ${status_code}     200
        should be equal as strings  ${status_code}     200
        should be equal     ${headres_r}    cloudflare

#Assertion on responseBody

        ${responsesbody}=   set variable  ${response.json()}
        ${ids}=   get value from json  ${responsesbody}  $..id
        ${Extract_krishna_ids}=  get from list  ${ids}  0








