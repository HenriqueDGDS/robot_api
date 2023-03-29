*** Settings ***
Resource    ../base.robot
Resource    ../Usuarios/Keywords/UsuarioKW.robot
Resource    ../Login/Keywords/LoginKW.robot
Resource    ../Produtos/Keywords/ProdutosKW.robot

*** Keywords ***

Criar Dados Para Usuario Com O Faker
    [Documentation]    Keywords utilizada para criar dados fakes para Usuários

    ${FAKER_NAME}          FakerLibrary.Name
    ${FAKER_EMAIL}         FakerLibrary.Email
    ${FAKER_PASSWORD}      FakerLibrary.Password

    &{USER}                Create Dictionary
    ...                    nome=${FAKER_NAME}
    ...                    email=${FAKER_EMAIL}
    ...                    password=${FAKER_PASSWORD}
    ...                    administrador=true
    
    Set Test Variable      ${USER}

Criar Dados Para Produtos Com O Faker
    [Documentation]    Keywords utilizada para criar dados fakes para Produtos

    ${FAKER_PRODUCT}          FakerLibrary.Company
    ${FAKER_PRICE}            FakerLibrary.Building Number
    ${FAKER_DESCRIPTION}      FakerLibrary.Paragraph

    &{PRODUCT}                Create Dictionary
    ...                    nome=${FAKER_PRODUCT}
    ...                    preco=${FAKER_PRICE}
    ...                    descricao=${FAKER_DESCRIPTION}
    ...                    quantidade=2
    
    Set Test Variable      ${PRODUCT}

Criar Usuario
    [Documentation]    Keywords utilizada para criar um usuário

    Criar Dados Para Usuario Com O Faker
    Cadastrar    ${USER.nome}    ${USER.email}    ${USER.password}
    Should Be Equal As Strings    ${response.status_code}    201
    Set Test Variable             ${USER_ID}    ${response.json()['_id']}

Criar Produto
    [Documentation]    Keywords utilizada para criar um Produto

    Criar Dados Para Produtos Com O Faker
    Cadastrar Produto   ${PRODUCT.nome}    ${PRODUCT.preco}    ${PRODUCT.descricao}
    Should Be Equal As Strings    ${response.status_code}    201
    Set Test Variable             ${PRODUCT_ID}    ${response.json()['_id']}

Pegar Token
    [Documentation]    Keywords utilizadas para pegar um token válido

    Criar Dados Para Usuario Com O Faker
    Criar Usuario
    Login    ${USER.email}    ${USER.password}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Empty           ${response.json()['authorization']}
    Set Test Variable           ${TOKEN}        ${response.json()['authorization']}