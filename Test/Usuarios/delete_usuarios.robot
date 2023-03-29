*** Settings ***
Force Tags    @regression
Resource    ../base.robot
Resource    ./Keywords/UsuarioKW.robot
Resource    ../Commons/CommonKW.robot

*** Test Cases ***
Deletando usuario com sucesso
    [Tags]    @Deletar
    Criar Usuario
    Deletar Usuário
    Should Be Equal As Strings    ${response.json()['message']}    Registro excluído com sucesso