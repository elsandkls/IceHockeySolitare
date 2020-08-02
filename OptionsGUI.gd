extends Control
  

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func build_card():
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton3_pressed():
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	pass # Replace with function body.


func _on_TextureButton_pressed():
	pass # Replace with function body.


func make_visible(): 
		self.show();	 
		print("OptionsGUI should now be visible.");
		
func make_invisible(): 
		self.hide();	
		print("OptionsGUI should now be invisible.");
