*** Settings ***
Library   XML
Library   os
Library   RequestsLibrary
Library   Collections

*** Variables ***
${base_url}   https://mocktarget.apigee.net

*** Test Cases ***
TC_XMLPayloadValiadtion
    Create Session    xmlPayload    ${base_url}
    ${response}=  GET On Session    xmlPayload    /xml
    ${xml_string}=   Convert To String    ${response.content}
    ${xml_obj}=   Parse Xml    ${xml_string}
    ${city} =  Get Element Text    ${xml_obj}    .//city
    Log To Console    ${city}
    ${childs} =  Get Child Elements    ${xml_obj}
    ${f_name} =  get element text   ${childs[1]}
    Log To Console    ${f_name}

    # Iterate over child elements
    FOR    ${child}    IN    @{childs}
        ${element_name}=    Get Element    ${child}
        ${element_text}=    Get Element Text    ${child}
        Log To Console    Element Name: ${element_name}
        Log To Console    Element Text: ${element_text}
    END