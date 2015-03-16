
module.exports = class Room
  constructor: (game) ->
    @map = game.add.tilemap 'room'
    # layer = @map.createLayer 'main'
    # @map.setCollision [1, 2, 4, 5, 6, 10, 16, 20, 21, 22, 24, 25]

    # layer.resizeWorld()


    