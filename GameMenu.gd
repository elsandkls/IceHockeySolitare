extends Control
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func make_visible(): 
		self.show();
		print("GameMenu should now be visible.");
		
func make_invisible(): 
		self.hide();
		print("GameMenu should now be invisible.");

func check_visiblity():
	if self.visible:
		return(1)
	else:
		return(0)
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
