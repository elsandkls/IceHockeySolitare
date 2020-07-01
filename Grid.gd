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
export (int) var card_width;
export (int) var card_height;

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
var last_x = 0;
var last_y = 0;
var active_x = 0;
var active_y = 0;

var Grid_Container = "a"; 
var ActivePile_Container = "a"; 
var SpriteHolder_Container = "a"; 

func _ready(): 
	StartMenuVisibility();
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
	var card = possible_cards[0].instance();
	card.move(pile_to_pixel(card)); 
	pass;

func clear_columns():
	# auto process columns
	pass;


#GUI Mechanics

func pile_to_pixel( pile ): 
	var upper_right_x = 0;
	var center_left_x = 0;
	var upper_right_y = 0;
	var center_left_y = 0;
	var size_x = 0;
	var size_y = 0; 
	#
	if(debug_level == 1):
		print ("Pile to Pixel");   
	upper_right_x = Vector2(pile.get_transform().get_origin()).x;
	upper_right_y = Vector2(pile.get_transform().get_origin()).y;
	size_x = pile.texture.get_size().x;
	size_y = pile.texture.get_size().y;
	center_left_x = upper_right_x + (size_x/2);
	center_left_y = upper_right_y + (size_y/2); 
	return Vector2(center_left_x, center_left_y);


func is_in_grid(column, row):
	if column >=0 && column < width:
		if row >= 0 && row < height:
			return true;
	return false;

func is_in_grid_single(grid_position):
	var position_x_coord = grid_position[0];
	var position_y_coord  = grid_position[1];
	if(debug_level == 0):
		print("Position X Coord: ", position_x_coord, " Max is: ", width);
		print("Position Y Coord: ", position_y_coord, " Max is: ", height);
	if position_x_coord >=0 && position_x_coord < width:
		if(debug_level == 0):
			print("Touch is inside width of grid: ", width);
		if position_y_coord >= 0 && position_y_coord < height:
			if(debug_level == 0):
				print("Touch is inside height of grid: ", height);
			return true;
	return false;

func touch_input(event): 
	print(event.as_text()); 
	if(debug_level == 0):
		print("Input Check: initial touch");  
	# InputEventScreenTouch
	#if Input.is_action_just_pressed("ui_touch")	
	pass;
	
func key_input(event): 
	print(   event.as_text()           ); 
	if(debug_level == 0):
		print("Input Check: key pressed"); 
	# InputEventScreenTouch
	#if Input.is_action_just_pressed("ui_touch")	
	pass;
	
	
func mouse_input(event): 	
	print(event.as_text());
	
	var card = possible_cards[0].instance();
	if event == null:
		event = "No Event";
	var grid_position = [];  
	var change = false;
	if (debug_level == 0):
		print(change);
	var start_on_grid = false;
	var stop_on_grid = false;
	var transverse_on_grid = false;
	if (debug_level == 0):
		print( transverse_on_grid);
	if(debug_level == 0):
		print("Input Check: initial touch"); 
