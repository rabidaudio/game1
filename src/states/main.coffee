
# Main State

class Player
  constructor: (game) ->
    @sprite = game.add.sprite 32, game.world.height - 150, 'dude'
    game.physics.arcade.enable @sprite
    @sprite.body.bounce.y = 0.2
    @sprite.body.gravity.y = 300
    @sprite.body.collideWorldBounds = true
    @sprite.animations.add 'left', [0, 1, 2, 3], 10, true
    @sprite.animations.add 'right', [5, 6, 7, 8], 10, true

  movePlayer: (cursors) ->
    if cursors.left.isDown
      @sprite.body.velocity.x = -150;
      @sprite.animations.play 'left'
    else if cursors.right.isDown
      @sprite.body.velocity.x = 150;
      @sprite.animations.play 'right'     
    else
      @sprite.animations.stop()
      @sprite.frame = 4

  update: (cursors) ->
    if !@isFlying()
      @sprite.body.velocity.x = 0
      @movePlayer(cursors)
      @jump() if (cursors.up.isDown)

  jump: () ->
    @sprite.body.velocity.y = -350

  isFlying: () ->
    !@sprite.body.touching.down


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

    @player = new Player game

    @cursors = game.input.keyboard.createCursorKeys()


  update: (game) ->
    game.physics.arcade.collide @player.sprite, @platforms
    @player.update(@cursors)