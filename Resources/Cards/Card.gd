extends Node2D
 
#var matched = false;
# Sprite nodes for the cards 
var Move_Tween; 
var CARDSPRITE_ANIM  = preload("res://Resources/Cards/Sprite_Anim.gd"); 
var CARDSPRITE_BACK  = preload("res://Resources/Cards/Sprite_BG.gd");  
var CARDSPRITE_FACE  = preload("res://Resources/Cards/Sprite_Front.gd"); 
var CARDSPRITE_FACE_ID  = preload("res://Resources/Cards/Sprite_CardSpec.gd"); 
var CARDSPRITE_TWEEN = preload("res://Resources/Cards/Move_Tween.gd");  

# Called when the node enters the scene tree for the first time.
func _ready():  
	Move_Tween = get_node("Move_Tween");
	pass; 

func move(target):  
	CARDSPRITE_TWEEN = Move_Tween;
	CARDSPRITE_TWEEN.interpolate_property(self, "position", position, target, .3, Tween.TRANS_SINE, Tween.EASE_OUT);
	CARDSPRITE_TWEEN.start();
	pass; 
 
func dim(): 
	var new_CARDSPRITE_ANIM = CARDSPRITE_ANIM.new();
	new_CARDSPRITE_ANIM.modulate = Color(1,1,1,.5); 
	pass; 

func setNodePosition(NodeVector2Position):  
	#print(NodeVector2Position);
	self.position = NodeVector2Position; 
	pass; 

func setTextureForground_CardSpec(rank):  
	#print(rank);
	var new_CARDSPRITE_FACE_ID = CARDSPRITE_FACE_ID.new(); 
	new_CARDSPRITE_FACE_ID.set_TextureSprite(rank);
	pass; 

func setTextureBackground_FaceUp(colour):  
	var new_CARDSPRITE_FACE = CARDSPRITE_FACE.new(); 
	new_CARDSPRITE_FACE.setTextureSprite(colour)
	pass;
	
func setTextureBackground_FaceDown(colour):  
	var new_CARDSPRITE_BACK = CARDSPRITE_BACK.new(); 
	new_CARDSPRITE_BACK.setTextureSprite(colour)
	pass;
	