# InputEventMouseButton : button_index=BUTTON_LEFT, pressed=true, position=(481, 307), button_mask=1, doubleclick=false
# InputEventMouseMotion : button_mask=BUTTON_MASK_LEFT, position=(480, 304), relative=(-1, -3), speed=(0.806163, 106.197388) 
# InputEventMouseMotion : button_mask=0, position=(866, 304), relative=(1, 0), speed=(-0.004776, 0.498934) 
	if (event.as_text()): 
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT:
				if event.pressed:
					print("Left button was clicked at ", event.position) 
					#mouse left button clicked.
					start_x = Vector2(event.position).x ;
					start_y = Vector2(event.position).y ; 
					#check to see if click is on grid.					
					grid_position.append(start_x); 
					grid_position.append(start_y); 
					start_on_grid = is_in_grid_single(grid_position);
					grid_position.clear();
					if(debug_level == 0 && start_on_grid == true):
						print("Grid Check: Yes, Start is in the grid.");
					if(debug_level == 0  && start_on_grid == false):
						print("Grid Check: No, Start is not in the grid."); 
					#mouse selected a card, recognize and pick up the top visible card or stack at that position. 
					card = pickup_card(start_x, start_y); 
					if(debug_level == 0):
						print("Mouse left button was clicked.");
						
			if event.button_mask == BUTTON_MASK_LEFT:
				print("Left Button Remains pressed down")
				#mouse left button held
				active_x = Vector2(event.position).x ;
				active_y = Vector2(event.position).y ;  
				#check to see if mouse is in grid
				grid_position.append(active_x); 
				grid_position.append(active_y); 
				transverse_on_grid = is_in_grid_single(grid_position);
				grid_position.clear();
				#mouse is moving, card should follow.
				move_card(active_x, active_y, card); 
				#track that a BUTTON_MASK_LEFT occured. position changes occuring.
				change = true;
				if(debug_level == 0):
					print("Mouse position change detected.");
					
			if event.button_mask == 0:
				# excute once, but only after a BUTTON_MASK_LEFT has occured.
				if(debug_level == 0):
					print("Left Button Released")
				#mouse clicked
				stop_x = Vector2(event.position).x ;
				stop_y = Vector2(event.position).y ;  
				#check to see if click is on the grid.				
				grid_position.append(stop_x); 
				grid_position.append(stop_y); 
				stop_on_grid = is_in_grid_single(grid_position);
				grid_position.clear();
				if(debug_level == 0  && stop_on_grid == true):
					print("Grid Check: Yes, Stop is in the grid."); 
				if(debug_level == 0  && stop_on_grid == false):
					print("Grid Check: No, Stop is not in the grid."); 
				#card should drop on pile at this location.				
				drop_card(stop_x, stop_y, card); 
				#indicate motion has stopped.
				change = false;  


func _on_MatchCheck_Timer_timeout():
	pass; 

func _on_UndoDriver_Timer_timeout(): 
	pass;
	
	
