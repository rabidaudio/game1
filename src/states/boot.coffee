
# Boot State. Displays the main menu

module.exports = {

  preload: (game) ->
    game.load.image 'logo', 'assets/phaser.png'

  create: (game) ->
    logo = game.add.sprite game.world.centerX, game.world.centerY, 'logo'
    logo.anchor.setTo 0.5, 0.5
    buttonStyle = { font: "65px Arial", fill: "#ff0044", align: "center" }
    start = game.add.labelButton game.world.centerX, 3/4*game.world.height, null, 'Play', buttonStyle, ()->
      game.state.start('test')

  update: (game) ->
    # no-op

} 