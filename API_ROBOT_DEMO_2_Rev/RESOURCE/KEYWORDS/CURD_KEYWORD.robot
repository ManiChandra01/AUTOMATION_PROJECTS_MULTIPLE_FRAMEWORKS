*** Settings ***
Resource    ../../LIBRARY/common.robot
Resource    ../VARIABLE/Common_variable.robot





*** Keywords ***
Creating the request payload
  [Arguments]     ${request_json}     ${payload_name}
  ${Request}=  load json from file      ${request_json}
  ${Final_Payload}=     get from dictionary  ${Request}     ${payload_name}
  log  ${Final_Payload}
  set global variable  ${Final_Payload}

Hitting/Execute POST Request And Fetch Response with valid Url
   [Arguments]  ${url}
   Create Session   demo    ${url}
   ${payload}=  SET TO DICTIONARY   ${Final_Payload}
   ${post_response}=     POST On Session    demo    ${url}   json=${payload}
   log  ${post_response.json()}
   set suite variable  ${post_response}

   ${id}=    get from dictionary  ${post_response.json()}     id
   set suite variable  ${ID}   ${id}

Validation check from the responses body
    [Arguments]     ${Response}     ${Status_code}
    ${StatusCode}=  convert to string  ${Response.status_code}
    should be equal  ${StatusCode}      ${Status_code}
    should be equal as strings  ${StatusCode}      ${Status_code}


Hitting/Execute GET Request And Fetch Response with valid Url
   [Arguments]  ${url}
   ${get_url}=   set variable  ${url}/${ID}
   ${get_response}=      GET On Session  demo   ${get_url}
   log      ${get_response.json()}

Hitting/Execute PUT Request And Fetch Response with valid Url
   [Arguments]  ${url}      ${payload}
   ${put_url}=   set variable  ${url}/${ID}
   ${put_response}=      PUT On Session  demo   ${put_url}      json=${payload}
   log      ${put_response.json()}


Hitting/Execute DELETE Request And Fetch Response with valid Url
   [Arguments]  ${url}      ${payload}
   ${del_url}=   set variable  ${url}/${ID}
   ${del_response}=      delete On Session  demo   ${del_url}      json=${payload}
   log      ${del_response.json()}






