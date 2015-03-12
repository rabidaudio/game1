
# Player should not know he's handled by a cursor. However, he should be movable
# and decide if he is able to jump or not

module.exports = class Player
  constructor: (game) ->
    @sprite = game.add.sprite 32, game.world.height - 150, 'dude'
    game.physics.arcade.enable @sprite
    @sprite.body.bounce.y = 0.2
    @sprite.body.gravity.y = 300
    @sprite.body.collideWorldBounds = true
    @sprite.animations.add 'left', [0, 1, 2, 3], 10, true
    @sprite.animations.add 'right', [5, 6, 7, 8], 10, true

  moveLeft: () ->
    @sprite.body.velocity.x = -150
    @sprite.animations.play 'left'

  moveRight: () ->
    @sprite.body.velocity.x = 150
    @sprite.animations.play 'right'

  stop: () ->
    @sprite.body.velocity.x = 0
    @sprite.animations.stop()
    @sprite.frame = 4

  jump: () ->
    @sprite.body.velocity.y = -350

  isFlying: () ->
    !@sprite.body.touching.down
