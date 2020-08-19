extends Node2D
 
# This is GameMenuGUI.gd     
var my_z_index = 0;  
var GAMEMENU = self;  #1525 #TitleScreenNodeGUI #Node2d 
onready var GUI = get_node("../Gui_Scene");
onready var GAMEMENU_CONTROL = get_node("GameMenu"); #1526 Control #TitleScreenControl 

# Called when the node enters the scene tree for the first time.
func _ready():  
	print("Game Menu GUI Ready") 
	GUI  = get_node("../Gui_Scene");
	#print(GUI); #
	GAMEMENU = self;
	#print(GAMEMENU); #
	GAMEMENU_CONTROL = get_node("GameMenu"); 
	GAMEMENU.set_process_input(true)
	my_z_index = GAMEMENU.get_z_index();
	pass # Replace with function body. 
	

func start():
	make_visible();
	pass;
	
func stop():	 
	make_invisible();
	pass;
	
func new():
	pass # Replace with function body.
		
func make_visible():
	self.show(); 
	my_z_index = self.get_z_index();
	self.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check != 1):
#		print("GameMenu set to show. ");
#	else:
		GAMEMENU.show();
		var check2 = GAMEMENU.check_visiblity(); 
		if(check2 == 1):
			print("GameMenu set to show. ");
		
func make_invisible(): 
	self.hide();	 
	self.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check != 0):
#		print("GameMenu set to hide. ");
#	else:
		GAMEMENU.hide();
		var check2 = GAMEMENU.check_visiblity(); 
		if(check2 == 0):
			print("GameMenu set to hide. ");

func check_visiblity():
	if self.visible:
		#print("GameMenu is visible. ");
		return(1)
	else:
		#print("GameMenu is not visible. ");
		return(0)
	pass;
 
func _on_PlayButton_pressed():   
	print("Play Button Pressed")	  
	pass # Replace with function body.

func _on_ExitGameButton_pressed( ):
	print("Exit Button Pressed") 
	pass # Replace with function body.

func _on_ScoresButton_pressed( ):  
	print("Score Button Pressed")  
	pass # Replace with function body.
 
func _on_DraftButton_pressed( ): 
	print("Draft Button Pressed") 
	pass # Replace with function body.

func _on_SettingsButton_pressed( ):
	print("Settings Button Pressed") 
	pass # Replace with function body.
	   
