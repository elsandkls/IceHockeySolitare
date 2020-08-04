extends Node2D

var PlayerDB_matrix = [];   
var TITLESCREEN = load("res://Resources/Scripts/TitleScreen.gd"); 
var GUI = load("res://Resources/Scripts/GUI.gd"); 
var SAVEGAME = load("res://Resources/SaveGames/SafeFileNode.gd").new();
var user_name = 0; 
var user_color = 0;  
var user_cash = 0;  
var user_score = 0;   

func _ready():  
	### todo
	# needs to make the title screen visible on load
	# then pause for a few seconds
	# then hide the titie screen
	# then display the game menu
	#TITLESCREEN.make_visible();
	#TITLESCREEN.make_invisible();
	var SaveGameContent = savegame_system_loadfromfile();
	var SaveGameContent_matrix = SAVEGAME.parse_save_content(SaveGameContent);
	user_cash  = SAVEGAME.extract_cash_total(SaveGameContent_matrix);
	user_score = SAVEGAME.extract_score_total(SaveGameContent_matrix);
	user_name  = SAVEGAME.extract_user_name_total(SaveGameContent_matrix);
	user_color = SAVEGAME.extract_user_color_total(SaveGameContent_matrix);
	cash_display_system(user_cash); 
	score_display_system(user_score);
	GUI.Make_Menu_visible(); 
	pass # Replace with function body.
 
func color_display_system(user_color): 
	pass;
	
func score_display_system(user_score):
	get_node("VBoxContainer/HBoxContainer/RTL_CASH_VAR").set_text(user_score);
	pass;
	
func cash_display_system(user_cash):
	get_node("VBoxContainer/HBoxContainer2/RTL_SCORE_VAR").set_text(user_cash);
	pass;
	
func cash_system_increase(cash, amount):
	cash = cash + amount;
	return(cash);
	
func cash_system_decrease(cash, amount):
	cash = cash - amount;
	return(cash);
	
func cash_system_savetodb():
	SAVEGAME.saveGame();
	pass;

func savegame_system_loadfromfile():
	var SaveGameContent = SAVEGAME.loadGame(); 
	return(SaveGameContent);
