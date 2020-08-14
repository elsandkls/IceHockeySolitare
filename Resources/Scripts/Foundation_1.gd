extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func new():
	pass # Replace with function body.

func get_uppper_right_x():
	var upper_right_x = Vector2(self.get_transform().get_origin()).x;
	return(upper_right_x);

func get_uppper_right_y():
	var upper_right_y = Vector2(self.get_transform().get_origin()).y; 
	return(upper_right_y);

func get_size_x():
	var GRID = self.get_parent();
	var SELF = GRID.get_child("Foundation_1");
	var size_x = SELF.texture.get_size().x; 
	return(size_x);

func get_size_y(): 
	var GRID = self.get_parent();
	var SELF = GRID.get_child("Foundation_1"); 
	var size_y = SELF.texture.get_size().y;
	return(size_y);
