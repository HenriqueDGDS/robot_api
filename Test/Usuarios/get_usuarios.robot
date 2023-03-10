*** Settings ***
Force Tags    @regression
Resource    ../base.robot

*** Test Cases ***
Listando todos os usuarios com sucesso
    ${response}    GET    ${baseURL}/usuarios    expected_status=200
    Set Test Variable    ${qtd}    ${response.json()['quantidade']}
    Should Be Equal As Strings    ${response.json()['quantidade']}    ${qtd}

Verificando presenca de usuarios
    ${response}    GET    ${baseURL}/usuarios    expected_status=200
    Set Test Variable    ${qtd}    ${response.json()['quantidade']}
    Should Not Be Equal As Strings    ${response.json()['quantidade']}    0

Listando usuario com ID valido
    ${response}    GET    ${baseURL}/usuarios/0uxuPY0cbmQhpEz1    expected_status=200
    Should Be Equal As Strings    ${response.json()['nome']}    Fulano da Silva

Listando usuario com ID invalido
    ${response}    GET    ${baseURL}/usuarios/0uxuPY0cbmQhpEz    expected_status=400
    Should Be Equal As Strings    ${response.json()['message']}    Usuário não encontrado

Listar usuarios com filtro simples
    [Tags]    @Filtros
     ${response}    GET    ${baseURL}/usuarios    expected_status=200    params=_id=0uxuPY0cbmQhpEz1
     Should Be Equal As Strings    ${response.json()['usuarios'][0]['nome']}    Fulano da Silva

Listar usuarios com filtros cruzados 
    [Tags]    @Filtros
     ${response}    GET    ${baseURL}/usuarios    expected_status=200    
     ...    params=_id=0uxuPY0cbmQhpEz1    
     ...    params=nome=Fulano da Silva
     Should Be Equal As Strings    ${response.json()['usuarios'][0]['nome']}    Fulano da Silva

Filtro cruzado com Erro
    [Tags]    @Filtros
     ${response}    GET    ${baseURL}/usuarios    expected_status=200    
     ...    params=_id=0uxuPY0cbmQhpEz1    
     ...    params=nome=João Amado
     Should Be Equal As Strings    ${response.json()['quantidade']}    0