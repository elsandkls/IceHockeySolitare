extends Node2D

onready var SELFNODE = self;
onready var SELFSPRITE = self.get_node("Sprite_Holder");
var my_z_index = 0; 

# Called when the node enters the scene tree for the first time.
func _ready():
	SELFNODE = self;
	#print(SELFNODE);
	SELFSPRITE = self.get_node("Sprite_Holder");
	#print(SELFSPRITE);
	pass # Replace with function body.
	
func new():
	pass # Replace with function body.

func start():
	SELFNODE = self; 
	#print(SELFNODE);
	print("SELFNODE pile initiated");
	pass;
	
func end():
	SELFNODE = self; 
	#print(SELFNODE);
	print("SELFNODE pile stopped");
	pass;
	
func get_uppper_right_x(): 
	SELFNODE = self; 
	#print(SELFNODE);
	var upper_right_x = Vector2( SELFNODE.get_transform().get_origin() ).x; 
	#print(upper_right_x);
	return(upper_right_x);

func get_uppper_right_y():
	SELFNODE = self; 
	#print(SELFNODE);
	var upper_right_y = Vector2( SELFNODE.get_transform().get_origin() ).y; 
	#print(upper_right_y);
	return(upper_right_y);

func get_size_x():
	SELFSPRITE = self.get_node("Sprite_Holder");
	#print(SELFSPRITE); 
	var size_x = SELFSPRITE.texture.get_size().x; 
	return(size_x);

func get_size_y(): 
	SELFSPRITE = self.get_node("Sprite_Holder");
	#print(SELFSPRITE); 
	var size_y = SELFSPRITE.texture.get_size().y;
	return(size_y);

func make_visible():  	
	self.show();	
	my_z_index = self.get_z_index();
	self.set_z_index(100);
	var check = self.check_visiblity();  
		
func make_invisible(): 
	self.hide();	 
	self.set_z_index(my_z_index);
	var check = self.check_visiblity();  

func check_visiblity():
	if self.visible:
		#print("DraftCardGUI is visible. ");
		return(1);
	else:
		#print("DraftCardGUI is not visible. ");
		return(0);
	pass;
