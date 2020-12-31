extends Node2D

# This is Game Window script
#var PlayerDB_matrix = [];     
var SAVEGAME =[];    
onready var GUI = self.get_node("../Gui_Scene"); # 
onready var GRID = self.get_node("../Grid_Scene"); # 
onready var TITLESCREEN = self.get_node("../TitleScreen_Scene"); # 
onready var GAMEMENU = self.get_node("../GameMenu_Scene"); # 
onready var SCORES = self.get_node("../Score_Scene"); # 
onready var OPTIONS = self.get_node("../Options_Scene"); # 
onready var DRAFT = self.get_node("../DraftCards_Scene"); #  


################## Audio Files ##########################
onready var AlarmBell = preload("res://Resources/Sounds/Pause.wav")
onready var Player = get_node("AudioStreamPlayer2D");
#onready var sample_player = $AudioStreamPlayer

################### Timer Variables ##########################
var minutes = 20;
var seconds = 03;
const TIME_PERIOD = 1; # 500ms
var time = 0;
var status = 0;
var timesup = 0;
var animation_speed = 1;
var end_buffer = 30;
onready var RTL_MINUTES = get_node("VBoxContainer/HBoxContainer4/RTL_Minutes");
onready var RTL_SECONDS = get_node("VBoxContainer/HBoxContainer4/RTL_Seconds");


func _ready():   
	#print("Game Window Ready")
	self.set_process_input(false)
	self.make_visible(); 
	self.start(); 
	
	
func start():
	#print("Game Window Loading Title Screen")
	Display_TitleScreen(); 
	#Setup_SaveGame();  
	#print("Game Window Loading Game Grid")
	Display_Grid(); 
	#print("Game Window Loading Game GUI")
	Display_GUI();
	#print("Finished Game Window Load.") 
	pass;
	
func Display_TitleScreen():
	#print("Display Title Scene (from Game_Window)");  
	TITLESCREEN = get_node("../TitleScreen_Scene")  
	TITLESCREEN.start(); 
	pass;
	
func Display_Grid():
	#print("Loadiing game grid ............... (from Game_Window)"); 
	GRID = get_node("../Grid_Scene") 
	#GRID.start();
	#print(GRID);
	return(GRID);
	 
func Display_GUI():
	#print("Load GUI. (from Game_Window)");
	GUI = get_node("../Gui_Scene") 
	GUI.Make_Menu_visible();
	#print(GUI);         
	return(GUI);
	
func Setup_SaveGame():
	#print("Load save game content: "); 	
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
	if(_color > 0):
		print(_color);
	pass; 
	
func name_display_system(_name): 
	if(_name > 0):
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
	#print("Game Window: Make Visible");
	self.show();
	#print("Game Window should now be Visible.");
	pass # Replace with function body.
	
func make_invisible():
	#print("Game Window: Make inVisible");
	self.hide();
	#print("Game Window should now be inVisible.");
	pass # Replace with function body.

func check_visiblity():
	if self.visible:
		#print("Game Window is Visible. ");
		return(1);
	else:
		#print("Game Window is not Visible. ");
		return(0);
	pass;

func _on_SettingsButton_pressed():
	GUI._on_SettingsButton_pressed();
	pass # Replace with function body.

func _on_ExitGameButton_pressed():
	GUI._on_ExitGameButton_pressed();
	pass # Replace with function body.

func _on_ScoresButton_pressed():
	GUI._on_ScoresButton_pressed();
	pass # Replace with function body.

func _on_ReturnToMenuButton_pressed():
	GUI._on_ReturnToMenuButton_pressed();
	pass # Replace with function body.

func create_timer(seconds): 
	var TIMER = get_node("Timer");
	TIMER.start(seconds);

func _input(event):	  
	#InputEventMouseButton : 
	#button_index=BUTTON_LEFT,  
	#pressed=true, 
	if event is InputEventMouseButton:
		#print(event.as_text())
		if event.button_index == BUTTON_LEFT:
			if event.pressed: 
				var MAX_NODE = check_z_index();
				turn_on_mouse_focus(MAX_NODE, event)
				#MAX_NODE.mouse_input(event);  
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_Q:
			get_tree().quit();
	pass;		

func _process(delta):
	time += delta
	if time > TIME_PERIOD: 
		update_timer();
		time = 0;
	pass

func _on_TextureButton_pressed(): #menu
	GUI._on_ReturnToMenuButton_pressed()
	pass # Replace with function body.
func _on_TextureButton2_pressed(): #options
	GUI._on_SettingsButton_pressed()
	pass # Replace with function body.
func _on_TextureButton3_pressed(): #scores
	GUI._on_ScoresButton_pressed()
	pass # Replace with function body.
func _on_TextureButton4_pressed(): #draft
	GUI._on_DraftButton_pressed()
	pass # Replace with function body.
func _on_TextureButton5_pressed(): #playnew
	GUI._on_PlayButton_pressed()
	pass # Replace with function body.
func _on_TextureButton6_pressed(): #TitleScreen
	GUI._on_TitleScreenButton_pressed()
	pass # Replace with function body.
	
func check_z_index():
	var test_z_index = self.get_z_index();
	var max_z_index = 0;
	if test_z_index > max_z_index:
		max_z_index = test_z_index;
	var MAX_NODE = 0; 
	var CURR_NODE = 0; 
		
	var my_array = [TITLESCREEN, GAMEMENU, SCORES, OPTIONS, DRAFT, GRID]
	for n in range (my_array.size()):
		CURR_NODE = my_array[n]; 
		test_z_index = CURR_NODE.get_z_index();
		if max_z_index < test_z_index:
			max_z_index = test_z_index;
			MAX_NODE = CURR_NODE; 
	return(MAX_NODE) 
			
func turn_on_mouse_focus(ACTIVE_NODE, event):
	#https://docs.godotengine.org/en/3.0/classes/class_control.html
	#https://godot-es-docs.readthedocs.io/en/latest/tutorials/inputs/mouse_and_input_coordinates.html
	#https://docs.godotengine.org/en/3.0/classes/class_texturebutton.html
	var PARENT = self.get_parent();
	PARENT.release_focus( ); 
	#print(PARENT);
	#print(ACTIVE_NODE);
	#print(event);
	ACTIVE_NODE.grab_click_focus( );
	ACTIVE_NODE.grab_focus( );
	ACTIVE_NODE.has_focus( );
	ACTIVE_NODE._gui_input(event);
	ACTIVE_NODE.accept_event( );
	pass;

func update_timer(): 
	if timesup == 0:
		if seconds < 1:
			minutes = minutes - 1;
			seconds = 59;
		else:
			seconds = seconds -1;
	else:
		seconds = seconds + 1;
		
	RTL_MINUTES.set_text(str(minutes).pad_zeros(2));
	RTL_SECONDS.set_text(str(seconds).pad_zeros(2));
		
	if(seconds <= 00):
		if(minutes <= 00):
			play_alarm_bell();
			timesup = 1;
			
	if(minutes <=0):
		if(timesup == 1):
			if(seconds >= end_buffer):
				get_tree().quit();

func play_alarm_bell(): 
	Player.stream = AlarmBell
	Player.play()			
