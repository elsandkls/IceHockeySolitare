extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func make_visible(): 
		self.show();	 
		print("ScoreGUI should now be visible.");
		
func make_invisible(): 
		self.hide();	
		print("ScoreGUI should now be invisible.");
