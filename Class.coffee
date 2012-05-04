class Any
	constructor: (@name) ->
	toString : -> "Name: #{@name}"
class Customer extends Any
	constructor: (@name,@age) -> 
		super(@name)
	toString : -> super+",Age: #{@age}"
 
show = (any) -> console.log any.toString()

mateus = new Customer("Mateus",23)
show(mateus)
