--import anim8
anim8 = require 'libraries.anim8'

--musica
music = {}
music.level1 = love.audio.newSource("audio/m1.mp3","static")
--backgrounds
bg = {}
bg.level1 = love.graphics.newImage("resources/bg.jpg")
--pescados
pescado = {}
-- explicación de anim8 --> 
-- añade un nuevo spritesheet (varios sprites juntos para una animación) revisar imagen por si hay dudas
pescado.PnaranjoSpritesheet = love.graphics.newImage('sprites/pescadoOrange.png')
-- crea un grid a partir del spritesheet (básicamente, el tamaño de cada sprite, los primeros 2 parámetros es x e y)
-- luego el tercer y cuarto parámetro es el tamaño total de la hoja, recibe el ancho y el alto del spritesheet
pescado.PnaranjoGrid = anim8.newGrid(16,16,pescado.PnaranjoSpritesheet:getWidth(),pescado.PnaranjoSpritesheet:getHeight())
animaciones = {}
-- crea la animación, '1-8' significa que ocupa el sprite 1 al 8, el 1 significa que es de
-- la columna 1 y el 0.2 es la velocidad a la que cambia la imagen
animaciones.Pnaranjo = anim8.newAnimation(pescado.PnaranjoGrid('1-8',1),0.2)

--tamaño pantalla
ancho,alto = love.graphics.getDimensions()
function love.load()
    love.audio.play(music.level1)
    love.window.setTitle("Clicker V2")
    cursor = love.graphics.newImage("resources/Fish-rod.png")
end

function love.update(dt)
    animaciones.Pnaranjo:update(dt)
end

function love.draw()
    love.graphics.draw(bg.level1,0,0,0,nil)
    animaciones.Pnaranjo:draw(pescado.PnaranjoSpritesheet,ancho/2,alto/2,nil,2,2)
end

function love.mousepressed()
end
