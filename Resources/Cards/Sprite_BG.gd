extends Sprite

# Team Color is the front color on the cards or Background to the visible rank.
onready var card_tex_BG_1 = preload("res://Resources/Cards/Blank_Blue.png")
onready var card_tex_BG_2 = preload("res://Resources/Cards/Blank_Green.png")
onready var card_tex_BG_3 = preload("res://Resources/Cards/Blank_Orange.png")
onready var card_tex_BG_4 = preload("res://Resources/Cards/Blank_Purple.png")
onready var card_tex_BG_5 = preload("res://Resources/Cards/Blank_Red.png")
onready var card_tex_BG_6 = preload("res://Resources/Cards/Blank_Yellow.png")
onready var card_tex_BG_7 = preload("res://Resources/Cards/Blank.png") 
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setTextureSprite(colour): 
	match colour:
		1:
			set_texture(card_tex_BG_1) 
		2:
			set_texture(card_tex_BG_2)
		3:
			set_texture(card_tex_BG_3)
		4:
			set_texture(card_tex_BG_4)
		5:
			set_texture(card_tex_BG_5)
		6:
			set_texture(card_tex_BG_6)
		7:
			set_texture(card_tex_BG_7)
			
