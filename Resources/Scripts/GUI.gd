extends Control

# This is GUI.gd

#Laod Scenes
var OPTIONS_SCENE =  preload("res://Resources/Scenes/OptionsGUI.tscn").instance();
var DRAFT_SCENE =  preload("res://Resources/Scenes/DraftCardsGUI.tscn").instance();
var MENU_SCENE =  preload("res://Resources/Scenes/GameMenuGUI.tscn").instance();
var SCORE_SCENE =  preload("res://Resources/Scenes/ScoreGUI.tscn").instance();
#Load scripts
var GRID = load("res://Resources/Scripts/Grid.gd").new()
var OPTIONS = load("res://Resources/Scripts/OptionsGUI.gd").new()
var SCORE = load("res://Resources/Scripts/ScoreGUI.gd").new()
var DRAFT = load("res://Resources/Scripts/DraftCardGUI.gd").new()
var MENU = load("res://Resources/Scripts/GameMenuGUI.gd").new()

#Load Safe Game Data
var SAVEGAME = load("res://Resources/SaveGames/SafeFileNode.gd").new();

func _input(event): 
	if event.is_action_pressed("GameMenu"):
		print("GameMenu, Escape Pressed.");
		if MENU.check_visiblity():
			MENU.make_invisible(); 
		else:
			MENU.make_visible();
			print("GameMenu should now be visible.");
	pass;	
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_MENU():
	return(MENU); 

func _on_SettingsButton_pressed(): 
	SCORE.make_invisible(); 
	DRAFT.make_invisible(); 
	MENU.make_invisible(); 
	print("Clicked Game Menu Settings - Settings should now be visible.");
	OPTIONS.make_visible();
	OPTIONS.start();
	pass # Replace with function body.

func _on_ExitGameButton_pressed():
	#SAVEGAME.saveGame(SAVEGAME.content);
	get_tree().quit(-1)
	pass # Replace with function body.

func _on_ScoresButton_pressed():  
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_invisible(); 
	print("Clicked Game Menu Score - High Scores should now be visible.");
	SCORE.make_visible(); 
	SCORE.start();
	pass # Replace with function body.

func _on_ReturnToMenuButton_pressed():     
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_visible(); 
	print("Clicked Return To Menu - GameMenu should now be visible. Score, Options, and Draft should be hidden.");
	pass # Replace with function body.

func Make_Menu_visible():
	print("Game Start: New GameMenu");
	SCORE.make_invisible();
	OPTIONS.make_invisible(); 
	DRAFT.make_invisible(); 	
	MENU.make_visible();
	print("New GameMenu should now be visible. Score, Options, and Draft should be hidden.");
	pass # Replace with function body.
