extends Node2D
 
# This is DraftCardGUI.gd 
onready var PLAYERDB = get_node("../PlayerDb")
onready var GUI = get_node("../Gui_Scene");
var PlayerDB_matrix = [];
var temp_node_name = ""; 
var PlayerCharacterCard = "object";
var image_column_id = 0;   
var DRAFTCARD = self;
var my_z_index = 0; 

# Called when the node enters the scene tree for the first time.
func _ready(): 
	#print("Draft Card GUI Ready")
	GUI  = get_node("../Gui_Scene");
	PLAYERDB = get_node("../PlayerDb") 
	DRAFTCARD = self; 
	pass; # Replace with function body.

func start():
	make_visible();
	new();
	pass;
	
func stop():	 
	make_invisible();
	pass;
	
func new():  
	PLAYERDB.start();
	build_card();
	pass;
	
func build_card():
	PlayerDB_matrix = PLAYERDB.get_PlayerDBMatrix(); 
	var temp_node_text = "";
	var temp_textid_id = "";
	var temp_textid_fn = "";
	var temp_textid_ln = "";
	var temp_textid_height = "";
	var temp_textid_weight = "";
	var temp_textid_shots = "";
	var temp_textid_born = "";
	var temp_textid_city = "";
	var temp_textid_country = "";
	var base_path = "res://Resources/SharedDB/player_db_images/";
	var base_node_path = "DraftCardsGUI/VBoxContainer/HBoxContainer/";
	
	for l in range(PlayerDB_matrix.size()):  
		var PlayerDB_Array = PlayerDB_matrix[l].duplicate();
		var PlayerDB_EntryCount = PlayerDB_Array.size();
		for n in range(PlayerDB_EntryCount):
			#print(String(l) + ":" + String(n) + ":" + PlayerDB_Array[n]) # Prints n entry 
			if l == 0:
				if PlayerDB_Array[n] == "id":
					image_column_id = n;
					temp_textid_id = n;
				if PlayerDB_Array[n] == "First Name":
					image_column_id = n;
					temp_textid_fn = n;
				if PlayerDB_Array[n] == "Last Name":
					image_column_id = n;
					temp_textid_ln = n;
				if PlayerDB_Array[n] == "Height":
					image_column_id = n;
					temp_textid_height = n;
				if PlayerDB_Array[n] == "Weight":
					image_column_id = n;
					temp_textid_weight = n;
				if PlayerDB_Array[n] == "Shoots":
					image_column_id = n;
					temp_textid_shots = n;
				if PlayerDB_Array[n] == "Born":
					image_column_id = n;
					temp_textid_born = n;
				if PlayerDB_Array[n] == "LocationCity":
					image_column_id = n;
					temp_textid_city = n;
				if PlayerDB_Array[n] == "LocationCountry":
					image_column_id = n;
					temp_textid_country = n;
				if PlayerDB_Array[n] == "image":
					image_column_id = n;
					temp_node_name = n; 
			if l == 1:
				temp_node_name = base_node_path + "VBoxPlayer1/BG_Player_1/NinePatchRect/TexRec_PlayerImage_Slot_001";
				temp_node_text = base_node_path + "VBoxPlayer1/BG_Player_1/RTLPlayer1"
				#print("player node 1 connected") 
				_swap_player_image_on_card( PlayerDB_Array, base_path);
				_swap_player_description_on_card(temp_node_text, PlayerDB_Array, temp_textid_id, temp_textid_fn, temp_textid_ln, temp_textid_height, temp_textid_weight, temp_textid_shots, temp_textid_born, temp_textid_city, temp_textid_country);
				#print("player node 1 image loaded")
			if l == 2:
				temp_node_name = base_node_path + "VBoxPlayer2/BG_Player_2/NinePatchRect2/TexRec_PlayerImage_Slot_002";
				temp_node_text = base_node_path + "VBoxPlayer2/BG_Player_2/RTLPlayer2"
				#print("player node 2 connected") 
				_swap_player_image_on_card( PlayerDB_Array, base_path);
				_swap_player_description_on_card(temp_node_text, PlayerDB_Array, temp_textid_id, temp_textid_fn, temp_textid_ln, temp_textid_height, temp_textid_weight, temp_textid_shots, temp_textid_born, temp_textid_city, temp_textid_country);
				#print("player node 2 image loaded")
			if l == 3:
				temp_node_name = base_node_path + "VBoxPlayer3/BG_Player_3/NinePatchRect3/TexRec_PlayerImage_Slot_003";
				temp_node_text = base_node_path + "VBoxPlayer3/BG_Player_3/RTLPlayer3"
				#print("player node 3 connected")
				_swap_player_image_on_card( PlayerDB_Array, base_path);
				_swap_player_description_on_card(temp_node_text, PlayerDB_Array, temp_textid_id, temp_textid_fn, temp_textid_ln, temp_textid_height, temp_textid_weight, temp_textid_shots, temp_textid_born, temp_textid_city, temp_textid_country);
				#print("player node 3 image loaded")
			if l == 4:
				temp_node_name = base_node_path + "VBoxPlayer4/BG_Player_4/NinePatchRect4/TexRec_PlayerImage_Slot_004";
				temp_node_text = base_node_path + "VBoxPlayer4/BG_Player_4/RTLPlayer4"
				#print("player node 4 connected")
				_swap_player_image_on_card( PlayerDB_Array, base_path);
				_swap_player_description_on_card(temp_node_text, PlayerDB_Array, temp_textid_id, temp_textid_fn, temp_textid_ln, temp_textid_height, temp_textid_weight, temp_textid_shots, temp_textid_born, temp_textid_city, temp_textid_country);
				#print("player node 4 image loaded")
				
	pass;

