extends Node2D

# Grid Variables
export (int) var width;
export (int) var height;
export (int) var start_x;
export (int) var start_y;
export (int) var stop_x;
export (int) var stop_y;
export (int) var offset;
export (int) var debug_level;

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
# Grid locations
var pile_locations = [];

# Touch variables
var first_touch = Vector2(0,0);
var final_touch = Vector2(0,0);
var New_Position = Vector2(0,0);
var new_x = start_x;
var new_y = start_y;
var controlling = false;

var Grid_Container = "a"; 
var ActivePile_Container = "a"; 
var SpriteHolder_Container = "a"; 

func _ready(): 
	debug_level = 1;
	randomize();
	my_deck = make_a_deck(); 
	shuffle_the_deck();
	build_pile_grid_array();
	deal_game();

func move_check():
	pass;

func undo_move(column, row, direction): 
	if(debug_level == 1):
		print("Undo Move Function");
		print(column, row, direction);  
	var card = possible_cards[0];
	card.move(pile_to_pixel(column,row)); 
	pass;

func clear_columns():
	# auto process columns
	pass;


#GUI Mechanics


func pile_to_pixel( column, row):
	var upper_right_x = 0;
	var lower_left_x = 0;
	var upper_right_y = 0;
	var lower_left_y = 0;
	var size_x = 0;
	var size_y = 0;  
	return Vector2(new_x, new_y);

func pixel_to_pile(pixel_x, pixel_y): 
	var card = possible_cards[0].instance();
	var upper_right_x = 0;
	var lower_left_x = 0;
	var upper_right_y = 0;
	var lower_left_y = 0;
	var size_x = 0;
	var size_y = 0;
	var column =0;
	var row=0;
	var position_frame = [];
	var position_size = [];
	var position_base = [];
	var position_origin = [];
	var gridposition = [];
	var pilename = "";
	
	for n in range (pile_locations.size()):
		position_frame = pile_locations[n];
		for m in range (position_frame.size()):
			if m == 0:
				pilename = position_frame[m];
			if m == 1:
				gridposition = position_frame[m];
				column = gridposition[0];
				row = gridposition[1];
			if m == 2:
				position_origin = position_frame[m];
				upper_right_x = position_origin[0];
				upper_right_y = position_origin[1];
			if m == 3:
				position_base = position_frame[m];
				lower_left_x = position_base[0];
				lower_left_y = position_base[1];
			if m == 4:
				position_size = position_frame[m];  
				size_x = position_size[0];
				size_y = position_size[1];
				
		if pixel_x >= upper_right_x && pixel_x <= lower_left_x:
			if(debug_level == 1):
				print ("Pixel to Pile Function");
				print (pixel_x);
				
			if pixel_y <= upper_right_y  && pixel_y >= lower_left_y:
				if(debug_level == 1):
					print ("Pixel to Pile Function"); 
					print (pixel_y);
					return gridposition; 

func is_in_grid(column, row):
	if column >=0 && column < width:
		if row >= 0 && row < height:
			return true;
	return false;

func is_in_grid_single(grid_position):
	grid_position.x = grid_position[0];
	grid_position.y = grid_position[1];
	if grid_position.x >=0 && grid_position.x < width:
		if grid_position.y >= 0 && grid_position.y < height:
			return true;
	return false;

func move_card(start_x, start_y, stop_x, stop_y):
	var _pickup_pile = [];
	var _stop_pile = [];
	var card = possible_cards[0];
	if(debug_level == 1):
		print("Move Card Function",  ",", start_x, ",", start_y, ",", stop_x, ",", stop_y, ";" ); 
		
	# pickup card
	_pickup_pile = pixel_to_pile( start_x, start_y );
	_stop_pile = pixel_to_pile( stop_x, stop_y );
	
	
		
	var position = 0; 
	pass;

