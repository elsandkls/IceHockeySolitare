extends Control

#Load Parent Scenes 
var GUI = []; 
#Load Current Scenes Object 
var OPTIONS = []; 
var my_z_index = 0;
var PARENT = self.get_parent();
 
# Called when the node enters the scene tree for the first time.
func _ready(): 
	GUI = get_parent();
	OPTIONS = self;
	pass # Replace with function body.

func start():	 
	pass;
	
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
	my_z_index = PARENT.get_z_index();
	PARENT.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check != 1):
#		print("OptionsGUI set to show. ");
#	else:
		OPTIONS.show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("OptionsGUI set to show. ");
		
func make_invisible(): 
	self.hide();	
	PARENT.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check != 0):
#		print("OptionsGUI set to hide. ");
#	else:
		OPTIONS.hide();
		var check2 = self.check_visiblity(); 
		if(check2 == 0):
			print("OptionsGUI set to hide. ");

func check_visiblity():
	if self.visible:
	#	print("OptionsGUI is visible. ");
		return(1)
	else:
	#	print("OptionsGUI is not visible. ");
		return(0)
	pass;

func _on_ReturnToMenuButton_pressed():     
	GUI._on_ReturnToMenuButton_pressed(); 
	pass # Replace with function body.
