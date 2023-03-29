*** Settings ***
Resource    ../base.robot

*** Test Cases ***
Listando todos os produtos com sucesso
    [Tags]            @Listar_produtos
    ${response}    GET    ${baseURL}/produtos    expected_status=200
    Set Test Variable    ${qtd}    ${response.json()['quantidade']}
    Should Be Equal As Strings    ${response.json()['quantidade']}    ${qtd}

Verificando presenca de produtos
    [Tags]            @Listar_produtos
    ${response}    GET    ${baseURL}/produtos    expected_status=200
    Set Test Variable    ${qtd}    ${response.json()['quantidade']}
    Should Not Be Equal As Strings    ${response.json()['quantidade']}    0

Listando produto com ID valido
    [Tags]            @Listar_produtos
    ${response}    GET    ${baseURL}/produtos/BeeJh5lz3k6kSIzA    expected_status=200

Listando produto com ID invalido
    [Tags]            @Listar_produtos
    ${response}    GET    ${baseURL}/produtos/0uxuPY0cbmQhpEz    expected_status=400
    Should Be Equal As Strings    ${response.json()['message']}    Produto não encontrado

Listar produtos com filtro simples
    [Tags]        @Filtros_produtos
     ${response}    GET    ${baseURL}/produtos    expected_status=200    
     ...    params=nome=Logitech
     Should Be Equal As Strings    ${response.json()['produtos'][0]['nome']}    Logitech MX Vertical

Listar produto com filtros cruzados com sucesso
    [Tags]    @Filtros_produtos
     ${response}    GET    ${baseURL}/produtos    expected_status=200    
     ...    params=_id=BeeJh5lz3k6kSIzA    
     ...    params=nome=Logitech
     Should Be Equal As Strings    ${response.json()['produtos'][0]['nome']}    Logitech MX Vertical

Filtro cruzado com Erro em produtos
    [Tags]    @Filtros_produtos
     ${response}    GET    ${baseURL}/produtos    expected_status=200    
     ...    params=_id=BeeJh5lz3k6kSIzA    
     ...    params=nome=Abobrinha
     Should Be Equal As Strings    ${response.json()['quantidade']}    0