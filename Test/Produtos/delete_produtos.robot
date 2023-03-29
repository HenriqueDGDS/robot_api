*** Settings ***
Force Tags    @regression
Resource    ../base.robot
Resource    ./Keywords/ProdutosKW.robot
Resource    ../Commons/CommonKW.robot

*** Test Cases ***
Deletando produto com sucesso
    [Tags]    @Delete_produtos
    Pegar Token
    Criar Produto   
    Set Test Variable             ${product_id}     ${response.json()['_id']} 
    Deletar Produto               ${product_id}
    Should Be Equal As Strings    ${response.json()['message']}    Registro excluído com sucesso 

Validando "nenhum registro excluido"
    [Tags]    @Delete_produtos
    Pegar Token 
    Criar Dados Para Produtos Com O Faker
    Deletar Produto               aiouehrakou
    Should Be Equal As Strings    ${response.json()['message']}    Nenhum registro excluído
