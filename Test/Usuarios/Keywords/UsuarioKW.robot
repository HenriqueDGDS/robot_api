*** Settings ***
Resource    ../../base.robot

*** Keywords ***

Cadastrar
    [Documentation]    Keywords utilizadas para realizar cadastro
    [Arguments]    ${nome}    ${email}    ${password}

    ${Header}        Create Dictionary
    ...              Content-Type=application/json

    ${Body}          Create Dictionary
    ...              nome=${nome}
    ...              email=${email}
    ...              password=${password}
    ...              administrador=true

    Create Session    ServeRest    ${BaseURL}    verify=True
    ${response}       Post On Session    ServeRest    /usuarios
    ...               expected_status=any
    ...               headers=${Header}
    ...               json=${Body}

    Set Test Variable    ${response}