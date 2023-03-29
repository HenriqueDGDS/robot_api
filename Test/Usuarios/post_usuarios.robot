*** Settings ***
Force Tags    @regression
Resource    ../base.robot
Resource    ./Keywords/UsuarioKW.robot
Resource    ../Commons/CommonKW.robot

*** Test Cases ***
Cadastrando usuario com sucesso
    [Tags]    @Cadastrar
    Criar Usuario
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso

Cadastrando usuario com email ja utilizado    
    [Tags]    @Cadastrar2
    Criar Usuario    
    Cadastrar                     ${USER.nome}    ${USER.email}    ${USER.password}    
    Should Be Equal As Strings    ${response.json()['message']}    Este email já está sendo usado