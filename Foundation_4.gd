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
