--import anim8
-- explicación de anim8 --> 
-- añade un nuevo spritesheet (varios sprites juntos para una animación) revisar imagen por si hay dudas
-- crea un grid a partir del spritesheet (básicamente, el tamaño de cada sprite, los primeros 2 parámetros es x e y)
-- luego el tercer y cuarto parámetro es el tamaño total de la hoja, recibe el ancho y el alto del spritesheet
-- crea la animación, '1-8' significa que ocupa el sprite 1 al 8, el 1 significa que es de
-- la columna 1 y el 0.2 es la velocidad a la que cambia la imagen
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
peces.lvl1Spritesheet = love.graphics.newImage('sprites/pez1.png')
peces.lvl1Grid = anim8.newGrid(32,32,peces.lvl1Spritesheet:getWidth(),peces.lvl1Spritesheet:getHeight())
animaciones = {}
animaciones.pezlvl1 = anim8.newAnimation(peces.lvl1Grid('1-3',1),0.2)


function love.load()
    --quita lo borroso
    love.graphics.setDefaultFilter("nearest","nearest")
    love.audio.play(sonidos.bg)
    sonidos.bg:setVolume(0.4)
    sonidos.click:setVolume(0.7)
    love.audio.play(music.level1)
    love.window.setTitle("Fish")
    cursor = love.graphics.newImage("resources/Fish-rod.png")
end

function love.update(dt)
    animaciones.pezlvl1:update(dt)
end

function love.draw()
    mouse = {}
    mouse.X,mouse.Y = love.mouse.getPosition()
    love.graphics.setNewFont(30)
    love.graphics.print(peces.lvl1Spritesheet:getWidth().." "..peces.lvl1Spritesheet:getHeight())
    love.graphics.print(mouse.X..mouse.Y)
    love.graphics.draw(bg.level1.sprite,0,0,0,nil)
    animaciones.pezlvl1:draw(peces.lvl1Spritesheet,ancho/2-100,alto/2-100,nil,6,6)
end

function love.mousepressed()
    love.audio.play(sonidos.click)
end
