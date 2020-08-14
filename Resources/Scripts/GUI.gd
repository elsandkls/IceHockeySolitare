extends Control

# This is GUI.gd   
var OPTIONS = [];
var DRAFT = [];
var SCORE = [];  
var GAMEMENU = [];  

# Called when the node enters the scene tree for the first time.
func _ready():
	#Laod Scenes 
	OPTIONS = get_OptionsGUI();
	DRAFT = get_DraftCardsGUI();
	SCORE = get_ScoreGUI();  
	GAMEMENU = get_GameMenuGUI();  
	pass # Replace with function body.
	
func _input(event): 
	if event.is_action_pressed("GameMenu"):
		print("GameMenu, Escape Pressed.");
		if GAMEMENU.check_visiblity():
			GAMEMENU.make_invisible(); 
		else:	
			GAMEMENU.make_visible();
			print("GameMenu should now be visible.");
	pass;	

func new():
	pass # Replace with function body.
  
func _on_PlayButton_pressed():	    
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	GAMEMENU.make_invisible(); 
	self.make_invisible();
	print("Clicked Game Menu - Play - Grid or the Table should now be visible."); 
	var GAME_WINDOW = self.get_parent()
	var GRID = GAME_WINDOW.get_child("Grid")
	GRID.make_visible();
	GRID.start();
	GRID.build_deck();
	pass # Replace with function body.

func _on_SettingsButton_pressed(): 
	SCORE.make_invisible(); 
	DRAFT.make_invisible(); 
	GAMEMENU.make_invisible(); 
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
	GAMEMENU.make_invisible(); 
	print("Clicked Game Menu Score - High Scores should now be visible.");
	SCORE.make_visible(); 
	SCORE.start();
	pass # Replace with function body.

func _on_ReturnToMenuButton_pressed():     
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	GAMEMENU.make_visible(); 
	print("Clicked Return To Menu - GameMenu should now be visible. Score, Options, and Draft should be hidden.");
	pass # Replace with function body.

func Make_Menu_visible():
	print("Game Start: New GameMenu");
	SCORE.make_invisible();
	OPTIONS.make_invisible(); 
	DRAFT.make_invisible();
	GAMEMENU.make_visible();
	print("New GameMenu should now be visible. Score, Options, and Draft should be hidden.");
	pass # Replace with function body.

func make_visible():
	print("Game GUI: Make Visible");
	self.show();
	print("New Game GUI: should now be visible.");
	pass # Replace with function body.
	
func make_invisible():
	print("Game GUI: Make inVisible");
	self.hide();
	print("New Game GUI: should now be invisible.");
	pass # Replace with function body.


func get_OptionsGUI():
	print("Display OptionsGUI Scene"); 
	var OPTIONS_SCENE = load("res://Resources/Scenes/OptionsGUI.tscn"); 
	var OPTION = OPTIONS_SCENE.instance();
	self.add_child(OPTION); 
		
func get_DraftCardsGUI():
	print("Display DraftCardsGUI Scene"); 
	var DRAFT_SCENE = load("res://Resources/Scenes/DraftCardsGUI.tscn"); 
	var DRAFTS = DRAFT_SCENE.instance();
	self.add_child(DRAFTS); 
	
func get_ScoreGUI():
	print("Display ScoreGUI Scene"); 
	var SCORE_SCENE = load("res://Resources/Scenes/ScoreGUI.tscn"); 
	var SCORES = SCORE_SCENE.instance();
	self.add_child(SCORES); 
	
func get_GameMenuGUI():
	print("Display ScoreGUI Scene"); 
	var GAMEMENU_SCENE = load("res://Resources/Scenes/ScoreGUI.tscn"); 
	var GAMEMENUS = GAMEMENU_SCENE.instance();
	self.add_child(GAMEMENUS); 
