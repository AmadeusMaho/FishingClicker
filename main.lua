--import anim8
-- explicación de anim8 --> 
-- añade un nuevo spritesheet (varios sprites juntos para una animación) revisar imagen por si hay dudas
-- crea un grid a partir del spritesheet (básicamente, el tamaño de cada sprite, los primeros 2 parámetros es x e y)
-- luego el tercer y cuarto parámetro es el tamaño total de la hoja, recibe el ancho y el alto del spritesheet
-- crea la animación, '1-8' significa que ocupa el sprite 1 al 8, el 1 significa que es de
-- la columna 1 y el 0.2 es la velocidad a la que cambia la imagen
--peces.lvl1Grid = anim8.newGrid(32,32,peces.lvl1Spritesheet:getWidth(),peces.lvl1Spritesheet:getHeight())
--animaciones = {}
--animaciones.pezlvl1 = anim8.newAnimation(peces.lvl1Grid('1-3',1),0.2)

anim8 = require 'libraries.anim8'

--tamaño pantalla
ancho,alto = love.graphics.getDimensions()

--musica
music = {}
music.level1 = love.audio.newSource("audio/m1.mp3","static")

-- sonidos
sonidos = {}
sonidos.bg = love.audio.newSource("audio/bg-sound.mp3","static")
sonidos.click = love.audio.newSource("audio/sfx.mp3","static")

--backgrounds
bg = {}
bg.level1 = {}
bg.level1.sprite = love.graphics.newImage("resources/bg.jpg")


--pez
peces = {}
peces.lvl1 = {}
peces.lvl1.sprite = love.graphics.newImage('sprites/pez1.png')
peces.lvl1.sx, peces.lvl1.sy = peces.lvl1.sprite:getDimensions()
peces.lvl1.escala = 1
peces.lvl1.targetScale = 1 
peces.lvl1.scaleSpeed = 2 
-- Tiempo de agrandamiento del pez
scaleTime = 0 -- tiempo restante para que el pez permanezca agrandado
scaleDuration = 0.2 -- duración en segundos del agrandamiento


-- mejoras
mejoras = {}


--botones
botones = {}
botones.cania = love.graphics.newImage("resources/botones/button_cana.png")

-- acumulador peces
clickPeces = {}
clickPeces.cant = 0

function love.load()
    --quita lo borroso
    love.graphics.setDefaultFilter("nearest","nearest")
    love.audio.play(sonidos.bg)
    sonidos.bg:setVolume(0.4)
    sonidos.click:setVolume(0.7)
    love.audio.play(music.level1)
    love.window.setTitle("Fish")
    cursor = love.mouse.newCursor("resources/cursor.png")
    love.mouse.setCursor(cursor)
end

function love.update(dt)
    --animaciones.pezlvl1:update(dt)
    if scaleTime > 0 then
        scaleTime = scaleTime - dt
        peces.lvl1.escala = 1.2
    else
        peces.lvl1.escala = 1
    end
    -- interpolación, esto hace que la animación sea un poco más suave (es una fórmula)
    peces.lvl1.escala = peces.lvl1.escala + (peces.lvl1.targetScale - peces.lvl1.escala) * peces.lvl1.scaleSpeed * dt
       
end

function love.draw()
    love.graphics.draw(bg.level1.sprite,0,0,0,nil)
    mouseX,mouseY = love.mouse.getPosition()
    love.graphics.draw(botones.cania,10,200)
    font = love.graphics.newFont("resources/font.ttf",40)
    love.graphics.setFont(font)
    
    love.graphics.print("Peces: "..clickPeces.cant,ancho/2-100,alto/2-100)
    love.graphics.print(mouseX..mouseY)
    --animaciones.pezlvl1:draw(peces.lvl1Sprite,ancho/2-100,alto/2-100,nil,6,6)
    love.graphics.draw(peces.lvl1.sprite,ancho/2-180,alto/2-100,nil,peces.lvl1.escala ,peces.lvl1.escala)
end

function love.mousepressed()
    if mouseX >= ancho/2-150 and mouseX <= ancho/2-150 + peces.lvl1.sx and
    mouseY >= alto/2-10 and mouseY <= alto/2-10 + peces.lvl1.sy-60 then
        isClicked = true
        love.audio.play(sonidos.click)
        clickPeces.cant = clickPeces.cant + 1
        scaleTime = scaleDuration
        peces.lvl1.escala = 1.2
    else
        peces.lvl1.escala = 1
 end

end
