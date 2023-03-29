*** Settings ***
Force Tags    @regression
Resource    ../base.robot
Resource    ./Keywords/ProdutosKW.robot
Resource    ../Commons/CommonKW.robot

*** Test Cases ***
Cadastrando produto com sucesso
    [Tags]    @Produtos
    Pegar Token
    Criar Produto   
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso
    Set Test Variable             ${PRODUCT_ID}     ${response.json()['_id']} 

Cadastrando produto com nome repetido   
    [Tags]    @Produtos
    Pegar Token
    Criar Produto   
    Cadastrar Produto    ${PRODUCT.nome}    ${PRODUCT.preco}    ${PRODUCT.descricao} 
    Should Be Equal As Strings    ${response.json()['message']}    Já existe produto com esse nome

Validando ausencia de token ao cadastrar produtos
    [Tags]    @Produtos
    Create Session    ServeRest    ${BaseURL}    verify=True
    ${response}       Post On Session    ServeRest    /produtos
    ...               expected_status=401
    Should Be Equal As Strings    ${response.json()['message']}    
    ...    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais

#Validando rota para administradores
