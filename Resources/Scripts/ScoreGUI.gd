extends Node2D
 
#Load Parent Scenes 
var GUI = [];  
var SCORE = []; 
var my_z_index = 0; 

# Called when the node enters the scene tree for the first time.
func _ready(): 
	print("Score GUI Ready")
	GUI  = get_node("../Gui_Scene"); 
	SCORE = self; 
	pass # Replace with function body.


func start():
	make_visible();
	pass;
	
func stop():	 
	make_invisible();
	pass;

func make_visible():  
	self.show();	
	my_z_index = self.get_z_index();
	self.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check != 1):
		print("ScoreGUI set to show. "); 	
		
func make_invisible(): 
	self.hide();
	self.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check != 0):
		print("ScoreGUI set to hide. "); 

func check_visiblity(): 
	if self.visible:
		#print("ScoreGUI Visible!") 
		return(1)
	else:
		#print("ScoreGUI Not Visible!")
		return(0) 
	pass;
	
func _on_ReturnToMenuButton_pressed():     
	GUI._on_ReturnToMenuButton_pressed(); 
	pass # Replace with function body.
