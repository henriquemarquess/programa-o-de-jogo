--Primeiro Jogo que eu desenvolvi

--[[
    Jogo desenvolvido em 04 de maio de 2019
    ]]

VIRTUAL_ALTURA = 144
VIRTUAL_LARGURA = 256

WINDOW_ALTURA = 720
WINDOW_LARGURA = 1280

--Biblioteca para mudança de resolução
local push= require 'lib/push'

--Carregando nova fonte para o jogo
local retrofont = love.graphics.newFont('fonts/PressStart2P.ttf')

--carregando os Scripts do jogo
local xSprite=love.graphics.newImage('figuras/x.png')
local oSprite=love.graphics.newImage('figuras/o.png')

--Parâmetros da área de desenho do jogo

CEL_JOGO   = 40
TAM_SPRITE = 32
AFASTAMENTO_LATERAL_SPRITS=(CEL_JOGO-TAM_SPRITE)/2

NUM_GRADES_X, NUM_GRADES_Y = 3, 3

local xMargem=VIRTUAL_LARGURA-(CEL_JOGO*NUM_GRADES_X)
local yMargem=VIRTUAL_ALTURA-(CEL_JOGO*NUM_GRADES_Y)

--Expessura da linha
    love.graphics.setLineWidth(2)

--Posição do jogador
local selectX = 1
local selectY = 1

--Estrutura do jogo
local grid ={
    {"X", "", ""},
    {"", "0", "0"},
    {"X", "X", ""}
}


function love.load()
    --Título da tela do jogo
    love.window.setTitle("Jogo da Velha")

    --Mapeamento da tela de alta resolução parabaixa resolução
    push:setupScreen(VIRTUAL_LARGURA, VIRTUAL_ALTURA, WINDOW_LARGURA, WINDOW_ALTURA, {
        fullscreen=false,
        vsync=true,
        resizable=true
    })
    --Melhorando a qualidade do texto
    love.graphics.setDefaultFilter('nearest' , 'nearest')

    --Carregando a fonte importada
    love.graphics.setFont(retrofont)
end

function love.draw()
    push:start()
    love.graphics.print("Jogo da Velha")
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
            selectX = selectX - 1
        end
    elseif key == 'right' then
        if selectX < 3 then
            selectX = selectX + 1
        end
    elseif key == 'up' then
        if selectY > 1 then
            selectY = selectY - 1
        end 
    elseif key == 'down' then
        if selectY < 3 then
            selectY = selectY + 1
        end 
    end 
end    

function desenha_grades()
    --Desenha as grades do jogo da velha

    --1a linha horizontal
    love.graphics.line(xMargem/2,yMargem/2+CEL_JOGO,VIRTUAL_LARGURA-xMargem/2,yMargem/2+CEL_JOGO)

    --2a linha horizontal
    love.graphics.line(xMargem/2,yMargem/2+2*CEL_JOGO,VIRTUAL_LARGURA-xMargem/2,yMargem/2+2*CEL_JOGO)

    --1a linha vertical
    love.graphics.line(xMargem/2+CEL_JOGO,yMargem/2,xMargem/2+CEL_JOGO,VIRTUAL_ALTURA-yMargem/2)

    --2a linha vertical
    love.graphics.line(xMargem/2+2*CEL_JOGO,yMargem/2,xMargem/2+2*CEL_JOGO,VIRTUAL_ALTURA-yMargem/2)


        for y= 1, NUM_GRADES_Y do
        for x= 1, NUM_GRADES_X do
            local xOffset= xMargem/2 + CEL_JOGO*(selectX-1)
            local yOffset= yMargem/2 + CEL_JOGO*(selectY-1)
            if grid[x][y] == "X" then
                love.graphics.draw(xSprite, xOffset, yOffset)
            elseif grid[x][y] == "0" then
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