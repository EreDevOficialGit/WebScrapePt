#!/bin/bash

Black="\e[1;90m"
Red="\e[1;91m"
Green="\e[1;92m"
Yellow="\e[1;93m"
Blue="\e[1;94m"
Purple="\e[1;95m"
White="\e[1;97m"

banner () {
clear
echo -e "
${Red} __      __  ${Yellow}    ___.     _________
${Red}/  \\    /  \\ ${Yellow}____\\_ |__  /   _____/ ________________  ______   ____
${Red}\\   \\/\\/   /${Yellow}/ __ \\| __ \\ \\_____  \\_/ ___\\_  __ \\__  \\ \\____ \\_/ __ \\
${Red} \\        /${Yellow}\\  ___/| \\_\\ \\/        \\  \\___|  | \\// __ \\|  |_> >  ___/
${Red}  \\__/\\  /${Yellow}  \\___  >___  /_______  /\\___  >__|  (____  /   __/ \\___  >
${Red}      \\/${Yellow}       \\/    \\/        \\/     \\/           \\/|__|        \\/
"
printf "\n\e[1;97m  Ferramenta para coletar e-mails e telefones de páginas da web  \e[0m\n\n"
echo -e "\e[0;96m                 Autor: ${Red}Erê Developer Oficial\e[0m\n"
echo -e "\e[0;96m                 Projeto original: Sandesh (3xplotGuy)\e[0m\n\n"
}

scanner () {
sleep 0.5
read -r -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Digite a URL para começar: \e[1;97m' url
url_validity='^(https?|ftp)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]$'
if [[ "$url" =~ $url_validity ]]; then
    read -r -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Coletar e-mails do site? (s/n): \e[1;97m' email
    read -r -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Coletar telefones do site? (s/n): \e[1;97m' phone
    if [[ "$email" =~ ^[SsYy]$ || "$phone" =~ ^[SsYy]$ ]]; then
        echo -e "$White[${Red}!$White] ${Red}Iniciando a coleta..."
        scraper
    else
        echo -e "$White[${Yellow}!$White] Nenhuma opção selecionada."
    fi
    echo -e "$White[${Red}!$White] ${Red}Encerrando...\n"
    exit
else
    echo -e "$White[${Red}!$White] ${Red}URL inválida. Confira e tente novamente."
    scanner
fi
}

scraper () {
if ! curl -fsSL --max-time 30 -- "$url" -o temp.txt; then
    echo -e "$White[${Red}!$White] Falha ao baixar a página. Verifique a URL e sua conexão."
    rm -f temp.txt
    return 1
fi
if [[ "$email" =~ ^[SsYy]$ ]]; then email_scraping; fi
if [[ "$phone" =~ ^[SsYy]$ ]]; then phone_scraping; fi
rm -f temp.txt
if [[ -s email.txt || -s phone.txt ]]; then
    read -r -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Deseja salvar os resultados? (s/n): \e[1;97m' save_output
    if [[ "$save_output" =~ ^[SsYy]$ ]]; then output; fi
fi
rm -f email.txt phone.txt
}

email_scraping () {
grep -Eio '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}' temp.txt | sort -fu > email.txt
if [[ -s email.txt ]]; then
    echo -e "$White[${Yellow}*$White] ${Yellow}E-mails encontrados:${White}"
    cat email.txt
else
    echo -e "$White[${Red}!$White] ${Red}Nenhum e-mail encontrado."
    rm -f email.txt
fi
}

phone_scraping () {
grep -Eo '(\+?[0-9]{1,3}[ .-]?)?(\([0-9]{2,3}\)[ .-]?)?[0-9]{3,5}[ .-]?[0-9]{4}' temp.txt | sort -u > phone.txt
if [[ -s phone.txt ]]; then
    echo -e "$White[${Yellow}*$White] ${Yellow}Possíveis números de telefone encontrados:${White}"
    cat phone.txt
else
    echo -e "$White[${Red}!$White] ${Red}Nenhum telefone encontrado."
    rm -f phone.txt
fi
}

output () {
read -r -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Nome da pasta para salvar os resultados: \e[1;97m' folder_name
if [[ -z "$folder_name" || "$folder_name" == */* || "$folder_name" == "." || "$folder_name" == ".." ]]; then
    echo -e "$White[${Red}!$White] Nome de pasta inválido."
    return 1
fi
if [[ -e "$folder_name" ]]; then
    echo -e "$White[${Red}!$White] Essa pasta ou arquivo já existe."
    return 1
fi
mkdir -- "$folder_name" || return 1
[[ -f email.txt ]] && mv -- email.txt "$folder_name/"
[[ -f phone.txt ]] && mv -- phone.txt "$folder_name/"
echo -e "$White[${Green}*$White] ${Yellow}Resultados salvos em: $folder_name"
}

internet () {
echo -e "$White[$Red!$White] ${Red}Verificando conexão com a internet..."
if curl -fsSI --max-time 8 https://example.com >/dev/null; then
    echo -e "$White[$Yellow*$White] ${Yellow}Conexão disponível."
else
    echo -e "$White[$Red!$White] ${Red}Sem conexão ou acesso indisponível. Tente novamente mais tarde."
    exit 1
fi
}

banner
internet
scanner
