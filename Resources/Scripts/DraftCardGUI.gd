extends Control
 
var PlayerDB = load("res://Resources/SharedDB/PlayerDB.gd");
var PlayerDB_matrix = [];
var temp_node_name = ""; 
var PlayerCharacterCard = "object";
var image_column_id = 0; 
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
	make_invisible();
	pass; # Replace with function body.

func start():
	#build_card();
	check_visiblity();
	### to do list
	#load db  
	#build_card();
	#update display 
	pass;
	
func build_card():
	PlayerDB_matrix = PlayerDB.get_PlayerDBMatrix();
	print(PlayerDB_matrix); 
	print("PlayerDB accessed in the DraftCardGui: " + String(PlayerDB_matrix.size() ));
	
	for l in range(PlayerDB_matrix.size()):  
		var PlayerDB_Array = PlayerDB_matrix[l].duplicate();
		var PlayerDB_EntryCount = PlayerDB_Array.size();
		for n in range(PlayerDB_EntryCount):
			print(String(l) + ":" + String(n) + ":" + PlayerDB_Array[n]) # Prints n entry 
			if n == 0:
				if PlayerDB_Array[n] == "image":
					image_column_id = n;
			if n == 1:
				temp_node_name = "GUI/DraftCardsGUI/HBoxContainer/VBoxPlayer1/BG_Player_1/NinePatchRect/TexRec_PlayerImage_Slot_001";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 1 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 1 image loaded")
			if n == 2:
				temp_node_name = "GUI/DraftCardsGUI/HBoxContainer/VBoxPlayer1/BG_Player_1/NinePatchRect/TexRec_PlayerImage_Slot_002";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 2 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 2 image loaded")
			if n == 3:
				temp_node_name = "GUI/DraftCardsGUI/HBoxContainer/VBoxPlayer1/BG_Player_1/NinePatchRect/TexRec_PlayerImage_Slot_003";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 3 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 3 image loaded")
			if n == 4:
				temp_node_name = "GUI/DraftCardsGUI/HBoxContainer/VBoxPlayer1/BG_Player_1/NinePatchRect/TexRec_PlayerImage_Slot_004";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 4 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 4 image loaded")
				
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton4_pressed():
	pass # Replace with function body.

func _on_TextureButton3_pressed():
	pass # Replace with function body.

func _on_TextureButton2_pressed():
	pass # Replace with function body.

func _on_TextureButton_pressed():
	pass # Replace with function body.
	
	 
func make_visible():  	
	self.show();	
	var check = self.check_visiblity(); 
	if(check == 1):
		print("DraftCardGUI set to show. ");
	else:
		get_node("YSort/GUI/DraftCardGUI").show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("DraftCardGUI set to show. ");
		
func make_invisible(): 
	self.hide();	
	var check = self.check_visiblity(); 
	if(check == 0):
		print("DraftCardGUI set to hide. ");
	else:
		get_node("YSort/GUI/DraftCardGUI").hide();
		var check2 = self.check_visiblity(); 
		if(check2 == 0):
			print("DraftCardGUI set to hide. ");

func check_visiblity():
	if self.visible:
		print("DraftCardGUI is viible. ");
		return(1);
	else:
		print("DraftCardGUI is not visible. ");
		return(0);
	pass;

func _on_ReturnToMenuButton_pressed():     
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_visible(); 
	print("Clicked Return To Menu - GameMenu should now be visible. Score, Options, and Draft should be hidden.");
	pass # Replace with function body.
