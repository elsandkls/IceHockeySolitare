extends Control
 
# This is DraftCardGUI.gd 
var PlayerDB = load("res://Resources/SharedDB/PlayerDB.gd");
var PlayerDB_matrix = [];
var temp_node_name = ""; 
var PlayerCharacterCard = "object";
var image_column_id = 0;  
var GUI = [];  
var DRAFTCARD = [];  
var my_z_index = 0;
var PARENT = self.get_parent();

# Called when the node enters the scene tree for the first time.
func _ready(): 
	GUI = get_parent();
	DRAFTCARD = self;
	pass; # Replace with function body.

func start(): 
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
				temp_node_name = "VBoxContainer/HBoxContainer/VBoxPlayer2/BG_Player_2/NinePatchRect2/TexRec_PlayerImage_Slot_001";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 1 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 1 image loaded")
			if n == 2:
				temp_node_name = "VBoxContainer/HBoxContainer/VBoxPlayer2/BG_Player_2/NinePatchRect2/TexRec_PlayerImage_Slot_002";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 2 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 2 image loaded")
			if n == 3:
				temp_node_name = "VBoxContainer/HBoxContainer/VBoxPlayer2/BG_Player_2/NinePatchRect2/TexRec_PlayerImage_Slot_003";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 3 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 3 image loaded")
			if n == 4:
				temp_node_name = "VBoxContainer/HBoxContainer/VBoxPlayer2/BG_Player_2/NinePatchRect2/TexRec_PlayerImage_Slot_004";
				PlayerCharacterCard = get_node(temp_node_name);
				print("player node 4 connected")
				PlayerCharacterCard.texture(PlayerDB_Array[image_column_id]); 
				print("player node 4 image loaded")
				
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
	my_z_index = PARENT.get_z_index();
	PARENT.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check != 1):
#		print("DraftCardGUI set to show. ");
#	else:
		#get_node("DraftCardGUI").show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("DraftCardGUI set to show. ");
		
func make_invisible(): 
	self.hide();	 
	PARENT.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check != 0):
#		print("DraftCardGUI set to hide. ");
#	else:
		#get_node("YSort/GUI/DraftCardGUI").hide();
		var check2 = self.check_visiblity(); 
		if(check2 == 0):
			print("DraftCardGUI set to hide. ");

func check_visiblity():
	if self.visible:
		#print("DraftCardGUI is viible. ");
		return(1);
	else:
		#print("DraftCardGUI is not visible. ");
		return(0);
	pass;

func _on_ReturnToMenuButton_pressed():     
	GUI = get_parent().CONNECT_ONESHOT;
	GUI._on_ReturnToMenuButton_pressed();
	pass;