func touch_input(): 
	var grid_position = []; 
	if Input.is_action_just_pressed("ui_touch"):
		grid_position = pixel_to_pile( (get_global_mouse_position().x), (get_global_mouse_position().y));
		if is_in_grid_single(grid_position): 
			controlling = true; 
			start_x = get_global_mouse_position().x;
			start_y = get_global_mouse_position().y;  
			
	if Input.is_action_just_released("ui_touch"):
		grid_position = pixel_to_pile( (get_global_mouse_position().x), (get_global_mouse_position().y));
		if is_in_grid_single( grid_position ) && controlling == true:
			controlling = false; 
			stop_x = get_global_mouse_position().x;
			stop_y = get_global_mouse_position().y
			move_card(start_x, start_y, stop_x, stop_y);
		

func _process(_delta):
	touch_input();

func _on_MatchCheck_Timer_timeout():
	pass; 

func _on_UndoDriver_Timer_timeout(): 
	pass;
	
	
func build_pile_grid_array():
	var card = possible_cards[0].instance();
	var upper_right_x = 0;
	var lower_left_x = 0;
	var upper_right_y = 0;
	var lower_left_y = 0;
	var size_x = 0;
	var size_y = 0;

	var position_origin = [];
	var position_size = [];
	var position_base = [];
	var position_frame = [];
	
	var piles_grids = [];
	var piles_names = [];
	var temp_grid = [];
	
	piles_names.append("YSort/Stock/"); 
	temp_grid.append(0);
	temp_grid.append(0);
	piles_grids.append(temp_grid );
	temp_grid.clear(); 
	
	piles_names.append("YSort/Talon/");
	temp_grid.append(0);
	temp_grid.append(1);
	piles_grids.append(temp_grid ); 
	temp_grid.clear(); 
	
	piles_names.append("YSort/Foundation_1/");
	temp_grid.append(0);
	temp_grid.append(3);
	piles_grids.append(temp_grid );  
	temp_grid.clear(); 
	
	piles_names.append("YSort/Foundation_2/");
	temp_grid.append(0);
	temp_grid.append(4);
	piles_grids.append(temp_grid );  
	temp_grid.clear(); 
	 
	piles_names.append("YSort/Foundation_3/"); 
	temp_grid.append(0);
	temp_grid.append(5);
	piles_grids.append(temp_grid );  
	temp_grid.clear(); 
	 
	piles_names.append("YSort/Foundation_4/"); 
	temp_grid.append(0);
	temp_grid.append(6);
	piles_grids.append(temp_grid );   
	temp_grid.clear(); 
	
	piles_names.append("YSort/Tableau_1/"); 
	temp_grid.append(1);
	temp_grid.append(0);
	piles_grids.append(temp_grid );  
	temp_grid.clear(); 
	 
	piles_names.append("YSort/Tableau_2/"); 
	temp_grid.append(1);
	temp_grid.append(1);
	piles_grids.append(temp_grid );   
	temp_grid.clear(); 
	
	piles_names.append("YSort/Tableau_3/"); 
	temp_grid.append(1);
	temp_grid.append(2);
	piles_grids.append(temp_grid );   
	temp_grid.clear(); 
	
	piles_names.append("YSort/Tableau_4/"); 
	temp_grid.append(1);
	temp_grid.append(3);
	piles_grids.append(temp_grid );  
	temp_grid.clear(); 
	
	piles_names.append("YSort/Tableau_5/"); 
	temp_grid.append(1);
	temp_grid.append(4);
	piles_grids.append(temp_grid );   
	temp_grid.clear();
	
	piles_names.append("YSort/Tableau_6/"); 
	temp_grid.append(1);
	temp_grid.append(5);
	piles_grids.append(temp_grid );   
	temp_grid.clear();
	
	piles_names.append("YSort/Tableau_7/"); 
	temp_grid.append(1);
	temp_grid.append(6);
	piles_grids.append(temp_grid);   
	temp_grid.clear();
	 
	for n in range(piles_names.size()):
		var temp_node_name = str(piles_names[n] +  "Sprite_Holder" ); 
		#
		print (get_node(temp_node_name).get_position_in_parent());
		upper_right_x = Vector2(get_node(piles_names[n]).get_transform().get_origin()).x;
		upper_right_y = Vector2(get_node(piles_names[n]).get_transform().get_origin()).y;
		size_x = get_node(temp_node_name).texture.get_size().x;
		size_y = get_node(temp_node_name).texture.get_size().y;
		lower_left_x = upper_right_x + size_x;
		lower_left_y = upper_right_y + size_y;
		#
		print("(", upper_right_x, ",", upper_right_y, "), (", lower_left_x, ",", lower_left_y, "), (", size_x, ",", size_y, ")");
		position_origin.append(upper_right_x);
		position_origin.append(upper_right_y);
		position_base.append(lower_left_x);
		position_base.append(lower_left_y);
		position_size.append(size_x);
		position_size.append(size_y); 
		position_frame.append(piles_names[n]);
		position_frame.append(piles_grids[n]);
		position_frame.append(position_origin);
		position_frame.append(position_base);
		position_frame.append(position_size);
		pile_locations.append(position_frame);
		#
		print("Clear arrays.");
		position_origin.clear();
		position_base.clear();
		position_size.clear();
		position_frame.clear();


