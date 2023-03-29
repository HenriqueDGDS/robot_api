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

Deletar Usuário
    [Documentation]    Keywords utilizadas para deletar um usuário

    ${Header}        Create Dictionary
    ...              Content-Type=application/json

    ${Body}          Create Dictionary
    ...              nome=${USER.nome}      
    ...              email=${USER.email}    
    ...              password=${USER.password} 
    ...              administrador=true

    Create Session    ServeRest    ${BaseURL}    verify=True
    ${response}       DELETE On Session    ServeRest    /usuarios/${USER_ID}
    ...               expected_status=any
    ...               headers=${Header}
    ...               json=${Body}

    Set Test Variable    ${response}

Editar Usuário
    [Documentation]    Keywords utilizadas para editar um usuário
    [Arguments]    ${nome}    ${email}    ${password}

    ${Header}        Create Dictionary
    ...              Content-Type=application/json

    ${Body}          Create Dictionary
    ...              nome=${nome}      
    ...              email=${email}    
    ...              password=${password} 
    ...              administrador=true

    Create Session    ServeRest    ${BaseURL}    verify=True
    ${response}       PUT On Session    ServeRest    /usuarios/${USER_ID}
    ...               expected_status=any
    ...               headers=${Header}
    ...               json=${Body}

    Set Test Variable    ${response}