func build_pile_grid_array(): 
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
	
	var base_path = "YSort/"; 
	var new_path = "";
	  
	# new_path = str(base_path +  "Sprite_Holder" );  
	
	new_path = "Stock/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path);
	temp_grid.append(0);
	temp_grid.append(0);
	piles_grids.append(temp_grid.duplicate() );
	temp_grid.clear(); 
	
	new_path = "Talon/"; 
	new_path = new_path.insert(0,base_path);
	piles_names.append(new_path);
	temp_grid.append(0);
	temp_grid.append(1);
	piles_grids.append(temp_grid.duplicate() ); 
	temp_grid.clear(); 
	
	new_path = "Foundation_1/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(0);
	temp_grid.append(3);
	piles_grids.append(temp_grid.duplicate() );  
	temp_grid.clear(); 
	
	new_path = "Foundation_2/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(0);
	temp_grid.append(4);
	piles_grids.append(temp_grid.duplicate() );  
	temp_grid.clear(); 
	 
	new_path = "Foundation_3/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(0);
	temp_grid.append(5);
	piles_grids.append(temp_grid.duplicate() );  
	temp_grid.clear(); 
	
	new_path = "Foundation_4/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path);  
	temp_grid.append(0);
	temp_grid.append(6);
	piles_grids.append(temp_grid.duplicate() );   
	temp_grid.clear(); 
	
	new_path = "Tableau_1/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(1);
	temp_grid.append(0);
	piles_grids.append(temp_grid.duplicate());  
	temp_grid.clear(); 
	
	new_path = "Tableau_2/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path);  
	temp_grid.append(1);
	temp_grid.append(1);
	piles_grids.append(temp_grid.duplicate() );   
	temp_grid.clear(); 
	
	new_path = "Tableau_3/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(1);
	temp_grid.append(2);
	piles_grids.append(temp_grid.duplicate() );   
	temp_grid.clear(); 
	
	new_path = "Tableau_4/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(1);
	temp_grid.append(3);
	piles_grids.append(temp_grid.duplicate() );  
	temp_grid.clear(); 
	
	new_path = "Tableau_5/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(1);
	temp_grid.append(4);
	piles_grids.append(temp_grid.duplicate());   
	temp_grid.clear();
	
	new_path = "Tableau_6/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(1);
	temp_grid.append(5);
	piles_grids.append(temp_grid.duplicate() );   
	temp_grid.clear();
	
	new_path = "Tableau_7/";
	new_path = new_path.insert(0,base_path); 
	piles_names.append(new_path); 
	temp_grid.append(1);
	temp_grid.append(6);
	piles_grids.append(temp_grid.duplicate());   
	temp_grid.clear();
	 
	for n in range(piles_names.size()):
		var temp_node_name = str(piles_names[n] +  "Sprite_Holder" ); 
		#
		print(temp_node_name);
		if(debug_level == 0):
			print (get_node(temp_node_name));
			print (get_node(temp_node_name).get_position_in_parent());
			
		upper_right_x = Vector2(get_node(piles_names[n]).get_transform().get_origin()).x;
		upper_right_y = Vector2(get_node(piles_names[n]).get_transform().get_origin()).y;
		size_x = get_node(temp_node_name).texture.get_size().x;
		size_y = get_node(temp_node_name).texture.get_size().y;
		lower_left_x = upper_right_x + size_x;
		lower_left_y = upper_right_y + size_y;
		#
		if(debug_level == 0):
			print("(", upper_right_x, ",", upper_right_y, "), (", lower_left_x, ",", lower_left_y, "), (", size_x, ",", size_y, ")");
		position_origin.append(upper_right_x);
		position_origin.append(upper_right_y);
		if(debug_level == 0):
			print(position_origin);
		position_base.append(lower_left_x);
		position_base.append(lower_left_y);
		if(debug_level == 0):
			print(position_base);
		position_size.append(size_x);
		position_size.append(size_y); 
		card_width = size_x;
		card_height = size_y;
		if(debug_level == 0):
			print(position_size);
		position_frame.append(piles_names[n]);
		position_frame.append(piles_grids[n].duplicate());
		position_frame.append(position_origin.duplicate());
		position_frame.append(position_base.duplicate());
		position_frame.append(position_size.duplicate());
		if(debug_level == 0):
			print(position_frame);
		pile_locations.append(position_frame.duplicate()); 
		#
		if(debug_level == 0):
			print("Clear arrays.");
		position_origin.clear();
		position_base.clear();
		position_size.clear();
		position_frame.clear();
		
	if(debug_level == 1):
		for l in range(pile_locations.size()):
			print(pile_locations[l]);


func make_a_deck(): 
	if(debug_level == 0):
		print("function: make deck");
	var array = [];
	# 7 colors
	for i in range(4):
		# 13 cards per color 
		for l in range(13): 
			var card = spawn_card(i, l);
			array.append(card); 
			if(debug_level == 0):
				print(card);
	return array;
 
func spawn_card(color, rank):
	if(debug_level == 0):
		print("function: spawn card");
	if(debug_level == 0):
		print(color);
		print(rank);
	var rand = floor(rand_range(0,possible_cards.size()));
	var card = possible_cards[rand].instance();
	add_child(card);
	card.position = card_position(Vector2(0,0), 0,"noshift"); 
	card.setTextureForground(rank);
	card.setTextureBackground(color);
	return(card);

func shuffle_the_deck(): 
	if(debug_level == 0):
		print("function: shuffle deck");
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
				card.position = card_position(card.position, offset, "vshift"); 
				card.move(card.position);
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
				card.position = card_position(card.position, offset, "vshift"); 
				card.move(card.position); 
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
				card.position = card_position(card.position, offset, "vshift"); 
				card.move(card.position);
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
				card.position = card_position(card.position, offset, "vshift"); 
				card.move(card.position);
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
				card.position = card_position(card.position, offset, "vshift"); 
				card.move(card.position);
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
				card.position = card_position(card.position, offset, "vshift"); 
				card.move(card.position);
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
				card.position = card_position(card.position, offset, "vshift"); 
				card.move(card.position);
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
		card.position = card_position(card.position, offset, "hshift");
		card.move(card.position);
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
		card.position = card_position(card.position, offset, "noshift");
		card.move(card.position); 
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
	
