-- Fase
local fase = 1
-- Tamanho do bloco (em pixels)
local bloco = 50
-- Dimensões da tela (em blocos)
local largura_tela = 500
local altura_tela = 500
-- Tamanho da área de deslocamento do jogador (em pixels)
local deslocamento = 50

-- Objetos no mapa 1
local mapa_1 = {
	{ 0, 1, 0, 1, 1, 1, 0, 1, 1, 1 },
	{ 0, 1, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 1, 0, 1, 0, 1, 0, 1, 1, 0 },
	{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 0 },
	{ 0, 1, 0, 1, 0, 1, 1, 1, 0, 1 },
	{ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 1, 0, 1, 1, 0, 1, 0 },
	{ 0, 0, 0, 1, 0, 1, 1, 0, 1, 0 },
	{ 0, 1, 1, 1, 0, 0, 0, 0, 1, 0 },
	{ 1, 1, 0, 0, 0, 1, 1, 0, 1, 0 },
}

-- Objetos no mapa 2
local mapa_2 = {
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
}

-- Objetos no mapa 3
local mapa_3 = {
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
}

-- JOGADOR: guarda a imagem, posicao inicial e dimensoes
local img = canvas:new('jogador.png')
local dx, dy = img:attrSize()
local jogador = { img = img, x = 0 * bloco, y = 0 * bloco, dx = dx, dy = dy }

-- CHEGADA: guarda a imagem, posicao inicial e dimensoes
local img = canvas:new('chegada.png')
local dx, dy = img:attrSize()
local chegada = { img = img, x = 450, y = 450, dx = dx, dy = dy }

-- OBSTÁCULOS: guarda a imagem, posicao inicial e dimensoes
local img = canvas:new('obstaculo.png')
local dx, dy = img:attrSize()

local obstaculos = {}

-- Função para gerar coordenadas a partir de uma matriz
function gerarCoordenadas(matriz)
	local coordenadas = {}

	-- Itera sobre as linhas da matriz
	for i = 1, #matriz do
		-- Itera sobre as colunas da matriz
		for j = 1, #matriz[i] do
			-- Verifica se o valor na posição [i][j] é igual a 1
			if matriz[i][j] == 1 then
				-- Adiciona as coordenadas (i, j) na tabela de coordenadas
				table.insert(coordenadas, { i, j })
			end
		end
	end

	return coordenadas
end

function gerarObjetos()
	local cordenadas = {}

	if fase == 1 then
		cordenadas = gerarCoordenadas(mapa_1)
	elseif fase == 2 then
		cordenadas = gerarCoordenadas(mapa_2)
	elseif fase == 3 then
		cordenadas = gerarCoordenadas(mapa_3)
	end

	-- Desenha a chegada
	canvas:compose(chegada.x, chegada.y, chegada.img)
	-- Desenha o jogador
	canvas:compose(jogador.x, jogador.y, jogador.img)
	-- Desenha os obstáculos
	for i = 1, #cordenadas do
		obstaculos[i] = { img = img, x = (cordenadas[i][2] - 1) * bloco, y = (cordenadas[i][1] - 1) * bloco, dx = dx, dy = dy }
	end
end

-- Funcao de redesenho:
-- chamada a cada tecla pressionada
function redraw()
	canvas:attrColor('black')
	canvas:drawRect('fill', 0, 0, canvas:attrSize())
	
	-- canvas:attrColor('white')
	-- canvas:attrFont('vera', 50)
	-- canvas:drawText(50, 0, 'Você venceu!')
	gerarObjetos()
	for i = 1, #obstaculos do
		canvas:compose(obstaculos[i].x, obstaculos[i].y, obstaculos[i].img)
	end

	canvas:flush()
end

function collide(A, B)
	return A.x < B.x + B.dx and A.x + A.dx > B.x and A.y < B.y + B.dy and A.y + A.dy > B.y
end

local IGNORE = false

-- Funcao de tratamento de eventos:
function handler(evt)
	if IGNORE then
		return
	end

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
			jogador.x = 0
			jogador.y = 0
		else
			for i = 1, #obstaculos do
				if collide(jogador, obstaculos[i]) then
					jogador.x = 0
					jogador.y = 0
				end
			end
		end
	end

	redraw()
end

event.register(handler)
