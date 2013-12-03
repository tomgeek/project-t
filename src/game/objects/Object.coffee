class Object
	constructor: (@x, @y, @width, @height) ->
		console.log "Object init"
		@implement @interfaces
	implement: (interfaceImpl) ->
		include @, interfaceImpl

extend = (obj, mixin) ->
	obj[name] = method for name, method of mixin
	obj

include = (klass, mixin) ->
	extend klass, mixin.prototype