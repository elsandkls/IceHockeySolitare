extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# Ways to create an array instance
	var a = Array()
	var b = []
	var c = ["a","b","c"]
	
	# Add some items to array 'a'
	a.append("Item 1")
	a.append("Item 2")
	
	# Pass array by reference to a function
	change(a)
	# Confirm that changes were made
	print(a[0])
	
	# Print the size of array 'b'
	print(b.size())
	
	# Shuffle the values of array 'c'
	c.shuffle() # This function doesn't return a value
	# Check that the element order was changed
	print_elements_of(c)
	
func change(a):
	a[0] = 1

func print_elements_of(array):
	# Here we are using one of the Pool array types
	print(PoolStringArray(array).join(""))
