# Umbriel para Void Linux (x86_64)

[![Build and Release Umbriel](https://github.com/Wiljapa/umbriel-void/actions/workflows/build.yml/badge.svg)](https://github.com/Wiljapa/umbriel-void/actions/workflows/build.yml)
[![Latest Release](https://img.shields.io/github/v/release/Wiljapa/umbriel-void?color=blue&label=release)](https://github.com/Wiljapa/umbriel-void/releases/latest)
[![Void Linux](https://img.shields.io/badge/Void_Linux-x86__64-478061?logo=voidlinux&logoColor=white)](https://voidlinux.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Pacote binário pré-compilado e atualizado do compositor Wayland **[Umbriel](https://github.com/noctalia-dev/umbriel)** para **Void Linux**.

O Umbriel é um compositor Wayland moderno construído sobre o `wlroots`, com suporte nativo a layouts *scrolling*, *dwindle* e *master*, além de shaders e animações.

Este repositório compila automaticamente novas versões na nuvem (via GitHub Actions) todos os dias assim que surgem novos commits no repositório oficial do Umbriel.

---

## ⚡ Instalação Rápida

Para instalar a versão estável mais recente em qualquer máquina com **Void Linux (glibc x86_64)**:

### Opção 1: Comando automático em 2 passos

Abra o terminal e execute:

```bash
# 1. Baixar o pacote binário mais recente da release
curl -s https://api.github.com/repos/Wiljapa/umbriel-void/releases/latest \
  | grep "browser_download_url.*\.xbps" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -

# 2. Instalar (o XBPS resolve e baixa todas as dependências oficiais automaticamente)
sudo xbps-install --repository=$PWD -u umbriel
```

### Opção 2: Download manual
1. Acesse a aba **[Releases](https://github.com/Wiljapa/umbriel-void/releases/latest)**.
2. Baixe o arquivo `umbriel-*.x86_64.xbps`.
3. Na pasta onde o arquivo foi baixado, rode:
   ```bash
   sudo xbps-install --repository=$PWD -u umbriel
   ```

---

## 🚀 Pós-Instalação e Configuração

### 1. Criar o arquivo de configuração padrão
Copie o modelo de configuração fornecido para o seu diretório de usuário:

```bash
mkdir -p ~/.config/umbriel
cp /usr/share/umbriel/config.toml ~/.config/umbriel/
```

### 2. Validar a configuração
Antes de iniciar, você pode validar se sua sintaxe está correta:

```bash
umbriel validate
```

### 3. Iniciar o Umbriel
Você pode iniciar o compositor de duas maneiras:

- **Via TTY (Terminal limpo):**
  Faça login em um TTY (ex: `Ctrl + Alt + F2`) e execute:
  ```bash
  start-umbriel
  ```
  *(O `start-umbriel` configura as variáveis de ambiente necessárias do Wayland e inicia a sessão)*.

- **Via Display Manager (Login gráfico):**
  O pacote já instala a entrada para sessões Wayland em `/usr/share/wayland-sessions/umbriel.desktop`. Basta selecionar **Umbriel** no seu gerenciador de login (ex: SDDM, Greetd, GDM, LightDM).

---

## 🛠️ Compilação Manual (xbps-src)

Caso você prefira compilar o pacote localmente no seu computador em vez de usar os binários pré-compilados:

1. Clone o repositório oficial do `void-packages`:
   ```bash
   git clone --depth=1 https://github.com/void-linux/void-packages.git
   cd void-packages
   ./xbps-src binary-bootstrap
   ```

2. Clone este repositório e copie o template para dentro do `void-packages`:
   ```bash
   git clone https://github.com/Wiljapa/umbriel-void.git /tmp/umbriel-void
   cp -r /tmp/umbriel-void/srcpkgs/umbriel srcpkgs/
   ```

3. Compile e empacote:
   ```bash
   ./xbps-src pkg umbriel
   ```

4. Instale o pacote gerado:
   ```bash
   sudo xbps-install --repository=hostdir/binpkgs -u umbriel
   ```

---

## 🔄 Como Funciona a Automação (CI/CD)

- **Monitoramento Diário:** O GitHub Actions roda diariamente às 04:00 UTC e verifica se o commit mais recente do [noctalia-dev/umbriel](https://github.com/noctalia-dev/umbriel) mudou.
- **Compilação Limpa:** Se houver atualizações, um container oficial do Void Linux (`ghcr.io/void-linux/void-glibc-full`) é inicializado no GitHub Actions.
- **Release Automatizada:** O `xbps-src` compila o compositor com suporte a `jemalloc` e dependências completas do Wayland, gerando o pacote `.xbps` e o índice `x86_64-repodata` anexados na nova Release.

---

## 📄 Créditos e Licença

- Compositor **Umbriel** desenvolvido por [noctalia-dev](https://github.com/noctalia-dev/umbriel).
- Empacotamento mantido por [Wiljapa](https://github.com/Wiljapa).
- Licença: **MIT**.
