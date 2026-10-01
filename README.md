# Umbriel Void Linux - CI/CD Automatizado

Repositório para compilação automatizada do compositor Wayland **Umbriel** para **Void Linux** (x86_64) utilizando GitHub Actions e `xbps-src`.

---

## 🚀 Como Funciona

1. **Agendamento Diário:** O GitHub Actions roda todos os dias às 04:00 UTC (01:00 BRT).
2. **Detecção de Atualização:** Compara o commit mais recente do repositório upstream ([noctalia-dev/umbriel](https://github.com/noctalia-dev/umbriel)) com as Releases existentes.
3. **Compilação na Nuvem:** Se houver commit novo, inicia um container oficial do Void Linux, executa o `xbps-src pkg umbriel` e assina o repositório com `xbps-rindex`.
4. **Publicação Automática:** Envia os binários `.xbps` e os metadados `x86_64-repodata` para uma nova **GitHub Release**.

---

## 🛠️ Como Subir este Repositório para o seu GitHub

Se você ainda não criou o repositório no GitHub:

1. Acesse [github.com/new](https://github.com/new) e crie um repositório chamado `umbriel-void` (pode ser público).
2. No seu terminal local, execute:

```bash
cd ~/umbriel-void

# Configure seu nome e e-mail no git (caso ainda não tenha feito)
git config user.name "Seu Nome"
git config user.email "seu@email.com"

# Inicialize e envie para o GitHub (substitua SEU_USUARIO pelo seu username)
git init -b main
git add .
git commit -m "feat: setup automated build and template for umbriel"
git remote add origin https://github.com/SEU_USUARIO/umbriel-void.git
git push -u origin main
```

---

## ⚙️ Habilitar Permissões no GitHub

Para que o GitHub Actions consiga criar as Releases com os binários:

1. No seu repositório no GitHub, clique em **Settings** > **Actions** > **General**.
2. Na seção **Workflow permissions**, selecione:
   - **Read and write permissions**
3. Clique em **Save**.

---

## ▶️ Como Rodar Manualmente a Primeira Vez

1. No seu repositório no GitHub, vá na aba **Actions**.
2. No menu lateral esquerdo, clique em **Build and Release Umbriel**.
3. Clique no botão **Run workflow** > **Run workflow**.
4. Em ~5 a 10 minutos a compilação estará concluída e o binário estará disponível na aba **Releases**!

---

## 📦 Como Instalar a Versão Compilada no seu Computador

Quando uma nova release for publicada, você pode instalar diretamente apontando o `xbps-install` para a URL da Release:

```bash
# Substitua SEU_USUARIO e A_TAG_DA_RELEASE
sudo xbps-install --repository=https://github.com/SEU_USUARIO/umbriel-void/releases/download/0.1.0gitYYYYMMDD-XXXXXXXX/ -u umbriel
```

Ou, se preferir baixar o arquivo `.xbps` e adicionar à sua pasta local `~/void_pacotes`:

```bash
cd ~/void_pacotes
curl -LO https://github.com/SEU_USUARIO/umbriel-void/releases/latest/download/umbriel-0.1.0git...x86_64.xbps
xbps-rindex -a *.xbps
sudo xbps-install -R $PWD -u umbriel
```
