*** Variables ***
${base_url}           https://api.restful-api.dev/objects
${query_parametert}     ?id=3&id=5&id=10
${payload}          ../RESOURCE/PAYLOAD/POST_DEMO.json
${headers}    {"Content-Type": "application/json"}
@{Invalid}=   @@@@@     321     3213444545456646564646      NULL        null    ${NONE}     ${EMPTY}    ${SPACE}
@{Key_List}=    year    price   CPU model   Hard disk size