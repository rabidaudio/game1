moduleKeywords = ['extended', 'included']

# Static properties
Function::extend = (obj) ->
  for key, value of obj when key not in moduleKeywords
    @[key] = value
    obj.extended?.apply(@)
    this

#instance properties
Function::include = (obj) ->
  for key, value of obj when key not in moduleKeywords
    # Assign properties to the prototype
    @::[key] = value

  obj.included?.apply(@)
  this

# Scratcher = {
#   scratch: ->
#     true
# }

# class Cat 
  # @include Scratcher
#   meow: ->
#     log "Meow"