<div align="center">
  <img src="./banner.png" width="100%" alt="WebScrape">
</div>

# WebScrape — Português do Brasil

Ferramenta Bash para identificar possíveis endereços de e-mail e números de telefone presentes no HTML de uma página web.

**Autor desta adaptação/tradução:** Erê Developer Oficial  
**Projeto original:** Sandesh (3xplotGuy)  
**Licença:** MIT — consulte `LICENSE`.

## Requisitos

- Linux, macOS ou ambiente Unix, incluindo Termux no Android
- Bash, `curl`, `grep`, `sort` e `wget` (a verificação de conexão usa `curl`)

## Instalação no Linux ou Termux

No Termux, instale os pacotes necessários:

```bash
pkg update
pkg install bash curl grep coreutils
```

Extraia o ZIP, entre na pasta do projeto e execute:

```bash
chmod +x webscrape.sh
./webscrape.sh
```

## Como usar

1. Informe a URL completa, começando por `https://` ou `http://`.
2. Escolha se deseja procurar e-mails e/ou telefones (`s` para sim, `n` para não).
3. Confira os resultados e, se desejar, salve-os em uma pasta.

Os resultados são heurísticos: a ferramenta examina o HTML recebido e pode não encontrar dados carregados por JavaScript. Números identificados são apenas possíveis telefones e podem incluir falsos positivos.

## Uso responsável

Use somente em páginas e sistemas que você tem autorização para consultar. Respeite os termos do site, a legislação aplicável e a privacidade das pessoas. Não use os resultados para spam, assédio ou coleta não autorizada de dados pessoais.

## Créditos

Esta versão traduz a interface e a documentação para português do Brasil e identifica a adaptação como **Erê Developer Oficial**. O crédito do projeto original é mantido.
