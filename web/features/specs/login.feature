#language: pt

Funcionalidade: Login

    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "bueno.@gmail.com" e "debs123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenário: Tentar Logar

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
        | email_input        | senha_input | mensagem_output                  |
        | deborah.@yahoo.com | debs124     | Usuário e/ou senha inválidos.    |
        | deborah@444.com    | debs123     | Usuário e/ou senha inválidos.    |
        | deborah.#gmail.com | debs123     | Oops. Informe um email válido!   |
        |                    | debs123     | Oops. Informe um email válido!   |
        | deborah.@bol.com   |             | Oops. Informe sua senha secreta! |







