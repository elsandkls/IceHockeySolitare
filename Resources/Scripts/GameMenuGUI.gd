extends Control
 
# This is GameMenuGUI.gd   
var OPTIONS = [];
var DRAFT = [];
var SCORE = [];  
var GAMEMENU = [];  
var GUI = [];  
var my_z_index = 0;
var PARENT = self.get_parent();

# Called when the node enters the scene tree for the first time.
func _ready(): 
	GUI = get_parent();
	GAMEMENU = self;
	#Laod Scenes 
	pass # Replace with function body. 
		
func start(): 
	pass; 

func get_OptionsGUI(): 
	OPTIONS = GUI.get_child("OPTION");  
	pass;
		
func get_DraftCardsGUI():
	DRAFT = GUI.get_child("DRAFT");  
	pass;
	
func get_ScoreGUI():
	SCORE = GUI.get_child("SCORE");   
	pass;
		
func make_visible():
	self.show(); 
	my_z_index = PARENT.get_z_index();
	PARENT.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check != 1):
#		print("GameMenu set to show. ");
#	else:
		GAMEMENU.show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("GameMenu set to show. ");
		
func make_invisible(): 
	self.hide();	 
	PARENT.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check != 0):
#		print("GameMenu set to hide. ");
#	else:
		GAMEMENU.hide();
		var check2 = self.check_visiblity(); 
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
	GUI._on_PlayButton_pressed();
	pass # Replace with function body.

func _on_ExitGameButton_pressed( ):
	#SAVEGAME.saveGame(SAVEGAME.content);
	get_tree().quit(-1)
	pass # Replace with function body.

func _on_ScoresButton_pressed( ):  
	GUI._on_ScoresButton_pressed();
	pass # Replace with function body.
 
func _on_DraftButton_pressed( ): 
	GUI._on_DraftButton_pressed();
	pass # Replace with function body.

func _on_SettingsButton_pressed( ):
	GUI._on_SettingsButton_pressed();
	pass # Replace with function body.
	 
