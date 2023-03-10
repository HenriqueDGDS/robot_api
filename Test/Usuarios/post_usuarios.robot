*** Settings ***
Force Tags    @regression
Resource    ../base.robot
Resource    ./Keywords/UsuarioKW.robot

*** Test Cases ***
Cadastrando usuario com sucesso
    [Tags]    @Cadastrar
    Cadastrar    Qualquer Coisa    boraapi@qa.com.br    1234
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso

Cadastrando usuario com email ja utilizado    
    [Tags]    @Cadastrar2
    Cadastrar    Qualquer Coisa    boraapi@qa.com.br    1234
    Should Be Equal As Strings    ${response.json()['message']}    Este email já está sendo usado