func card_position( NewPosition, Shift_Me, Shift_Type):
	#control display of cards.
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
	
func pixel_to_pile(clicked_here_x, clicked_here_y):
	# pick up card clicked on 
	var return_vars = [];
	var pile = []; 
	if (debug_level == 0):
		print (pile);
	var position = 0;
	if(debug_level == 0):
		print(position);
	
	#Array place holders for obect structure
	var position_origin = [];
	var position_size = [];
	var position_base = [];
	var position_frame = [];
	var piles_grids_coordinates = [];
	if(debug_level == 0):
		print(piles_grids_coordinates);
	var Active_Container = get_parent().get_node("Grid");
	var Grid_Container = get_parent().get_node("Grid");
	
	# standard variable holders
	var piles_grids_coordinates_x = 0;
	if(debug_level == 0):
		print(piles_grids_coordinates_x);
	var piles_grids_coordinates_y = 0;
	if(debug_level == 0):
		print(piles_grids_coordinates_y);
	var piles_name_string = "String";
	if(debug_level == 0):
		print(piles_name_string);
	var position_origin_x
	var position_origin_y
	var position_base_x
	var position_base_y
	var position_size_width
	if(debug_level == 0):
		print(position_size_width);
	var position_size_height
	if(debug_level == 0):
		print(position_size_height);
	#Active Pile Variables
	var active_pile_name = "String"; 	
	if(debug_level == 0):
		print(active_pile_name);
	var pixel_x = 0;
	var pixel_y = 0;
	var pickup_pile_true = false;
	var drop_pile_true = false;
	
	if(debug_level == 1):
		print("Which Pile is it? ", clicked_here_x, ",", clicked_here_y, ";" ); 
		 
	# Identify Pile and Associated Card Array
	for p in range (pile_locations.size()):
		if(debug_level == 0):
			print("Pile Location Check: ", p , " of ", pile_locations.size() ); 
		position_frame = pile_locations[p];
		for s in range (position_frame.size()):
			if(debug_level == 0):
				print("Position Frame Check: ", s, " of ", position_frame.size() ); 
			if s == 0:
				piles_name_string = position_frame[s];
				if(debug_level == 0):
					print("Pile Name: ", piles_name_string ); 
			if s == 1:
				piles_grids_coordinates = position_frame[s];
				for c in range (piles_grids_coordinates.size()):
					if(debug_level == 0):
						print("Grid Coordinate Check: ", c, " of ", piles_grids_coordinates.size() ); 
					if c == 0:
						piles_grids_coordinates_x = piles_grids_coordinates[c];
						if(debug_level == 0):
							print("Column  X: ", piles_grids_coordinates_x ); 
					if c == 1:
						piles_grids_coordinates_y =  piles_grids_coordinates[c];
						if(debug_level == 0):
							print("Row  Y: ", piles_grids_coordinates_y ); 
			if s == 2:
				position_origin = position_frame[s]; 
				for o in range (position_origin.size()):
					if o == 0:
						position_origin_x = position_origin[o];
						if(debug_level == 0):
							print("Origin  X: ", position_origin_x ); 
					if o == 1:
						position_origin_y =  position_origin[o];
						if(debug_level == 0):
							print("Origin Y: ", position_origin_y ); 
			if s == 3:
				position_base = position_frame[s];
				for b in range (position_base.size()):
					if b == 0:
						position_base_x = position_base[b];
						if(debug_level == 0):
							print("Base X: ", position_base_x ); 
					if b == 1:
						position_base_y =  position_base[b];
						if(debug_level == 0):
							print("Base Y: ", position_base_y ); 
			if s == 4:
				position_size = position_frame[s];  
				for q in range (position_size.size()):
					if q == 0:
						position_size_width = position_size[q];
						if(debug_level == 0):
							print("Width: ", position_size_width ); 
					if q == 1:
						position_size_height =  position_size[q];
						if(debug_level == 0):
							print("Height: ", position_size_height ); 
						
	# is this the right pile?
		if(debug_level == 0):
			print ("P to p: Overlap Check: Pile: ", p, " Pixel X: ", pixel_x, " >= ", position_origin_x, " : ", pixel_x, " <= ", position_base_x, " Pixel Y: ", pixel_y, " >= ", position_origin_y, " : ", pixel_y, " <= ", position_base_y, " . ")	
		if pixel_x >= position_origin_x && pixel_x <= position_base_x:
			if(debug_level == 0):
				print ("Pixel to Pile Function X: ", pixel_x, " >= ", position_origin_x, " : ", pixel_x, " <= ", position_base_x, " . ");
				print ("Next Check: Y: ", pixel_y, " >= ", position_origin_y, " : ", pixel_y, " <= ", position_base_y, " . "); 
			if pixel_y >= position_origin_y  && pixel_y <= position_base_y:
				if(debug_level == 0):
					print ("Pixel to Pile Function Y: ", pixel_y, " >= ", position_origin_y, " : ", pixel_y, " <= ", position_base_y, " . "); 
				# yes it is the right pile.					
				# Identify which pile it is, and which array goes with it.
				if(debug_level == 1):
					print ("Confirmed pixel location matches a pile: ", piles_name_string);  
				pickup_pile_true = true;
				if(debug_level == 1):
					print ("Pickup pile: ", piles_name_string); 
				Active_Container = CheckPileName(piles_name_string); 
				return_vars.append(Active_Container);
				return_vars.append(piles_name_string);
	return return_vars;  						
						
