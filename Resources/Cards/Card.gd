extends Node2D

export (String) var color;
var Move_Tween; 
var matched = false;

# These are the card rank graphics.
var card_tex1 = preload("res://Resources/Cards/Card_A.png")
var card_tex2 = preload("res://Resources/Cards/Card_2.png")
var card_tex3 = preload("res://Resources/Cards/Card_3.png")
var card_tex4 = preload("res://Resources/Cards/Card_4.png")
var card_tex5 = preload("res://Resources/Cards/Card_5.png")
var card_tex6 = preload("res://Resources/Cards/Card_6.png")
var card_tex7 = preload("res://Resources/Cards/Card_7.png")
var card_tex8 = preload("res://Resources/Cards/Card_8.png")
var card_tex9 = preload("res://Resources/Cards/Card_9.png")
var card_tex10 = preload("res://Resources/Cards/Card_10.png")
var card_tex11 = preload("res://Resources/Cards/Card_11.png")
var card_tex12 = preload("res://Resources/Cards/Card_12.png")
var card_tex13 = preload("res://Resources/Cards/Card_13.png")

# Team Color is the front color on the cards or Background to the visible rank.
var card_tex_BG_1 = preload("res://Resources/Cards/Blank_Blue.png")
var card_tex_BG_2 = preload("res://Resources/Cards/Blank_Green.png")
var card_tex_BG_3 = preload("res://Resources/Cards/Blank_Orange.png")
var card_tex_BG_4 = preload("res://Resources/Cards/Blank_Purple.png")
var card_tex_BG_5 = preload("res://Resources/Cards/Blank_Red.png")
var card_tex_BG_6 = preload("res://Resources/Cards/Blank_Yellow.png")
var card_tex_BG_7 = preload("res://Resources/Cards/Blank.png") 
 
# Sprite nodes for the cards
# For furture animations
onready var card_sprite_anim = get_node("Sprite_Anim")
# For the back of the card when it is face down
onready var card_sprite_bg = get_node("Sprite_BG")
# For the team color for the cards (front color, behind the text)
onready var card_sprite_front = get_node("Sprite_Front")
# For the card rank
onready var card_sprite_cardspec = get_node("Sprite_CardSpec")

# Called when the node enters the scene tree for the first time.
func _ready():
	Move_Tween = get_node("Move_Tween");

func move(target):
	Move_Tween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_SINE, Tween.EASE_OUT);
	Move_Tween.start();
 
#	pass
func dim():
	var sprite = get_node("Sprite_Anim");
	sprite.modulate = Color(1,1,1,.5); 


func setTextureForground(rank): 
	match rank:
		1:
			card_sprite_cardspec.set_texture(card_tex1)
		2:
			card_sprite_cardspec.set_texture(card_tex2)
		3:
			card_sprite_cardspec.set_texture(card_tex3)
		4:
			card_sprite_cardspec.set_texture(card_tex4)
		5:
			card_sprite_cardspec.set_texture(card_tex5)
		6:
			card_sprite_cardspec.set_texture(card_tex6)
		7:
			card_sprite_cardspec.set_texture(card_tex7)
		8:
			card_sprite_cardspec.set_texture(card_tex8)
		9:
			card_sprite_cardspec.set_texture(card_tex9)
		10:
			card_sprite_cardspec.set_texture(card_tex10)
		11:
			card_sprite_cardspec.set_texture(card_tex11)
		12:
			card_sprite_cardspec.set_texture(card_tex12)
		13:
			card_sprite_cardspec.set_texture(card_tex13)



func setTextureBackground(colour): 
	match colour:
		1:
			card_sprite_front.set_texture(card_tex_BG_1)
		2:
			card_sprite_front.set_texture(card_tex_BG_2)
		3:
			card_sprite_front.set_texture(card_tex_BG_3)
		4:
			card_sprite_front.set_texture(card_tex_BG_4)
		5:
			card_sprite_front.set_texture(card_tex_BG_5)
		6:
			card_sprite_front.set_texture(card_tex_BG_6)
		7:
			card_sprite_front.set_texture(card_tex_BG_7)
			
	
