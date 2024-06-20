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
--animaciones.pezlvl1:draw(peces.lvl1Sprite,ancho/2-100,alto/2-100,nil,6,6)

anim8 = require 'libraries.anim8'

--tamaño pantalla
ancho,alto = love.graphics.getDimensions()

--musica
music = {}
music.level1 = love.audio.newSource("audio/music1.mp3","static")
music.level2 = love.audio.newSource("audio/music2.mp3","static")
music.level3 = love.audio.newSource("audio/music3.mp3","static")

-- sonidos
sonidos = {}
sonidos.bg = love.audio.newSource("audio/bg-sound.mp3","static")
sonidos.click = love.audio.newSource("audio/sfx.mp3","static")
sonidos.sell = love.audio.newSource("audio/sellsound.mp3","static")
sonidos.upgrade1 = love.audio.newSource("audio/upgrade1.mp3","static")

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
-- tiempo de agrandamiento del pez
scaleTime = 0 -- tiempo restante para que el pez permanezca agrandado
scaleDuration = 0.2 -- duración en segundos del agrandamiento


-- mejoras
mejoras = {}
mejoras.cania = {}
mejoras.cania.proxMejora = 15
mejoras.cania.nivelMejora = 0


--botones
botones = {}
botones.cania = love.graphics.newImage("resources/botones/button_cana.png")
botones.vender = love.graphics.newImage("resources/botones/vender.png")

-- acumulador peces
clickPeces = {}
clickPeces.cant = 0
clickPeces.numberTime = 0;clickPeces.numberSize = 0
clickPeces.cantPerClick = 1
clickPeces.posRandomX = math.random(50)
clickPeces.posRandomY = math.random(70)

-- monedas
monedaSpritesheet = love.graphics.newImage("resources/moneda.png")
monedaGrid = anim8.newGrid(16,16,monedaSpritesheet:getWidth(),monedaSpritesheet:getHeight())
animaciones = {}
animaciones.moneda = anim8.newAnimation(monedaGrid('1-7',1),0.2)
monedaCant = 0;multMonedas=1


function love.load()
    --quita lo borroso
    love.graphics.setDefaultFilter("nearest","nearest")
    love.audio.play(sonidos.bg)
    sonidos.bg:setVolume(0.6)
    music.level2:setVolume(0.5)
    sonidos.click:setVolume(0.7)
    sonidos.sell:setVolume(0.5)
    love.audio.play(music.level1)
    love.window.setTitle("Fish")
    cursor = love.mouse.newCursor("resources/cursor.png")
    love.mouse.setCursor(cursor)
end

function love.update(dt)
    --animaciones.pezlvl1:update(dt)
    animaciones.moneda:update(dt)

    if clickPeces.numberTime > 0 then
        clickPeces.numberTime = clickPeces.numberTime - dt
        clickPeces.numberSize = 1
    else
        clickPeces.numberSize = 0
    end

    if scaleTime > 0 then
        scaleTime = scaleTime - dt
        peces.lvl1.escala = 1.15
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
    animaciones.moneda:draw(monedaSpritesheet,1100,30,nil,1.5,1.5)
    love.graphics.setNewFont(20)
    love.graphics.print(monedaCant,1130,30 )
    font = love.graphics.newFont("resources/font.ttf",52)
    fontPequenia = love.graphics.newFont("resources/font.ttf",23)
    fontNumber = love.graphics.newFont("resources/fontNumber.ttf",30)
    love.graphics.setFont(font)
    love.graphics.print("Peces: "..clickPeces.cant,ancho/2-90,alto/2-110)
    love.graphics.setFont(fontPequenia)
    love.graphics.print("Nivel: "..mejoras.cania.nivelMejora,20,165)
    love.graphics.print("Próxima mejora: "..mejoras.cania.proxMejora.." oro",20,265) 
    love.graphics.print(mouseX..mouseY)
    love.graphics.draw(peces.lvl1.sprite,ancho/2-150,alto/2-100,nil,peces.lvl1.escala ,peces.lvl1.escala)
    love.graphics.setFont(fontNumber)
    love.graphics.print("+"..clickPeces.cantPerClick ,ancho/2+clickPeces.posRandomX,alto/2+clickPeces.posRandomY,nil,clickPeces.numberSize,clickPeces.numberSize)  
    love.graphics.draw(botones.vender,1080,60,nil,0.7,0.7)

end

function love.mousepressed()
    if mouseX >= ancho/2-150 and mouseX <= ancho/2-150 + peces.lvl1.sx and
    mouseY >= alto/2-10 and mouseY <= alto/2-10 + peces.lvl1.sy-60 then
        isClicked = true
        love.audio.play(sonidos.click)
        clickPeces.cant = clickPeces.cant + clickPeces.cantPerClick
        scaleTime = scaleDuration
        peces.lvl1.escala = 1.2
        clickPeces.numberTime = 0.5
        clickPeces.posRandomX = math.random(50)
        clickPeces.posRandomY = math.random(70)
        
    else
        peces.lvl1.escala = 1
    end

     if mouseX >= 1080 and mouseX <= 1080 + botones.vender:getWidth() and
    mouseY >= 60 and mouseY <= 60 + botones.vender:getHeight() and clickPeces.cant > 0 then
        love.audio.play(sonidos.sell) 
        monedaCant = monedaCant + (clickPeces.cant * multMonedas)
        clickPeces.cant = 0
    end

    if mouseX >= 10 and mouseX <= 10 + botones.cania:getWidth() and
    mouseY >= 200 and mouseY <= 200 + botones.cania:getHeight() and monedaCant >= mejoras.cania.proxMejora then
        --clickPeces.cant = clickPeces.cant - mejoras.cania.proxMejora
        love.audio.play(sonidos.upgrade1)
        clickPeces.cantPerClick = clickPeces.cantPerClick + 1
        monedaCant = monedaCant - mejoras.cania.proxMejora
        mejoras.cania.proxMejora = mejoras.cania.proxMejora + 20
        mejoras.cania.nivelMejora = mejoras.cania.nivelMejora + 1       
    end


end