func _swap_player_image_on_card(PlayerDB_Array, base_path):
	PlayerCharacterCard = get_node(temp_node_name);
	var new_image_location = PlayerDB_Array[image_column_id];
	new_image_location = base_path + new_image_location;
	var ImageNode = load(new_image_location);
	PlayerCharacterCard.texture = ImageNode;
	#print(new_image_location);
	#print(ImageNode);
	pass;
	
func _swap_player_description_on_card(temp_node_text, PlayerDB_Array, _textid_id, _textid_fn, _textid_ln, _textid_height, _textid_weight, _textid_shots, _textid_born, _textid_city, _textid_country):
	PlayerCharacterCard = get_node(temp_node_text)
	var new_card_text_message =                    "Name: "        + str( PlayerDB_Array[_textid_ln] ) ;
	new_card_text_message = new_card_text_message + " , "          + str( PlayerDB_Array[_textid_fn] )       + '\n';   
	new_card_text_message = new_card_text_message + "Height: "     + str( PlayerDB_Array[_textid_height] )   + '\n';   
	new_card_text_message = new_card_text_message + "Weight: "     + str( PlayerDB_Array[_textid_weight] )   + '\n'; 
	new_card_text_message = new_card_text_message + "Shots: "      + str( PlayerDB_Array[_textid_shots] )    + '\n'; 
	new_card_text_message = new_card_text_message + "Born: "       + str( PlayerDB_Array[_textid_born] )     + '\n'; 
	new_card_text_message = new_card_text_message + "City: "       + str( PlayerDB_Array[_textid_city] )     + '\n'; 
	#new_card_text_message = new_card_text_message + "Country: "    + str( PlayerDB_Array[_textid_country] )  + '\n'; 
	PlayerCharacterCard.set_text(new_card_text_message);
	pass;
	
	
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
	my_z_index = self.get_z_index();
	self.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check != 1):
		print("DraftCardGUI set to show. "); 
		
func make_invisible(): 
	self.hide();	 
	self.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check != 0):
		print("DraftCardGUI set to hide. "); 

func check_visiblity():
	if self.visible:
		#print("DraftCardGUI is visible. ");
		return(1);
	else:
		#print("DraftCardGUI is not visible. ");
		return(0);
	pass;

func _on_ReturnToMenuButton_pressed():     
	GUI = get_parent().CONNECT_ONESHOT;
	GUI._on_ReturnToMenuButton_pressed();
	pass;