func CheckPileName(piles_name_string):	
	var Active_Container = get_parent().get_node("Grid");
	# note to self, undoing this move is complicated
	if piles_name_string == "Grid/YSort/Stock":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);  
	if piles_name_string == "Grid/YSort/Talon":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);  
	if piles_name_string == "Grid/YSort/Foundation_1":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);   
	if piles_name_string == "Grid/YSort/Foundation_2":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);   
	if piles_name_string == "Grid/YSort/Foundation_3":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);    
	if piles_name_string == "Grid/YSort/Tableau_1":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);    
	if piles_name_string == "Grid/YSort/Tableau_2":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);   
	if piles_name_string == "Grid/YSort/Tableau_3":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);    
	if piles_name_string == "Grid/YSort/Tableau_4":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);     
	if piles_name_string == "Grid/YSort/Tableau_5":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);    
	if piles_name_string == "Grid/YSort/Tableau_6":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);     
	if piles_name_string == "Grid/YSort/Tableau_7":
		Active_Container = get_parent().get_node(piles_name_string);
		print(piles_name_string);    
					
	return Active_Container;

func GetPileArray(piles_name_string):	 
	var PileArray = [];
	# note to self, undoing this move is complicated
	if piles_name_string == "Grid/YSort/Stock": 
		PileArray = pile_cards_stock;  
	if piles_name_string == "Grid/YSort/Talon":
		PileArray = pile_cards_talon;  
	if piles_name_string == "Grid/YSort/Foundation_1":
		PileArray = pile_cards_foundation1;  
	if piles_name_string == "Grid/YSort/Foundation_2":
		PileArray = pile_cards_foundation2;  
	if piles_name_string == "Grid/YSort/Foundation_3":
		PileArray = pile_cards_foundation3;  
	if piles_name_string == "Grid/YSort/Tableau_1":
		PileArray = pile_cards_tableau_1;  
	if piles_name_string == "Grid/YSort/Tableau_2":
		PileArray = pile_cards_tableau_2;  
	if piles_name_string == "Grid/YSort/Tableau_3":
		PileArray = pile_cards_tableau_3;  
	if piles_name_string == "Grid/YSort/Tableau_4":
		PileArray = pile_cards_tableau_4;  
	if piles_name_string == "Grid/YSort/Tableau_5":
		PileArray = pile_cards_tableau_5;  
	if piles_name_string == "Grid/YSort/Tableau_6":
		PileArray = pile_cards_tableau_6;  
	if piles_name_string == "Grid/YSort/Tableau_7":
		PileArray = pile_cards_tableau_7; 
					
	return PileArray;

