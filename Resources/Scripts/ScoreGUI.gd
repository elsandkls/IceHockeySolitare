extends Control
 
#Load Parent Scenes 
var GUI = []; 
#Load Current Scenes Object 
var SCORE = []; 
var my_z_index = 0;
var PARENT = self.get_parent();

# Called when the node enters the scene tree for the first time.
func _ready(): 
	GUI = get_parent();
	SCORE = self;
	pass # Replace with function body.

func start():	  
	pass;

func make_visible():  
	self.show();	
	my_z_index = PARENT.get_z_index();
	PARENT.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check != 1):
#		print("ScoreGUI set to show. ");
#	else:
		SCORE.show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("ScoreGUI set to show. ");	
		
func make_invisible(): 
	self.hide();
	PARENT.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check != 0):
#		print("ScoreGUI set to hide. ");
#	else:
		SCORE.hide();
		var check2 = self.check_visiblity(); 
		if(check2 == 0):
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
