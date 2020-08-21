extends Control

# This is GUI.gd       
onready var DRAFT = self.get_node("../DraftCards_Scene"); #
onready var SCORE = self.get_node("../Score_Scene"); # 
onready var OPTIONS = self.get_node("../Options_Scene"); #
onready var GAMEMENU = self.get_node("../GameMenu_Scene"); # 
onready var GRID = self.get_node("../Grid_Scene"); # 
onready var TITLESCREEN = self.get_node("../TitleScreen_Scene"); # 
var debug_level = 2;
# Called when the node enters the scene tree for the first time.

func _ready(): 	
	if(debug_level == 0): 
		print("GUI Ready")
		print("GUI loading child scenes:"); 
	pass # Replace with function body.
	
func _input(event): 
	if event.is_action_pressed("GameMenu"):
		if(debug_level == 0):
			print("GameMenu, Escape Pressed.");
		if GAMEMENU.check_visiblity():
			GAMEMENU.make_invisible(); 
		else:	
			GAMEMENU.make_visible();
			if(debug_level == 0):
				print("GameMenu should now be visible.");
	pass;	

func new():
	pass # Replace with function body.
	
func start():
	self.make_invisible();
	pass # Replace with function body.
  
func _on_PlayButton_pressed():	    
	SCORE.stop();
	OPTIONS.stop();
	DRAFT.stop(); 
	GAMEMENU.stop();  
	TITLESCREEN.stop(); 
	if(debug_level == 0):
		print("Clicked Play."); 
	GRID.start(); 
	pass # Replace with function body.
	
func _on_DraftButton_pressed():	    
	SCORE.stop();
	OPTIONS.stop(); 
	GAMEMENU.stop();  
	TITLESCREEN.stop(); 
	if(debug_level == 0):
		print("Clicked Draft Cards."); 
	DRAFT.start(); 
	pass # Replace with function body.

func _on_SettingsButton_pressed(): 
	SCORE.stop(); 
	DRAFT.stop(); 
	GAMEMENU.stop(); 
	TITLESCREEN.stop(); 
	if(debug_level == 0):
		print("Clicked Settings.");
	OPTIONS.start(); 
	pass # Replace with function body.

func _on_ExitGameButton_pressed():
	OPTIONS.stop();
	DRAFT.stop(); 
	GAMEMENU.stop(); 	
	TITLESCREEN.stop(); 
	SCORE.stop();  
	#SAVEGAME.saveGame(SAVEGAME.content);
	if(debug_level == 0):
		print("Clicked Exit Game .");
	get_tree().quit(-1)
	pass # Replace with function body.

func _on_ScoresButton_pressed():  
	OPTIONS.stop();
	DRAFT.stop(); 
	GAMEMENU.stop(); 
	TITLESCREEN.stop(); 
	if(debug_level == 0):
		print("Clicked High Scores .");
	SCORE.start();  
	pass # Replace with function body.

func _on_ReturnToMenuButton_pressed():     
	SCORE.stop();
	OPTIONS.stop();
	DRAFT.stop();  
	TITLESCREEN.stop(); 
	GAMEMENU.start(); 
	if(debug_level == 0):
		print("Clicked GameMenu");
	pass # Replace with function body.

func Make_Menu_visible():
	if(debug_level == 0):
		print("Game Start: New GameMenu");
	SCORE.stop();
	OPTIONS.stop(); 
	DRAFT.stop(); 
	TITLESCREEN.stop(); 
	if(debug_level == 0):
		print("Clicked GAMEMENU.");
	GAMEMENU.start();  
	pass # Replace with function body.

	
func _on_TitleScreenButton_pressed():	
	SCORE.stop();
	OPTIONS.stop(); 
	DRAFT.stop(); 
	GAMEMENU.stop(); 
	if(debug_level == 0):
		print("Clicked TITLESCREEN."); 
	TITLESCREEN.start(); 
	pass # Replace with function body.


func make_visible():
	if(debug_level == 0):
		print("Game GUI: Make Visible");
	self.show();
	if(debug_level == 0):
		print("New Game GUI: should now be visible.");
	pass # Replace with function body.
	
func make_invisible():
	if(debug_level == 0):
		print("Game GUI: Make inVisible");
	self.hide();
	if(debug_level == 0):
		print("New Game GUI: should now be invisible.");
	pass # Replace with function body.
