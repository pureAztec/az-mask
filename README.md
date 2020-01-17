![logo](https://i.imgur.com/Jn0SXMX.png)

Como muitos tem me pedido esse script resolvi soltar free, vRP 0.5!<br>
Video demostrativo: https://youtu.be/c40KfLvjdVQ

- Salvando a mascara comprada<br>
- Animação ao colocar e retirar<br>
- Contem um total de 145 mascaras com sub comandos, <code>ex: /mascara lobo & /mascara lobo [cor] & /mascara [id] [cor]</code>
- Opções configuraveis como item necessario, nome das mascaras, mascaras do sv de graça!<br>
- Comando "/mascara ajuda" mostra todas mascaras disponiveis<br>

# Adicionar: *<br>
<b>items.lua:</b> vrp/cfg/items.lua<br>
Dentro do cfg.items adicione <code>["mascara"] = {"Mascara", "", nil, 0.1},</code><br>
Ex base b2k: <code>["mascara"] = {"Mascara", "azt_mask", nil, 0, "<span class='special-item'>Mascara</span>"},</code><br>
Obs: caso adicionem o item com um nome diferente altere o item no <code>server.lua</code> e no <code>basic_skinshop.lua</code>

<b>basic_skinshop.lua:</b> vrp/modules/basic_skinshop.lua<br>
Obs: *E necessario alterar o arquivo pois contem alterações para salvar a mascara<br>

# Mascaras:<br>
- porco, caveira, macaco, raio, macaco2, caveira2, capeta, noel, alci, neve, carnaval, carnaval2, kid, jason, jason2, jason3, gato, raposa, coruja, gamba, urso, bufalo, touro, aguia, peru, lobo, aviador, cyborg, caveira3, jason4, pinguim, panover, biscoito, velhoc, capuzpreto, gasboca, panopret, gas, monstro, monstro2, monstro3, monstro4, heroi, meninarosa, queixomen, gas2, fitacross, fita, saco, jason5, bandana, balaclava, balaclavacapuz, camiseta, balaclava2, balaclava3, balaclava4, balaclava5, bixao, abobora, monstro5, monstro6, monstro7, monstro8, monstro9, monstro10, monstro11, diabo, costurado, monstro12, monstro13, diabo2, biscoitomal, biscoitomal2, velhonatal, natal, natal2, bixao2, bixao3, bixao4, bixao5, bixao6, bixao7, frango, velha, velhoc2, velha2, cyborg2, cyborg3, guerreiro, monstro14, dino, diabo3, palhaço, gorilla, cavalo, unicornio, cmexicana, pug, bigness, bigodeneon, monstro15, balaclava6, cmexicana2, cyborg4, cyborg5, caveirab, aviador2, cyborg6, bandana2, cyborg7, balaclava7, arabia, arabia2, arabia3, balaclava8, balaclava9, balaclava10, ponto, balaclava11, balaclavaneon, jasonneon, cyborg8, balaclava12, jasonbiscoito, boquinha, cyborg9, cyborg10, diabovelho, cyborg11, jasonbigness, balaclavafuturo, cyborg12, corvo, monstro16, monstro17, monstro18, monstro19, monstro20, monstro21, taco, xburg, frango, cyborg, macacao

# Discord: AZTËC™#0001