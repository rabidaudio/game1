
Player = require('./player')

now = ->
  new Date().valueOf()

module.exports = class DoubleJumper extends Player

  unlocked: false

  jump: ->
    @jumps++
    @last_jump = now()
    super

  onCollision: =>
    @jumps = 0 if !@isFlying()

  canDoubleJump: ->
    @unlocked and @jumps < 2 and (now() - @last_jump) > 500

  unlockDoubleJump: ->
    @unlocked = true