*** Settings ***
Resource    ../../base.robot

*** Keywords ***

Cadastrar Produto
    [Documentation]    Keywords utilizadas para Produtos
    [Arguments]    ${nome}    ${preco}    ${descricao}    

    ${Header}        Create Dictionary
    ...              Authorization=${TOKEN}    
    ...              Content-Type=application/json


    ${Body}          Create Dictionary
    ...              nome=${nome}
    ...              preco=${preco}
    ...              descricao=${descricao}
    ...              quantidade=2

    Create Session    ServeRest    ${BaseURL}    verify=True
    ${response}       Post On Session    ServeRest    /produtos
    ...               expected_status=any
    ...               headers=${Header}
    ...               json=${Body}

    Set Test Variable    ${response}

Deletar Produto
    [Documentation]    Keywords utilizadas para deletar Produtos 
    [Arguments]    ${product_id}  

    ${Header}        Create Dictionary
    ...              Authorization=${TOKEN}    
    ...              Content-Type=application/json


    ${Body}          Create Dictionary
    ...              nome=${PRODUCT.nome}
    ...              preco=${PRODUCT.preco}
    ...              descricao=${PRODUCT.descricao}
    ...              quantidade=2

    Create Session    ServeRest    ${BaseURL}    verify=True
    ${response}       DELETE On Session    ServeRest    /produtos/${product_id}
    ...               expected_status=any
    ...               headers=${Header}
    ...               json=${Body}

    Set Test Variable    ${response}