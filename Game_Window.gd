extends Node2D

var PlayerDB_matrix = []; 
var GUI = load("res://GUI.gd"); 
var SAVEGAME = load("res://Resources/SaveGames/SafeFileNode.gd").new();
var user_name = 0; 
var user_color = 0;  
var user_cash = 0;  
var user_score = 0;   

func _ready():  
	var SaveGameContent = savegame_system_loadfromfile();
	var SaveGameContent_matrix = SAVEGAME.parse_save_content(SaveGameContent);
	user_cash  = SAVEGAME.extract_cash_total(SaveGameContent_matrix);
	user_score = SAVEGAME.extract_score_total(SaveGameContent_matrix);
	user_name  = SAVEGAME.extract_user_name_total(SaveGameContent_matrix);
	user_color = SAVEGAME.extract_user_color_total(SaveGameContent_matrix);
	cash_display_system(user_cash); 
	GUI._on_ReturnToMenuButton_pressed(); 
	pass # Replace with function body.
 
func cash_display_system(user_cash):
	get_node("YSort/RTL_CASH_VAR").set_text(user_cash);
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
