--import anim8
anim8 = require 'libraries.anim8'

--musica
music = {}
music.level1 = love.audio.newSource("audio/m1.mp3","static")
--backgrounds
bg = {}
bg.level1 = love.graphics.newImage("resources/bg.jpg")
--pescado
pescado = {}
pescado.PnaranjoSpritesheet = love.graphics.newImage('sprites/pescadoOrange.png')
pescado.PnaranjoGrid = anim8.newGrid(16,16,pescado.PnaranjoSpritesheet:getWidth(),pescado.PnaranjoSpritesheet:getHeight())
animaciones = {}
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
    animaciones.Pnaranjo:draw(pescado.PnaranjoSpritesheet,ancho/2,alto/2,nil,10,10)
end

function love.mousepressed()
end
