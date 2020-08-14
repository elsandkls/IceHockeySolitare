extends Node2D

# This is Game Window script
#var PlayerDB_matrix = [];     
var SAVEGAME =[];

func _ready():   
	self.make_visible();
	Display_TitleScreen();
	#create_timer(400);
	#Setup_SaveGame(); 
	#create_timer(400);
	#Display_Grid();
	#create_timer(400);
	#Display_GUI();
	
	
func ToDo():
	### todo
	# needs to make the title screen visible on load
	# then pause for a few seconds
	# then hide the titie screen
	# then display the game menu 
	pass;
	
func Display_TitleScreen():
	print("Display Title Scene"); 
	var TITLESCREEN_SCENE = load("res://Resources/Scenes/TitleScreen.tscn"); 
	TITLESCREEN_SCENE.instance();
	#self.add_child(TITLESCREEN)
	var TITLESCREEN_SCRIPT = load("res://Resources/Scripts/TitleScreen.gd"); 
	var TITLESCREEN = TITLESCREEN_SCRIPT.new();
	TITLESCREEN.make_visible(); 
	TITLESCREEN.create_timer(200);
	TITLESCREEN.make_invisible();
	# Remove the title screen 
	self.remove_child(TITLESCREEN) 
	TITLESCREEN.call_deferred("free"); 
	pass;
	
func Display_Grid():
	print("Loadiing game..............."); 
	var GRID_SCENE = load("res://Resources/Scenes/Grid.tscn"); 
	var GRID = GRID_SCENE.instance(); 
	self.add_child(GRID); 
	GRID.make_visible();  
	return(GRID);
	 
func Display_GUI():
	print("Load GUI, and main menu. "); 	
	var GUI_SCENE = load("res://Resources/Scenes/GUI.tscn"); 
	var GUI = GUI_SCENE.instance();    
	self.add_child(GUI); 
	GUI.make_visible();   	
	return(GUI);
	
func Setup_SaveGame():
	print("Load save game content: "); 	
	var user_name = 0; 
	var user_color = 0;  
	var user_cash = 0;  
	var user_score = 0;   
	SAVEGAME = load("res://Resources/SaveGames/SaveGameNode.gd");
	SAVEGAME.new();
	var SaveGameContent = savegame_system_loadfromfile(SAVEGAME);
	var SaveGameContent_matrix = SAVEGAME.parse_save_content(SaveGameContent);
	user_cash  = SAVEGAME.extract_cash_total(SaveGameContent_matrix);
	user_score = SAVEGAME.extract_score_total(SaveGameContent_matrix);
	user_name  = SAVEGAME.extract_user_name_total(SaveGameContent_matrix);
	user_color = SAVEGAME.extract_user_color_total(SaveGameContent_matrix);
	cash_display_system(user_cash); 
	score_display_system(user_score);
	color_display_system(user_color);
	name_display_system(user_name);
	return(SAVEGAME);
	
func color_display_system(_color): 
	print(_color);
	pass; 
	
func name_display_system(_name): 
	print(_name);
	pass; 
	
func score_display_system(_score):
	var RTL_SCORE_VAR = get_node("VBoxContainer/HBoxContainer/RTL_SCORE_VAR")
	RTL_SCORE_VAR.set_text(_score);
	pass;
	
func cash_display_system(_cash):
	var RTL_CASH_VAR = get_node("VBoxContainer/HBoxContainer2/RTL_CASH_VAR")
	RTL_CASH_VAR.set_text(_cash);
	pass;
	
func cash_system_increase(cash, amount):
	cash = cash + amount;
	return(cash);
	
func cash_system_decrease(cash, amount):
	cash = cash - amount;
	return(cash);
	
func cash_system_savetodb(_SAVEGAME):
	_SAVEGAME.saveGame();
	pass;

func savegame_system_loadfromfile(_SAVEGAME):
	var SaveGameContent = _SAVEGAME.loadGame(); 
	return(SaveGameContent); 
	
func make_visible():
	print("Game Window: Make Visible");
	self.show();
	print("Game Window should now be Visible.");
	pass # Replace with function body.
	
func make_invisible():
	print("Game Window: Make inVisible");
	self.hide();
	print("Game Window should now be inVisible.");
	pass # Replace with function body.

func check_visiblity():
	if self.visible:
		print("Game Window is Visible. ");
		return(1);
	else:
		print("Game Window is not Visible. ");
		return(0);
	pass;

func _on_SettingsButton_pressed(GUI):
	GUI._on_SettingsButton_pressed();
	pass # Replace with function body.

func _on_ExitGameButton_pressed(GUI):
	GUI._on_ExitGameButton_pressed();
	pass # Replace with function body.

func _on_ScoresButton_pressed(GUI):
	GUI._on_ScoresButton_pressed();
	pass # Replace with function body.

func _on_ReturnToMenuButton_pressed(GUI):
	GUI._on_ReturnToMenuButton_pressed();
	pass # Replace with function body.


func create_timer(seconds): 
	var TIMER = get_node("Timer");
	TIMER.start(seconds);
