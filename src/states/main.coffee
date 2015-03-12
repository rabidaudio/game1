
# Main State

# It's main's job to hold instances of things (player, platform, etc).
# But ideally it's each thing's job to keep track of it's own state.
# Unfortunately, things are so coupled that this is kinda hard

Player = require '../models/player'
DoubleJumper = require '../models/doubleJumper'

module.exports = class Main

  preload: (game) ->
    game.load.image 'sky', 'assets/sky.png'
    game.load.image 'ground', 'assets/platform.png'
    game.load.image 'star', 'assets/star.png'
    game.load.spritesheet 'dude', 'assets/dude.png', 32, 48

  create: (game) ->
    game.physics.startSystem Phaser.Physics.ARCADE
    game.add.sprite 0, 0, 'sky'
    @platforms = game.add.group()

    @platforms.enableBody = true

    ground = @platforms.create 0, game.world.height - 64, 'ground'

    ground.scale.setTo 2,2
    ground.body.immovable = true

    ledge1 = @platforms.create 400, 400, 'ground'
    ledge1.body.immovable = true

    ledge2 = @platforms.create -150, 250, 'ground'
    ledge2.body.immovable = true

    @cursors = game.input.keyboard.createCursorKeys()

    @player = new DoubleJumper game #new Player game

  update: (game) ->
    game.physics.arcade.collide @player.sprite, @platforms, @player.onCollision

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
