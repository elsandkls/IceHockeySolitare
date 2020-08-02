extends Sprite

# These are the card rank graphics.
onready var card_tex1 = preload("res://Resources/Cards/Card_A.png")
onready var card_tex2 = preload("res://Resources/Cards/Card_2.png")
onready var card_tex3 = preload("res://Resources/Cards/Card_3.png")
onready var card_tex4 = preload("res://Resources/Cards/Card_4.png")
onready var card_tex5 = preload("res://Resources/Cards/Card_5.png")
onready var card_tex6 = preload("res://Resources/Cards/Card_6.png")
onready var card_tex7 = preload("res://Resources/Cards/Card_7.png")
onready var card_tex8 = preload("res://Resources/Cards/Card_8.png")
onready var card_tex9 = preload("res://Resources/Cards/Card_9.png")
onready var card_tex10 = preload("res://Resources/Cards/Card_10.png")
onready var card_tex11 = preload("res://Resources/Cards/Card_11.png")
onready var card_tex12 = preload("res://Resources/Cards/Card_12.png")
onready var card_tex13 = preload("res://Resources/Cards/Card_13.png")

func _ready(): 
	pass;

func set_TextureSprite(rank): 
	match rank:
		1:
			set_texture(card_tex1)
		2:
			set_texture(card_tex2)
		3:
			set_texture(card_tex3)
		4:
			set_texture(card_tex4)
		5:
			set_texture(card_tex5)
		6:
			set_texture(card_tex6)
		7:
			set_texture(card_tex7)
		8:
			set_texture(card_tex8)
		9:
			set_texture(card_tex9)
		10:
			set_texture(card_tex10)
		11:
			set_texture(card_tex11)
		12:
			set_texture(card_tex12)
		13:
			set_texture(card_tex13)

func _input(event): 
	pass;
 
