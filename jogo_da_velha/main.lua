-- Primeiro jogo que eu desenvolvi
--[[

Jogo desenvolvido em 04/MAIO/2019

]]


VIRTUAL_ALTURA = 144
VIRTUAL_LARGURA = 256

WINDOW_ALTURA = 720
WINDOW_LARGURA = 1280

--biblioteca para mudança de resolução
local push= require 'lib/push'

--carregando a fonte para jogo
local retrofont = love.graphics.newFont('fonts/PressStart2P.ttf')

--carregando os sprits do jogo
local xSprite=love.graphics.newImage('figuras/x.png')
local oSprite=love.graphics.newImage('figuras/o.png')

--parametros da area de desenho do jogo

CEL_JOGO = 40
TAM_SPRITE = 32
AFASTAMENTO_LATERAL_SPRITS=(CEL_JOGO-TAM_SPRITE)/2

NUM_GRADES_X, NUM_GRADES_Y = 3, 3

local xMargem=VIRTUAL_LARGURA-(CEL_JOGO*NUM_GRADES_X)
local yMargem=VIRTUAL_ALTURA-(CEL_JOGO*NUM_GRADES_Y)

-- expessura da linha
love.graphics.setLineWidth(2)

--posição do jogador
local selectX = 1
local selectY = 1

-- variavel vencedor ou nao
local vencedor

-- jogador 
local jogador =1

--estrutura do jogo
local grid = {
    {"","",""},
    {"","",""},
    {"","",""}
}


function love.load()
    love.window.setTitle("Jogo da velha")
    push:setupScreen(VIRTUAL_LARGURA, VIRTUAL_ALTURA, WINDOW_LARGURA, WINDOW_ALTURA,{
    fullscreen=false,
    vsync=true,
    resizable=true
    })

    -- melhorando a qualidade  do texto
    love.graphics.setDefaultFilter('nearest','nearest')

    --carregando a fonte importada
    love.graphics.setFont(retrofont)
end

function love.draw()
    push:start()
    love.graphics.print("jogo da velha")
    if vencedor == true then
        if jogador == 1 then 
            love.graphics.print("Jogador 1 venceu", 5, 5)
        else
            love.graphics.print("Jogador 2 venceu",5 ,5)
        end
    end
       
    --love.graphics.draw(xSprite,10,40)
    --love.graphics.draw(oSprite,40,40)

    desenha_grades()
    push:finish()
end

function love.update(dt)

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'left' then
        if selectX > 1 then
            selectX = selectX -1
        end
    elseif key == 'right' then
        if selectX < 3 then
            selectX = selectX + 1
        end
    elseif key == 'up' then
        if selectY > 1 then
            selectY = selectY -1
        end
     elseif key == 'down' then
        if selectY < 3 then
            selectY = selectY +1
        end
    elseif key == 'space' then
        if grid[selectX][selectY] == '' then
            if jogador == 1 then
                grid[selectX][selectY] = 'X'
                testa_vitoria()
                if vencedor == false then 
                    jogador = 2
                end
            else
                grid[selectX][selectY] = 'O'
                testa_vitoria()
                if vencedor == false then
                    jogador = 1
                end
            end
        end
            
    end 
end

function desenha_grades()
    --desenha as grades do jogo da velha

    --primeira linha horizontal
    love.graphics.line(xMargem/2, yMargem/2+CEL_JOGO, VIRTUAL_LARGURA-xMargem/2, yMargem/2+CEL_JOGO)
    --segunda linha horizontal
    love.graphics.line(xMargem/2, yMargem/2+2*CEL_JOGO, VIRTUAL_LARGURA-xMargem/2, yMargem/2+2*CEL_JOGO)
    --primeira linha vertical
    love.graphics.line(xMargem/2+CEL_JOGO, yMargem/2, xMargem/2+CEL_JOGO, VIRTUAL_ALTURA-yMargem/2)
    --segunda linha vertical
    love.graphics.line(xMargem/2+2*CEL_JOGO, yMargem/2, xMargem/2+2*CEL_JOGO, VIRTUAL_ALTURA-yMargem/2)
    

    for y = 1, NUM_GRADES_Y do
        for x = 1, NUM_GRADES_X do
            local xOffset= xMargem/2 +CEL_JOGO *(x-1)
            local yOffset= yMargem/2 +CEL_JOGO *(y-1)
            if grid[x][y] == "X" then
                love.graphics.draw(xSprite, xOffset, yOffset)
            elseif grid[x][y] == "O" then
                love.graphics.draw(oSprite, xOffset, yOffset)
            end 
            if x == selectX and y == selectY then
                love.graphics.setColor(1, 1, 1, 0.7)
                love.graphics.rectangle('fill', xOffset, yOffset, CEL_JOGO, CEL_JOGO)
                love.graphics.setColor(1, 1, 1, 1)
            end
        end
    end

end

function testa_vitoria()
    vencedor = true
    -- teste de linhas
    for y=1, NUM_GRADES_Y do
        local temp = grid[1][y]
        if temp ~= '' then
            for x=2, NUM_GRADES_X do
                if temp ~= grid[x][y] then
                    vencedor = false
                    break
                end
            end
            if vencedor == true then
                return
            end
        else
            vencedor = false
        end
    end

    -- teste de colunas 
    for x=1, NUM_GRADES_X do
        vencedor = true
        local temp=grid[x][1]
        if temp ~= '' then
            for y=2, NUM_GRADES_Y do
                if temp ~= grid[x][y] then
                    vencedor = false
                    break
                end
            end
            if vencedor == true then
                return
            end
        else
            vencedor = false
        end
    end
    
    -- teste de diagonais

end