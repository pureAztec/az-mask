![logo](https://i.imgur.com/gZFKOaf.png)

Como muitos tem me pedido esse script resolvi soltar free!<br>
- Contem um total de 147 mascaras com sub comandos, <code>ex: /mascara lobo</code>
- Opções configuraveis como item necessario, nome das mascaras, mascaras do sv de graça e muito mais!<br>
- Salvando a mascara comprada<br>
- Animação ao colocar e retirar<br>
- Notificações sobre o status do comando<br>
- Comando "/mascara ajuda" mostra todas mascaras disponiveis<br>

# Adicionar:<br>
<b>items.lua:</b> vrp/cfg/items.lua<br>
Dentro do cfg.items adicione <code>["mascara"] = {"Mascara", "", nil, 0.1},</code><br>
Ex b2k: <code>["mascara"] = {"Mascara", "azt_mask", nil, 0, "<span class='special-item'>Mascara</span>"},<code><br>
Obs: caso adicionem o item com um nome diferente altere o item no <code>server.lua</code> e no <code>basic_skinshop.lua</code>

<b>basic_skinshop.lua:</b> vrp/modules/basic_skinshop.lua<br>
Download: https://pastebin.com/raw/C6TQbJxn<br>
Obs: *E necessario alterar o arquivo pois contem alterações para salvar a mascara<br>

# Discord: AZTËC™#0001
https://discord.gg/XZUPsND