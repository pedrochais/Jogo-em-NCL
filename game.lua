-- Fase
local fase = 1
-- Tamanho do bloco (em pixels)
local bloco = 50
-- Dimensões da tela (em blocos)
local largura_tela = 500
local altura_tela = 500
-- Tamanho da área de deslocamento do jogador (em pixels)
local deslocamento = 50

-- Cordenadas do jogador
local cordenadas_jogador = {
	{ 0, 0 },  -- Fase 1
	{ 0, 0 },  -- Fase 2
	{ 0, 0 },  -- Fase 3
	{ 0, 0 },  -- Fase 4
	{ 0, 0 },  -- Fase 5
	{ 4, 4 },  -- Fase 6
	{1, 9},  -- Fase 7
	{10, 10},  -- Fim
}

-- Cordenadas da chegada
local cordenadas_chegada = {
	{ 9, 9 },  -- Fase 1
	{ 9, 9 },  -- Fase 2 
	{ 5, 5 },  -- Fase 3
	{ 9, 9 },  -- Fase 4
	{ 9, 9 },  -- Fase 5
	{ 4, 9 },  -- Fase 6 
	{9, 0},  -- Fase 7
	{10, 10},  -- Fim
}

-- Cordenadas dos obstáculos
local cordenadas_obstaculos = {
	{ -- Fase 1
		{ 0, 1, 0, 1, 1, 1, 0, 1, 1, 1 },
		{ 0, 1, 0, 0, 0, 1, 0, 0, 0, 0 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 1, 0 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 0 },
		{ 0, 1, 0, 1, 0, 1, 1, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 1, 0, 1, 0, 1, 1, 0, 1, 0 },
		{ 0, 0, 0, 1, 0, 1, 1, 0, 1, 0 },
		{ 1, 1, 1, 1, 0, 0, 0, 0, 1, 0 },
		{ 0, 0, 0, 0, 0, 1, 1, 0, 1, 0 },
	},
	{ -- Fase 2
		{ 0, 1, 0, 0, 0, 1, 0, 0, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0 },
	},
	{ -- Fase 3
		{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 1, 0, 1, 1, 1, 1, 1, 1, 0 },
		{ 0, 1, 0, 1, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 1, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 1, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 0, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 1, 1, 1, 0, 1, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	},
	{ -- Fase 4
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	},
	{ -- Fase 5
		{ 0, 1, 1, 1, 0, 0, 1, 1, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 1, 1, 0, 0, 1, 1, 0, 0 },
		{ 0, 0, 1, 1, 0, 0, 1, 1, 0, 0 },
		{ 0, 0, 1, 1, 0, 0, 1, 1, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 0, 1, 1, 1, 1, 1, 1, 0, 0 },
		{ 0, 0, 0, 1, 1, 1, 1, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	},
	{ -- Fase 6
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 1, 1, 1, 1, 0, 1, 1, 1, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 0, 1, 1, 1, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 0, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 0, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 1, 1, 0, 1, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	},
	{ -- Fase 7
		{ 0, 0, 1, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
		{ 0, 1, 0, 0, 1, 0, 0, 1, 0, 0 },
		{ 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 },
		{ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 },
		{ 0, 1, 0, 0, 1, 0, 0, 1, 0, 0 },
		{ 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 },
		{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
		{ 0, 1, 0, 0, 1, 0, 0, 1, 0, 0 },
		{ 0, 0, 1, 0, 0, 0, 0, 0, 1, 0 },
	},
	{ -- Fim
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	},
}

-- JOGADOR: guarda a imagem, posicao inicial e dimensoes
local img_jogador = canvas:new('jogador.png')
local dx_jogador, dy_jogador = img_jogador:attrSize()
local jogador = { img = img_jogador, x = cordenadas_jogador[fase][1]*bloco, y = cordenadas_jogador[fase][2]*bloco, dx = dx_jogador, dy = dy_jogador }

-- CHEGADA: guarda a imagem, posicao inicial e dimensoes
local img_chegada = canvas:new('chegada.png')
local dx_chegada, dy_chegada = img_chegada:attrSize()
local chegada = { img = img_chegada, x = cordenadas_chegada[fase][1]*bloco, y = cordenadas_chegada[fase][2]*bloco, dx = dx_chegada, dy = dy_chegada }

-- OBSTÁCULOS: guarda a imagem, posicao inicial e dimensoes
local img_obstaculo = canvas:new('obstaculo.png')
local dx_obstaculo, dy_obstaculo = img_obstaculo:attrSize()

local obstaculos = {}


function atualizarCordenadas()
	-- Atualiza as cordenadas do jogador
	jogador.x = cordenadas_jogador[fase][1] * bloco
	jogador.y = cordenadas_jogador[fase][2] * bloco

	-- Atualiza as cordenadas da chegada
	chegada.x = cordenadas_chegada[fase][1] * bloco
	chegada.y = cordenadas_chegada[fase][2] * bloco
end

-- Função para gerar coordenadas a partir de uma matriz
function gerarCoordenadas(matriz)
	local cordenadas = {}

	-- Itera sobre as linhas da matriz
	for i = 1, #matriz do
		-- Itera sobre as colunas da matriz
		for j = 1, #matriz[i] do
			-- Verifica se o valor na posição [i][j] é igual a 1
			if matriz[i][j] == 1 then
				-- Adiciona as coordenadas (i, j) na tabela de coordenadas
				table.insert(cordenadas, { i, j })
			end
		end
	end

	return cordenadas
end





function gerarObjetos()
	-- Gera o mapa através da matriz de acordo com a fase atual
	local cordenadas = gerarCoordenadas(cordenadas_obstaculos[fase])
	-- Reinicializa a tabela de cordenada de obstáculos
	obstaculos = {}

	-- Desenha o jogador
	canvas:compose(jogador.x, jogador.y, jogador.img)

	-- Desenha a chegada
	canvas:compose(chegada.x, chegada.y, chegada.img)

	-- Desenha os obstáculos
	for i = 1, #cordenadas do
		obstaculos[i] = {
			img = img_obstaculo,
			x = (cordenadas[i][2] - 1) * bloco,
			y = (cordenadas[i][1] - 1) * bloco,
			dx = dx_obstaculo,
			dy = dy_obstaculo
		}
		canvas:compose(obstaculos[i].x, obstaculos[i].y, obstaculos[i].img)
	end
end






function gerarTexto(texto, tamanho, cor, x, y)
	canvas:attrColor(cor)
	canvas:attrFont('vera', tamanho)
	canvas:drawText(x, y, texto)
end

-- Funcao de redesenho:
-- chamada a cada tecla pressionada
function redraw()
	if fase == #cordenadas_obstaculos then
		gerarTexto('Você venceu!', 30, 'white', 100, 50)
		-- gerarTexto('Pressione R para reiniciar', 30, 'white', 0, 30)
		-- gerarTexto('Pressione ESC para sair', 30, 'white', 0, 60)
	else
		-- Cor do background
		canvas:attrColor('black')
		canvas:drawRect('fill', 0, 0, canvas:attrSize())

		-- Gera os objetos jogador, chegada e obstáculos
		gerarObjetos()

		-- Gera o texto informando a fase atual
		gerarTexto('Fase ' .. fase, 20, 'white', 0, 0)
	end

	canvas:flush()
end




-- Função para verificar a colisão entre objetos
function collide(A, B)
	return A.x < B.x + B.dx and A.x + A.dx > B.x and A.y < B.y + B.dy and A.y + A.dy > B.y
end





local IGNORE = false

-- Funcao de tratamento de eventos:
function handler(evt)
	if IGNORE then
		return
	end

	print("teste")
	-- apenas eventos de tecla me interessam
	if evt.class == 'key' and evt.type == 'press'
	then
		-- Identifica a tecla
		if evt.key == 'CURSOR_UP' then
			jogador.y = jogador.y - deslocamento
		elseif evt.key == 'CURSOR_DOWN' then
			jogador.y = jogador.y + deslocamento
		elseif evt.key == 'CURSOR_LEFT' then
			jogador.x = jogador.x - deslocamento
		elseif evt.key == 'CURSOR_RIGHT' then
			jogador.x = jogador.x + deslocamento
		end

		-- Verifica se o jogador está nos limites da tela
		if jogador.y < 0 then
			jogador.y = 0
		elseif jogador.y > altura_tela - bloco then
			jogador.y = altura_tela - bloco
		elseif jogador.x < 0 then
			jogador.x = 0
		elseif jogador.x > largura_tela - bloco then
			jogador.x = largura_tela - bloco
		end

		-- Testa as colisões
		if collide(jogador, chegada) then
			fase = fase + 1
			-- Atualiza as cordenadas do jogador e da chegada
			atualizarCordenadas()
		else
			for i = 1, #obstaculos do
				if collide(jogador, obstaculos[i]) then
					jogador.x = cordenadas_jogador[fase][1]*bloco
					jogador.y = cordenadas_jogador[fase][2]*bloco
				end
			end
		end
	end

	redraw()
end

event.register(handler)