func make_a_deck(): 
	var array = [];
	# 7 colors
	for i in range(4):
		# 13 cards per color 
		for l in range(13): 
			var card = spawn_cards(i, l);
			array.append(card); 
			if(debug_level == 0):
				print(card);
	return array;
 
func spawn_cards(color, rank):
	if(debug_level == 0):
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


func deal_game():
	var card = possible_cards[0].instance();
	var c = 1; 
	var increment = 0;
	Grid_Container = get_parent().get_node("Grid");  
	# Example 
	ActivePile_Container = get_parent().get_node("Grid/YSort/Tableau_1"); 
	SpriteHolder_Container = get_parent().get_node("Grid/YSort/Tableau_1/Sprite_Holder"); 
	offset = 0;
	
	for i in range(8): 
		# There are seven piles to deal first.
		if(i < 1):
			#do nothing we are skipping 0 as a pile
			if(debug_level == 0):
				print("pile 0");
		else:
			# time to deal the cards
			if( i < 2):
				if(debug_level == 0):
					print("pile 1");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c];
				ActivePile_Container = get_parent().get_node("Grid/YSort/Tableau_1"); 
				SpriteHolder_Container = get_parent().get_node("Grid/YSort/Tableau_1/Sprite_Holder"); 
				card.position = SpriteHolder_Container.get_transform().get_origin();
				card.position = pile_to_position(card.position, offset, "vshift"); 
				Grid_Container.remove_child(card);  
				ActivePile_Container.add_child(card); 
				pile_cards_tableau_1.append(card);
				my_deck.remove(c);
				if(debug_level == 0):
					print("card", card); 
				
			if( i < 3):
				if(debug_level == 0):		
					print("pile 2");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c];
				ActivePile_Container = get_parent().get_node("Grid/YSort/Tableau_2"); 
				SpriteHolder_Container = get_parent().get_node("Grid/YSort/Tableau_2/Sprite_Holder");  
				card.position = SpriteHolder_Container.get_transform().get_origin();
				#move_child
				card.position = pile_to_position(card.position, offset, "vshift"); 
				Grid_Container.remove_child(card);  
				SpriteHolder_Container.add_child(card); 
				pile_cards_tableau_2.append(card);
				my_deck.remove(c);
				if(debug_level == 0):
					print("card", card); 
				
			if( i < 4):
				if(debug_level == 0):		
					print("pile 3");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c];
				ActivePile_Container = get_parent().get_node("Grid/YSort/Tableau_3"); 
				SpriteHolder_Container = get_parent().get_node("Grid/YSort/Tableau_3/Sprite_Holder");  
				card.position = get_parent().get_node("Grid/YSort/Tableau_3/Sprite_Holder").get_transform().get_origin();
				card.position = pile_to_position(card.position, offset, "vshift"); 
				Grid_Container.remove_child(card); 
				#Grid_Container.queue_free();
				get_parent().get_node("Grid/YSort/Tableau_3/Sprite_Holder").add_child(card);
				pile_cards_tableau_3.append(card);  
				my_deck.remove(c); 
				if(debug_level == 0):
					print("card", card); 
				
			if( i < 5):
				if(debug_level == 0):		
					print("pile 4");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/YSort/Tableau_4/Sprite_Holder").get_transform().get_origin();
				card.position = pile_to_position(card.position, offset, "vshift"); 
				Grid_Container.remove_child(card); 
				#Grid_Container.queue_free();
				get_parent().get_node("Grid/YSort/Tableau_4/Sprite_Holder").add_child(card);
				pile_cards_tableau_4.append(card); 
				my_deck.remove(c); 
				if(debug_level == 0):
					print("card", card); 
				
			if( i < 6):
				if(debug_level == 0):		
					print("pile 5");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/YSort/Tableau_5/Sprite_Holder").get_transform().get_origin();
				card.position = pile_to_position(card.position, offset, "vshift"); 
				Grid_Container.remove_child(card); 
				#Grid_Container.queue_free();
				get_parent().get_node("Grid/YSort/Tableau_5/Sprite_Holder").add_child(card);
				pile_cards_tableau_5.append(card);
				my_deck.remove(c); 
				if(debug_level == 0):
					print("card", card); 
				
			if( i < 7):
				if(debug_level == 0):		
					print("pile 6");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/YSort/Tableau_6/Sprite_Holder").get_transform().get_origin();
				card.position = pile_to_position(card.position, offset, "vshift"); 
				Grid_Container.remove_child(card); 
				#Grid_Container.queue_free();
				get_parent().get_node("Grid/YSort/Tableau_6/Sprite_Holder").add_child(card);
				pile_cards_tableau_6.append(card); 
				my_deck.remove(c); 
				if(debug_level == 0):
					print("card", card); 
				
			if( i < 8):
				if(debug_level == 0):		
					print("pile 7"); 
				c = rand_range(0, my_deck.size()) as int; 
				card = my_deck[c]; 
				card.position = get_parent().get_node("Grid/YSort/Tableau_7/Sprite_Holder").get_transform().get_origin(); 
				card.position = pile_to_position(card.position, offset, "vshift"); 
				Grid_Container.remove_child(card); 
				#Grid_Container.queue_free();
				get_parent().get_node("Grid/YSort/Tableau_7/Sprite_Holder").add_child(card); 
				pile_cards_tableau_7.append(card);  
				my_deck.remove(c); 
				if(debug_level == 0):
					print("card", card); 
				 
		offset = offset + increment;
	
	offset = 10;
	for _x in range(3):
		c = rand_range(0, my_deck.size()) as int;
		card = my_deck[c]; 
		card.position = get_parent().get_node("Grid/YSort/Talon/Sprite_Holder").get_transform().get_origin();
		card.position = pile_to_position(card.position, offset, "hshift");
		Grid_Container.remove_child(card); 
		#Grid_Container.queue_free();
		get_parent().get_node("Grid/YSort/Talon/Sprite_Holder").add_child(card);
		# three cards in talon
		pile_cards_talon.append(card);
		my_deck.remove(c);   
		offset = offset + increment;
		if(debug_level == 0):
			print("card", card);
	if(debug_level == 0):
		print("pile talon"); 
	
	for _n in range(my_deck.size()):
		c = rand_range(0, my_deck.size()) as int;
		card = my_deck[c]; 
		card.position = get_parent().get_node("Grid/YSort/Stock/Sprite_Holder").get_transform().get_origin();
		card.position = pile_to_position(card.position, offset, "noshift");
		Grid_Container.remove_child(card); 
		#Grid_Container.queue_free();
		get_parent().get_node("Grid/YSort/Stock/Sprite_Holder").add_child(card);
		# the rest of the cards in stock 
		pile_cards_stock.append(card); 
		my_deck.remove(c);  
		if(debug_level == 0):
			print("card", card);
	if(debug_level == 0):
		print("pile stock");
	
	
func pile_to_position( NewPosition, Shift_Me, Shift_Type):
	if Shift_Type == "vshift":
		start_x = Vector2(NewPosition).x -50;
		start_y = Vector2(NewPosition).y -70;
		new_x = start_x;
		new_y = start_y + Shift_Me;
	if Shift_Type == "hshift":
		start_x = Vector2(NewPosition).x -50;
		start_y = Vector2(NewPosition).y -70;
		new_x = start_x + Shift_Me;
		new_y = start_y;
	if Shift_Type == "noshift":
		start_x = Vector2(NewPosition).x -50;
		start_y = Vector2(NewPosition).y -70;
		new_x = start_x;
		new_y = start_y;
	return Vector2(new_x, new_y)
	
