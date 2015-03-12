
Player = require('./player')

now = ->
  new Date().valueOf()

module.exports = class DoubleJumper extends Player

  jump: ->
    @jumps++
    @last_jump = now()
    super

  onCollision: =>
    @jumps = 0 if !@isFlying()

  canDoubleJump: ->
    @jumps < 2 and (now() - @last_jump) > 500