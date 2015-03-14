
# Tutorial State

# It's main's job to hold instances of things (player, platform, etc).
# But ideally it's each thing's job to keep track of it's own state.
# Unfortunately, things are so coupled that this is kinda hard

DoubleJumper = require '../models/doubleJumper'

doubleJumpAt = 10

class Platforms
  constructor: (game) ->
    @group = game.add.group()
    @group.enableBody = true
    ground = @group.create 0, game.world.height - 64, 'ground'
    ground.scale.setTo 2,2
    ground.body.immovable = true
    for l in [{x: 400, y: 400},{x:-150, y: 250}]
      ledge = @group.create l.x, l.y, 'ground'
      ledge.body.immovable = true


class Stars 
  constructor: (game, count=10) ->
    @width = game.world.width
    @group = game.add.group()
    @group.enableBody = true
    @makeStar() for i in [1..count]

  makeStar: ->
    star = @group.create Math.random()*@width, 0, 'star'
    star.body.gravity.y = 6
    star.body.bounce.y = 0.7 + Math.random() * 0.2

  onCollect: (player, star) =>
    star.kill()
    @makeStar()

class Scoreboard 
  constructor: (game, @score=0) ->
    @sprite = game.add.text 16, 16, '', { fontSize: '32px', fill: '#000' }

  text: ->
    "Score: #{@score}"

  addPoints: (points) ->
    @score += points
    @sprite.text = @text()

gameMessage = (game, message, style={ font: "65px Arial", fill: "#ff0044", align: "center" }) ->
    text = game.add.text game.world.centerX, game.world.centerY, message, style
    text.anchor.set(0.5);
    text.alpha = 1;
    tween = game.add.tween(text).to { alpha: 0 }, 2000, "Linear", true
    tween.onComplete.add (text, tween) =>
      text.destroy()


module.exports = class Main

  preload: (game) ->
    game.load.image 'sky', 'assets/sky.png'
    game.load.image 'ground', 'assets/platform.png'
    game.load.image 'star', 'assets/star.png'
    game.load.spritesheet 'dude', 'assets/dude.png', 32, 48

  create: (game) ->
    game.physics.startSystem Phaser.Physics.ARCADE
    game.add.sprite 0, 0, 'sky'
    
    @platforms = new Platforms game
    @stars = new Stars game, 5
    @cursors = game.input.keyboard.createCursorKeys()

    # paused = false
    game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add  () ->
      game.paused = !game.paused
      # log game.physics.arcade.isPaused
      # game.physics.arcade.isPaused = !game.physics.arcade.isPaused

    @player = new DoubleJumper game
    @scoreboard = new Scoreboard game


  update: (game) ->
    return if game.paused
    game.physics.arcade.collide @player.sprite, @platforms.group, @player.onCollision
    game.physics.arcade.collide @stars.group, @platforms.group

    if @player.isFlying()
      @player.faceLeft() if @cursors.left.isDown
      @player.faceRight() if @cursors.right.isDown
      @player.jump() if @cursors.up.isDown and @player.canDoubleJump()

    else
      if @cursors.left.isDown
        @player.moveLeft() 
      else if @cursors.right.isDown
        @player.moveRight() 
      else
        @player.stop()
      @player.jump() if @cursors.up.isDown

    game.physics.arcade.overlap @player.sprite, @stars.group, (player, star)=>
      @stars.onCollect(player, star)
      @scoreboard.addPoints(1)
      if @scoreboard.score is doubleJumpAt
        @player.unlockDoubleJump()
        gameMessage game, 'Double Jump Time!'