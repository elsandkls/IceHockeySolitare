extends Control
 
#Laod Scenes
var OPTIONS_SCENE =  load("res://Resources/Scenes/OptionsGUI.tscn").instance();
var DRAFT_SCENE =  load("res://Resources/Scenes/DraftCardsGUI.tscn").instance();
var SCORE_SCENE =  load("res://Resources/Scenes/ScoreGUI.tscn").instance();
var MENU_SCENE =  load("res://Resources/Scenes/GameMenuGUI.tscn").instance();
#Load scripts
var GRID = load("res://Resources/Scripts/Grid.gd").new()
var OPTIONS = load("res://Resources/Scripts/OptionsGUI.gd").new()
var SCORE = load("res://Resources/Scripts/ScoreGUI.gd").new()
var DRAFT = load("res://Resources/Scripts/DraftCardGUI.gd").new()
var MENU = load("res://Resources/Scripts/GameMenuGUI.gd").new()


# Called when the node enters the scene tree for the first time.
func _ready():
	make_visible();
	pass # Replace with function body. 
		
func make_visible():
	self.show();
	var check = self.check_visiblity(); 
	if(check == 1):
		print("GameMenu set to show. ");
	else:
		get_node("YSort/GUI/GameMenu").show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("GameMenu set to show. ");
		
func make_invisible(): 
	self.hide();	
	var check = self.check_visiblity(); 
	if(check == 0):
		print("GameMenu set to hide. ");
	else:
		get_node("YSort/GUI/GameMenu").hide();
		var check2 = self.check_visiblity(); 
		if(check2 == 0):
			print("GameMenu set to hide. ");


func check_visiblity():
	if self.visible:
		print("GameMenu is visible. ");
		return(1)
	else:
		print("GameMenu is not visible. ");
		return(0)
	pass;
 
func _on_PlayButton_pressed( ):	    
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_invisible();
	print("Clicked Game Menu Play - Grid or the Table should now be visible."); 
	GRID.start();
	GRID.build_deck();
	pass # Replace with function body.


func _on_ExitGameButton_pressed( ):
	#SAVEGAME.saveGame(SAVEGAME.content);
	get_tree().quit(-1)
	pass # Replace with function body.

func _on_ScoresButton_pressed( ):  
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_invisible(); 
	print("Clicked Game Menu Score - High Scores should now be visible.");
	SCORE.make_visible(); 
	SCORE.start();
	pass # Replace with function body.
 
func _on_DraftButton_pressed( ): 
	SCORE.make_invisible();
	OPTIONS.make_invisible(); 
	MENU.make_invisible();
	DRAFT.make_visible();  
	print("Clicked Game Menu Draft - Draft Cards GUI should now be visible.");
	DRAFT.start();
	pass # Replace with function body.

func _on_SettingsButton_pressed( ):
	SCORE.make_invisible();
	OPTIONS.make_visible(); 
	MENU.make_invisible();
	DRAFT.make_invisible();  
	print("Clicked Options - Options GUI should now be visible.");
	OPTIONS.start();
	pass # Replace with function body.