func pickup_card(clicked_here_x, clicked_here_y):
	var card = possible_cards[0].instance();
	var Active_Container = get_parent().get_node("Grid");
	var Grid_Container = get_parent().get_node("Grid");
	var return_vars = [];
	var piles_name_string = "";
	var PileArray = [];
	return_vars = pixel_to_pile(clicked_here_x, clicked_here_y);
	Active_Container = return_vars[0];
	piles_name_string = return_vars[1];
	PileArray = GetPileArray(piles_name_string);
	card = PileArray[PileArray.size()];
	PileArray[PileArray.size()].remove();
	Active_Container.remove_child(card); 
	# to make it easier for the card to move visual attach to grid temporarily
	Grid_Container.add_child(card);
	if(debug_level == 1):
		print("Picked up from: ", piles_name_string);  
	return card;
	
func drop_card(clicked_here_x, clicked_here_y, card):
	var Active_Container = get_parent().get_node("Grid");
	var Grid_Container = get_parent().get_node("Grid");
	var return_vars = [];
	var piles_name_string = "";
	var PileArray = [];
	return_vars = pixel_to_pile(clicked_here_x, clicked_here_y);
	Active_Container = return_vars[0];
	piles_name_string = return_vars[1];
	PileArray = GetPileArray(piles_name_string);
	Grid_Container.remove_child(card); 
	# to make it easier for the card to move visual attach to grid temporarily 
	# card.move(card.position);
	PileArray.append(card);
	Active_Container.add_child(card);
	if(debug_level == 1):
		print("Moved to: ", piles_name_string);
	pass; 
	
func move_card(active_x, active_y, card):	 
	#move the card following the mouse pointer
	card.position = Vector2(active_x, active_y)
	card.move(card.position);
	pass;

func StartMenuVisibility():	
	if(get_parent().get_node("GUI/YSort/GameMenu").visible):
		get_parent().get_node("GUI/YSort/GameMenu").hide();	
	if(get_parent().get_node("GUI/YSort/ScoreGUI").visible):
		get_parent().get_node("GUI/YSort/ScoreGUI").hide();	
	if(get_parent().get_node("GUI/YSort/OptionsGUI").visible):
		get_parent().get_node("GUI/YSort/OptionsGUI").hide();
		
func _process(delta):
	pass; 
	
func _input(event):	 
	pass;
	
	
func _unhandled_input(event: InputEvent): 
	if event is InputEvent: 
		print("InputEvent Recognized")
		if event is InputEventAction: 
			print("InputEventAction Recognized");			
			if event is InputEventMouse: 
				print("mouse input")
				#mouse_input(InputEventMouse); 
				if event is InputEventMouseButton: 
					print("InputEventMouseButton Recognized");
					if event.button_index == BUTTON_LEFT: 
						print("InputEventMouseButton Left Button Recognized");
						if event.pressed:
							print("Left button was clicked at ", event.position);
							#mouse_input(InputEventMouse); 
						else:
							print("Left button was released")
							#mouse_input(InputEventMouse); 
					if event.button_index == BUTTON_WHEEL_DOWN:
						print("Wheel down") 
			if event is InputEventScreenTouch:
				print("touch input");
				#touch_input(InputEventScreenTouch);
			if event is InputEventKey:
				print("key input");
				#key_input(InputEventKey);  
