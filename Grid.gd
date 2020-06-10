extends Node2D

# Grid Variables
export (int) var width;
export (int) var height;
export (int) var x_start;
export (int) var y_start;
export (int) var offset;

# variables for pieces
var possible_cards = [
	preload("res://Resources/Cards/Card.tscn")
];

#Two dimensional array to hold coordinates x,z plane 
var my_deck = [];
var pile_cards_stock = [];
var pile_cards_talon = [];
var pile_cards_foundation1 = [];
var pile_cards_foundation2 = [];
var pile_cards_foundation3 = [];
var pile_cards_tableau_1 = [];
var pile_cards_tableau_2 = [];
var pile_cards_tableau_3 = [];
var pile_cards_tableau_4 = [];
var pile_cards_tableau_5 = [];
var pile_cards_tableau_6 = [];
var pile_cards_tableau_7 = [];

# Touch variables
var first_touch = Vector2(0,0);
var final_touch = Vector2(0,0);
var controlling =false;


func _ready(): 
	randomize();
	my_deck = make_a_deck(); 
	shuffle_the_deck();
	deal_game();
	 

func make_a_deck(): 
	var array = [];
	# 7 colors
	for i in range(7):
		# 13 cards per color 
		for l in range(13): 
			var card = spawn_cards(i, l);
			array.append(card); 
			print(card);
	return array;
	
 
func spawn_cards(color, rank):
	print(color);
	print(rank);
	var rand = floor(rand_range(0,possible_cards.size()));
	var card = possible_cards[rand].instance();
	add_child(card);
	card.position = pile_to_pixel(0,0); 
	card.setTextureForground(rank);
	card.setTextureBackground(color);
	return(card);
	

func shuffle_the_deck(): 
	my_deck.shuffle();
	pass;
	

func move_check():
	pass;
	

func move_card(column, row, direction):
	print(column);
	print(row);
	print(direction);
	pass;
	

func undo_move(column, row, direction): 
	print(column);
	print(row);
	print(direction);
	pass;
	

func clear_columns():
	pass;
	

func deal_game():
	var card = possible_cards[0].instance();
	var c = 1;
	
	for i in range(8): 
		# There are seven piles to deal first.
		if(i < 1):
			#do nothing we are skipping 0 as a pile
			print("pile 0");
		else:
			# time to deal the cards
			if( i < 2):
				print("pile 1");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/Tableau_1/Sprite_Holder").get_transform().get_origin();
				get_parent().get_node("Grid/Tableau_1/Sprite_Holder").add_child(card);
				pile_cards_tableau_1.append(card);
				my_deck.remove(c); 
				print("card");
				print(card);
				
			if( i < 3):
				print("pile 2");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c];
				card.position = get_parent().get_node("Grid/Tableau_2/Sprite_Holder").get_transform().get_origin();
				get_parent().get_node("Grid/Tableau_2/Sprite_Holder").add_child(card);
				pile_cards_tableau_2.append(card);  
				my_deck.remove(c); 
				print("card");
				print(card);
				
			if( i < 4):
				print("pile 3");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c];
				card.position = get_parent().get_node("Grid/Tableau_3/Sprite_Holder").get_transform().get_origin();
				get_parent().get_node("Grid/Tableau_3/Sprite_Holder").add_child(card);
				pile_cards_tableau_3.append(card);  
				my_deck.remove(c); 
				print("card");
				print(card);
				
			if( i < 5):
				print("pile 4");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/Tableau_4/Sprite_Holder").get_transform().get_origin();
				get_parent().get_node("Grid/Tableau_4/Sprite_Holder").add_child(card);
				pile_cards_tableau_4.append(card); 
				my_deck.remove(c); 
				print("card");
				print(card);
				
			if( i < 6):
				print("pile 5");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/Tableau_5/Sprite_Holder").get_transform().get_origin();
				get_parent().get_node("Grid/Tableau_5/Sprite_Holder").add_child(card);
				pile_cards_tableau_5.append(card);
				my_deck.remove(c); 
				print("card");
				print(card);
				
			if( i < 7):
				print("pile 6");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/Tableau_6/Sprite_Holder").get_transform().get_origin();
				get_parent().get_node("Grid/Tableau_6/Sprite_Holder").add_child(card);
				pile_cards_tableau_6.append(card); 
				my_deck.remove(c); 
				print("card");
				print(card);
				
			if( i < 8):
				print("pile 7"); 
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/Tableau_7/Sprite_Holder").get_transform().get_origin();
				get_parent().get_node("Grid/Tableau_7/Sprite_Holder").add_child(card);
				pile_cards_tableau_7.append(card); 
				my_deck.remove(c); 
				print("card");
				print(card);
	
	for x in range(3):
		c = rand_range(0, my_deck.size()) as int;
		card = my_deck[c]; 
		card.position = get_parent().get_node("Grid/Talon/Sprite_Holder").get_transform().get_origin();
		get_parent().get_node("Grid/Talon/Sprite_Holder").add_child(card);
		# three cards in talon
		pile_cards_talon.append(card);
		my_deck.remove(c);   
	print("pile talon");
	
	for n in range(my_deck.size()):
		c = rand_range(0, my_deck.size()) as int;
		card = my_deck[c]; 
		card.position = get_parent().get_node("Grid/Stock/Sprite_Holder").get_transform().get_origin();
		get_parent().get_node("Grid/Stock/Sprite_Holder").add_child(card);
		# the rest of the cards in stock
		pile_cards_stock.append(card); 
		my_deck.remove(c); 
	print("pile stock");
	

#GUI Mechanics

func pile_to_pixel(column, row):
	var new_x = x_start + offset * column;
	var new_y = y_start + -offset * row;
	return Vector2(new_x, new_y);
	

func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / offset);
	var new_y = round((pixel_y - y_start) / -offset);
	return Vector2(new_x, new_y); 
	

func is_in_grid(column, row):
	if column >=0 && column < width:
		if row >= 0 && row < height:
			return true;
	return false;
	

func is_in_grid_single(grid_position):
	if grid_position.x >=0 && grid_position.x < width:
		if grid_position.y >= 0 && grid_position.y < height:
			return true;
	return false;
	

func touch_input(): 
	if Input.is_action_just_pressed("ui_touch"):
		if is_in_grid_single(pixel_to_grid( (get_global_mouse_position().x), (get_global_mouse_position().y) )): 
			first_touch = pixel_to_grid( (get_global_mouse_position().x), (get_global_mouse_position().y) ); 
			controlling = true; 
			
	if Input.is_action_just_released("ui_touch"):
		if is_in_grid_single( pixel_to_grid( (get_global_mouse_position().x), (get_global_mouse_position().y) )) && controlling == true:
			controlling = false;
			final_touch = pixel_to_grid( (get_global_mouse_position().x), (get_global_mouse_position().y) ); 
			touch_difference(first_touch, final_touch);
			

func touch_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1;
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:   
			move_card(grid_1.x, grid_1.y, Vector2(1,0));
		elif difference.x < 0:
			move_card(grid_1.x, grid_1.y, Vector2(-1,0));
	if abs(difference.y) > abs(difference.x):
		if difference.y > 0:
			move_card(grid_1.x, grid_1.y, Vector2(0,1));
		elif difference.y < 0:
			move_card(grid_1.x, grid_1.y, Vector2(0,-1));
			

func _process(delta):
	touch_input();
	

func _on_MatchCheck_Timer_timeout():
	pass; 
	

func _on_UndoDriver_Timer_timeout(): 
	pass;
	
