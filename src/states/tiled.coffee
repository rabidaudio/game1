Room = require '../models/room'



module.exports = class Tiled

  preload: (game) ->
    game.load.tilemap 'room', 'assets/maps/testroom.json', null, Phaser.Tilemap.TILED_JSON

  create: (game) ->
    @room = new Room game
    game.physics.startSystem Phaser.Physics.ARCADE

  update: (game) ->
