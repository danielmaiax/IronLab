#SingleInstance Force

; Atalho: Ctrl+Alt+T para capturar o texto selecionado e enviar para a API
^!t::
{
        ; Captura o texto selecionado
        SendInput("^c") ; Copia o texto selecionado
        Sleep(200)      ; Pequeno atraso para garantir a cópia
        inputText := A_Clipboard

        if (inputText = "")
        {
            MsgBox("Nenhum texto selecionado.")
            return
        }

        ; Configuração da API
        ;apiUrl := "https://api.openai.com/v1/completions" ; Exemplo de URL da API
        ;apiKey := "sua-chave-api-aqui"

        ; Corpo da requisição
        ;jsonData := {}
        ;jsonData.model := "text-davinci-003"
        ;jsonData.prompt := inputText
        ;jsonData.max_tokens := 100
        ;jsonData.temperature := 0.7

        ; Envia o texto para a API
        ;response := SendPostRequest(apiUrl, JsonDump(jsonData), apiKey)

        ; Processa a resposta
        ;if (response != "")
        ;{
        ;    responseObj := JsonLoad(response)
        ;    responseText := responseObj.choices[1].text
        ;    Clipboard := responseText
        ;    MsgBox("Resposta copiada para a área de transferência.")
        ;}
        ;else
        ;{
        ;    MsgBox("Erro ao processar a resposta da API.")
        ;}

}
