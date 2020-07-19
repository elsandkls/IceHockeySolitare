extends Control

onready var GF = preload("res://Resources/SharedDB/PlayerDB.gd").new();

var PlayerDB_matrix = [];
var temp_node_name = ""; 
var PlayerCharacterCard = "object";
var image_column_id = 0; 
# Called when the node enters the scene tree for the first time.
func _ready():
	build_card();
	pass; # Replace with function body.

func build_card():
	#PlayerDB_matrix = get_node("res://Resources/SharedDB/PlayerDB.gd").PlayerDB_matrix.duplicate();
	print("PlayerDB accessed in the DraftCardGui: " + String(PlayerDB_matrix.size() ));
	
	for l in range(PlayerDB_matrix.size()):  
		var PlayerDB_Array = PlayerDB_matrix[l].duplicate()
		var PlayerDB_EntryCount = PlayerDB_Array.size()
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


func _on_TextureButton3_pressed():
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	pass # Replace with function body.


func _on_TextureButton_pressed():
	pass # Replace with function body.
