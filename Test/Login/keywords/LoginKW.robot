*** Settings ***
Resource    ../../base.robot

*** Keywords ***

Login
    [Documentation]    Keywords utilizadas para realizar login
    [Arguments]    ${email}    ${password}

    ${Header}        Create Dictionary
    ...              Content-Type=application/json

    ${Body}          Create Dictionary
    ...              email=${email}
    ...              password=${password}

    Create Session    ServeRest    ${BaseURL}    verify=True
    ${response}       Post On Session    ServeRest    /login
    ...               expected_status=any
    ...               headers=${Header}
    ...               json=${Body}

    Set Test Variable    ${response}