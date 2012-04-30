class Any
	constructor: (@name) ->

class Customer extends Any
	constructor: (@name,@age) -> 
		super(@name)
	toString : -> "Name: #{@name}, Age: #{@age}"
 
mateus = new Customer("Mateus",23)
alert mateus.toString()