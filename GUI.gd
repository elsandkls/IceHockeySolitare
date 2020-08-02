extends Control
 
var GRID = load("res://Grid.gd").new()
var OPTIONS = load("res://OptionsGUI.gd").new()
var SCORE = load("res://ScoreGUI.gd").new()
var DRAFT = load("res://DraftCardGUI.gd").new()
var MENU = load("res://GameMenu.gd").new()
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
	print("Settings should now be visible.");
	OPTIONS.make_visible();
	OPTIONS.start();
	pass # Replace with function body.


func _on_ExitGameButton_pressed():
	SAVEGAME.saveGame(SAVEGAME.content);
	get_tree().quit(-1)
	pass # Replace with function body.


func _on_ScoresButton_pressed():  
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_invisible(); 
	print("High Scores should now be visible.");
	SCORE.make_visible();
	SCORE.start();
	pass # Replace with function body.


func _on_ReturnToMenuButton_pressed():     
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_visible();
	print("GameMenu should now be visible.");
	pass # Replace with function body.


func _on_PlayButton_pressed():	    
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_invisible();
	print("Grid or the Table should now be visible."); 
	GRID.start();
	GRID.build_deck();
	pass # Replace with function body.


func _on_DraftButton_pressed(): 
	SCORE.make_invisible();
	OPTIONS.make_invisible(); 
	MENU.make_invisible();
	DRAFT.make_visible();  
	print("Draft Cards GUI should now be visible.");
	DRAFT.start();
	pass # Replace with function body.
