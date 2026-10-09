# Diário de Bordo - Criação da ISO Perfeita do Umbriel Void

Este documento foi gerado para salvar na nuvem todas as descobertas geniais e soluções definitivas que encontramos durante a remasterização do Noctalia/Umbriel no Void Linux.

## 1. O Bug do Greeter "Fantasma" e a Aba Desaparecida
**Problema:** O Noctalia v5 é extremamente rigoroso com segurança. Se você extrair o `rootfs` de maneira incorreta, as pastas raízes (`/usr`, `/usr/bin`) ficam com o dono `UNKNOWN:UNKNOWN`. Quando isso acontece, o Noctalia recusa o binário de sincronização (`noctalia-greeter-apply-appearance`) e **esconde a aba do Greeter** por segurança.
**Solução:** Fazer a ISO do zero usando o `void-mklive` garante que os pacotes baixados venham 100% com dono `root:root`, deixando o Noctalia feliz e reativando a interface gráfica de sincronização.

## 2. O Bug do Usuário `anon` que nunca sumia
**Problema:** Na instalação normal da ISO, o instalador apaga o usuário Live. Mas se você rodar `sudo void-installer`, o `sudo` limpa a variável `$USERNAME`. O instalador roda `userdel -r ""` (vazio), falha silenciosamente, e o `anon` fica no sistema final.
**Solução (Patch):**
Alterar o código-fonte do `installer.sh` do `void-mklive` injetando `${USERNAME:-anon}`. Assim, mesmo que o `sudo` apague a variável, ele força a exclusão do `anon`.
```bash
sed -i 's/chroot $TARGETDIR userdel -r $USERNAME >$LOG 2>&1/USERNAME="${USERNAME:-anon}"; chroot $TARGETDIR userdel -r $USERNAME >$LOG 2>&1/' installer.sh
```

## 3. O Bug da Tela Branca no Instalador
**Problema:** Rodar `sudo void-installer` dentro de terminais Wayland modernos (como o `foot`) faz com que a interface de caixinhas azuis (`dialog`) não consiga ler a paleta de cores, gerando uma tela branca ilegível.
**Solução:** Rodar o instalador forçando a paleta genérica do Linux:
```bash
sudo TERM=linux void-installer
```

## 4. O Bug do GParted e Apps Gráficos no Wayland
**Problema:** O Wayland proíbe programas rodando como `root` de acessarem a interface de vídeo do usuário (Socket Wayland). O `pkexec` limpa as variáveis de ambiente, fazendo o GParted abrir no vácuo e crashar silenciosamente.
**Solução (Janelinha Zenity):**
Criar um wrapper para o GParted que usa o Zenity para pedir a senha graficamente e preserva o ambiente gráfico com `sudo -A -E`.

## 5. Como Gerar a ISO do Zero Definitiva
Para compilar a ISO usando todo o seu ambiente atual (dotfiles da pasta `.config`), baixe o `void-mklive`, coloque suas configurações na pasta `overlay/etc/skel` (e os configs do `greetd` em `overlay/etc/greetd`), e rode o mklive:
```bash
# Exemplo de build:
sudo ./mklive.sh -r https://repo-default.voidlinux.org/current -r https://wiljapa.github.io/umbriel-void -r https://repo.voiders.dev -p "noctalia umbriel..." -I overlay -a x86_64
```
