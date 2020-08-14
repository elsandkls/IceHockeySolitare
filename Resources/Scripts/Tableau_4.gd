extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func new():
	pass # Replace with function body.

func get_size_x():
	var GRID = self.get_parent();
	var SELF = GRID.get_child("Tableau_4");
	var size_x = SELF.texture.get_size().x; 
	return(size_x);

func get_size_y(): 
	var GRID = self.get_parent();
	var SELF = GRID.get_child("Tableau_4"); 
	var size_y = SELF.texture.get_size().y;
	return(size_y);
