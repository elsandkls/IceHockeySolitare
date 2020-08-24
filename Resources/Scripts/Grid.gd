extends Node2D

# This is Grid.gd   

# Grid Variables
export (int) var width;
export (int) var height;
export (int) var start_x;
export (int) var start_y; 
export (int) var offset;
export (int) var debug_level;
export (int) var card_width;
export (int) var card_height;

onready var STOCK = get_node("YSort/Stock");
onready var TALON = get_node("YSort/Talon");
onready var TABLEAU1 = get_node("YSort/Tableau_1");
onready var TABLEAU2 = get_node("YSort/Tableau_2");
onready var TABLEAU3 = get_node("YSort/Tableau_3");
onready var TABLEAU4 = get_node("YSort/Tableau_4");
onready var TABLEAU5 = get_node("YSort/Tableau_5");
onready var TABLEAU6 = get_node("YSort/Tableau_6");
onready var TABLEAU7 = get_node("YSort/Tableau_7");
onready var FOUNDATION1 = get_node("YSort/Foundation_1");
onready var FOUNDATION2 = get_node("YSort/Foundation_2");
onready var FOUNDATION3 = get_node("YSort/Foundation_3");
onready var FOUNDATION4 = get_node("YSort/Foundation_4");

# variables for cards  
var possible_cards = [
	preload("res://Resources/Cards/Card.tscn")
	#preload("res://Resources/Cards/Card.gd")
];

var card = possible_cards[0]; 

#Two dimensional array to hold coordinates x,y plane
#var all_pieces = [];
 
#Two dimensional array to hold coordinates x,z plane 
var my_deck = [];
var pile_cards_stock = [];
var pile_cards_talon = [];
var pile_cards_foundation1 = [];
var pile_cards_foundation2 = [];
var pile_cards_foundation3 = [];
var pile_cards_foundation4 = [];
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
var new_x = start_x;
var new_y = start_y;
var controlling = false;  
var grid_full_path = self.get_path();
var ysort_full_path = "YSort/";
var sprite_full_path = "/Sprite_Holder";
var Grid_Container = "Grid"; 
var ActivePile_Container = "Active" 
var SpriteHolder_Container = "Card";   

func _ready(): 	
	if(debug_level == 0):
		print("Game Grid Ready")	
		print("Finished Game Grid Load.")
	controlling = false;
	pass;

func start(): 
	make_visible();
	debug_level = 2;
	randomize();
	build_deck();

func new():
	pass # Replace with function body.
 
func build_deck(): 
	if(debug_level == 0):
		print("Starting Build Deck in Grid.")
	my_deck = make_a_deck(); 
	#print(my_deck)
	shuffle_the_deck();
	build_pile_grid_array();
	deal_game();
	
	if(debug_level == 0):
		print("Finished Build Deck in Grid.")

func move_check():
	pass;

func undo_move(column, row, direction): 
	if(debug_level == 0):
		print("Undo Move Function"); 
		print(column, row, direction);  
		 
	card.move(SpriteHolder_Container); 
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
	if(debug_level == 0):
		print ("Pile to Pixel");   
		
	upper_right_x = Vector2(pile.get_transform().get_origin()).x;
	upper_right_y = Vector2(pile.get_transform().get_origin()).y;
	size_x = pile.texture.get_size().x;
	size_y = pile.texture.get_size().y;
	center_left_x = upper_right_x + (size_x/2);
	center_left_y = upper_right_y + (size_y/2); 
	return Vector2(center_left_x, center_left_y);


func is_in_grid(column, row):
	if column >=0 and column < width:
		if row >= 0 and row < height:
			return true;
		else:
			return false;
	else:
		return false;

func is_in_grid_single(grid_position):
	var position_x_coord = grid_position[0];
	var position_y_coord  = grid_position[1];
	if(debug_level == 0):
		print("Position X Coord: ", position_x_coord, " Max is: ", width);
		print("Position Y Coord: ", position_y_coord, " Max is: ", height);
	if position_x_coord >= 0 and position_x_coord < width:
		if(debug_level == 0):
			print("Is inside width of grid: ", width);
		if position_y_coord >= 0 and position_y_coord < height:
			if(debug_level == 0):
				print("Is inside height of grid: ", height);
			return true;
		else:
			return false;
	else:
		return false;
	pass;

func touch_input():  
	if(debug_level == 0):
		print("Input Check: initial touch");  
	
	# InputEventScreenTouch
	#if Input.is_action_just_pressed("ui_touch")	
	pass;
	
func key_input():  
	if(debug_level == 0):
		print("Input Check: key pressed"); 
	# InputEventScreenTouch
	#if Input.is_action_just_pressed("ui_touch")	
	pass;
	
	
func mouse_input(): 		
	var _on_grid = false;   
	var _mouse_moving = 0; 
	var grid_position = [];
	var position_x = get_global_mouse_position().x; 
	var position_y = get_global_mouse_position().y;   
	grid_position.append(position_x); 
	grid_position.append(position_y); 
	_on_grid = is_in_grid_single(grid_position);
	grid_position.clear();
	if _on_grid == true:
		var status = check_click_status();
		#print(status);
		if status == "pickup":
			card = pickup_card(position_x,position_y);
			_mouse_moving = 0;
		if status == "moving":
			#print("mouse moving");  
			_mouse_moving = 1;
		if status == "drop":
			drop_card(position_x,position_y);
			_mouse_moving = 0;
	else:
		_mouse_moving = 0;
	pass;

func check_click_status():
	### todo
	# return if it's a new click, moving, or drop
	return("moving");
	
func _on_MatchCheck_Timer_timeout():
	pass; 

func _on_UndoDriver_Timer_timeout(): 
	pass;
	 

func build_temp_path(base_path):
	var new_path = build_path(base_path, "nogrid_node"); 
	return(new_path)
	
func build_pile_on_grid(grid_var_x,grid_var_y):
	var temp_grid = []; 
	temp_grid.append(grid_var_x);
	temp_grid.append(grid_var_y);
	return temp_grid.duplicate(); 
	
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
	var piles_objects = [];
	var piles_IDs = []; 
 
	if(debug_level == 0):
		print(STOCK); 
	
	# builds the index or key used through out the program
	piles_names.append( "Stock" );
	piles_grids.append( build_pile_on_grid(0,0) );  
	piles_objects.append( STOCK );
	piles_IDs.append(pile_cards_stock); 
	STOCK.make_visible();
	
	piles_names.append( "Talon" );
	piles_grids.append( build_pile_on_grid(0,1) );  
	piles_objects.append( TALON );	
	piles_IDs.append(pile_cards_talon ); 
	TALON.make_visible();
	
	piles_names.append( "Foundation_1" );
	piles_grids.append( build_pile_on_grid(0,3) );  
	piles_objects.append( FOUNDATION1 );
	piles_IDs.append( pile_cards_foundation1 );
	FOUNDATION1.make_visible();
	
	piles_names.append( "Foundation_2" );
	piles_grids.append( build_pile_on_grid(0,4) );  
	piles_objects.append( FOUNDATION2 );
	piles_IDs.append(pile_cards_foundation2 );
	FOUNDATION2.make_visible();
	 
	piles_names.append( "Foundation_3" );
	piles_grids.append( build_pile_on_grid(0,5) );   
	piles_objects.append( FOUNDATION3 ); 
	piles_IDs.append(pile_cards_foundation3 );
	FOUNDATION3.make_visible();
	
	piles_names.append(  "Foundation_4" );
	piles_grids.append( build_pile_on_grid(0,6) );   
	piles_objects.append( FOUNDATION4 ); 
	piles_IDs.append(pile_cards_foundation4 );
	FOUNDATION4.make_visible();

	piles_names.append(  "Tableau_1" );
	piles_grids.append( build_pile_on_grid(1,0) );  
	piles_objects.append( TABLEAU1 );  
	piles_IDs.append(pile_cards_tableau_1 );
	TABLEAU1.make_visible();
	 
	piles_names.append( "Tableau_2" );
	piles_grids.append( build_pile_on_grid(1,1) );  
	piles_objects.append( TABLEAU2 );  
	piles_IDs.append(pile_cards_tableau_2 );
	TABLEAU2.make_visible();
	 
	piles_names.append( "Tableau_3" );
	piles_grids.append( build_pile_on_grid(1,2) );  
	piles_objects.append( TABLEAU3 );  
	piles_IDs.append(pile_cards_tableau_3 );
	TABLEAU3.make_visible();
	  
	piles_names.append( "Tableau_4" );
	piles_grids.append( build_pile_on_grid(1,3) );   
	piles_objects.append( TABLEAU4 );
	piles_IDs.append(pile_cards_tableau_4 );
	TABLEAU4.make_visible();
	   
	piles_names.append(  "Tableau_5" );
	piles_grids.append( build_pile_on_grid(1,4) );  
	piles_objects.append( TABLEAU5 );
	piles_IDs.append(pile_cards_tableau_5 );
	TABLEAU5.make_visible();
	
	piles_names.append( "Tableau_6" );
	piles_grids.append( build_pile_on_grid(1,5) );   
	piles_objects.append( TABLEAU6  );
	piles_IDs.append(pile_cards_tableau_6 );
	TABLEAU6.make_visible();
	 
	piles_names.append(  "Tableau_7" );
	piles_grids.append( build_pile_on_grid(1,6) );  
	piles_objects.append( TABLEAU7 ); 
	piles_IDs.append(pile_cards_tableau_7);
	TABLEAU7.make_visible();

	if(debug_level == 0):	 
		print("Before we begin, this is what we have. ");
		print("piles_names ", piles_names);
		print("piles_grids ", piles_grids);
		print("piles_objects ", piles_objects);
		print("piles_IDs ", piles_IDs);

	for n in range(piles_names.size()): 
		if(debug_level == 0):
			print("Inside the for loop: ");
			print("loop: ", n); 
			print("piles_names: ", piles_names[n]);
			print("piles_grids: ", piles_grids[n]);
			print("piles_objects: ", piles_objects[n]);
			print("piles_IDs: ", piles_IDs[n]);
			
		var TEMPOBJECT = piles_objects[n];
		if(debug_level == 0):
			print ("TEMPOBJECT: ", TEMPOBJECT);
		
		# error here on get_upper_right_x on TEMPOBJECT
		upper_right_x = TEMPOBJECT.get_uppper_right_x();
		upper_right_y = TEMPOBJECT.get_uppper_right_y();
		if(debug_level == 0):
			print("upper_right_x: ", upper_right_x); 
			print("upper_right_y: ", upper_right_y);
			
		# error here on get_size_x on TEMPOBJECT
		size_x = TEMPOBJECT.get_size_x();
		size_y = TEMPOBJECT.get_size_y();
		if(debug_level == 0):
			print("size_x: ", size_x); 
			print("size_y: ", size_y); 
			print("debug_level: ", debug_level);
			
		lower_left_x = upper_right_x + size_x;
		lower_left_y = upper_right_y + size_y;
		if(debug_level == 0):
			print("lower_left_x: ", lower_left_x); 
			print("lower_left_y: ", lower_left_y);
		
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
		
	if(debug_level == 0):
		for l in range(pile_locations.size()):
			print("pile location built");
			print(pile_locations[l]);


func make_a_deck(): 
	var temp_array=[];
	if(debug_level == 0):
		print("function: make deck"); 
	# 7 colors
	for i in range(4):
		# 13 cards per color 
		for l in range(13):   
			card = spawn_card(i, l);
			if(debug_level == 0):
				print(i, " : ", l, " : Spawned : ",card)
			temp_array.append(card);  
	return temp_array;
 
func spawn_card(color, rank):
	if(debug_level == 0):
		print("function: spawn card"); 
		print(color);
		print(rank);
	var rand = floor(rand_range(0,possible_cards.size()));
	#print(rand);
	#var CARD = possible_cards[rand]; 
	card = possible_cards[rand].instance();
	#print(card);
	add_child(card);
	var Vect2Position = card_position(Vector2(0,0), 0,"noshift"); 
	card.setNodePosition(Vect2Position); 	
	card.setTextureForground_CardSpec(rank);
	card.setTextureBackground_FaceUp(color);
	card.setTextureBackground_FaceDown(color);
	return(card);

func shuffle_the_deck(): 
	if(debug_level == 0):
		print("function: shuffle deck");
	#print(my_deck)
	my_deck.shuffle();
	#print(my_deck)
	pass;

func build_path(base_path, path_type): 
	var new_path = ""; 
	grid_full_path = self.get_path();
	
	if(path_type == "nogrid_sprite"): 
		new_path = new_path.insert(0,sprite_full_path); 
		new_path = new_path.insert(0,base_path); 
		new_path = new_path.insert(0,ysort_full_path);   
		
	if(path_type == "nogrid_node"):
		new_path = new_path.insert(0,base_path); 
		new_path = new_path.insert(0,ysort_full_path);  
		
	if(path_type == "grid_sprite"): 
		new_path = new_path.insert(0,sprite_full_path); 
		new_path = new_path.insert(0,base_path); 
		new_path = new_path.insert(0,ysort_full_path);  
		new_path = new_path.insert(0,grid_full_path);    
		
	if(path_type == "grid_node"):
		new_path = new_path.insert(0,base_path); 
		new_path = new_path.insert(0,ysort_full_path);  
		new_path = new_path.insert(0,grid_full_path);    
		
	if(path_type == "grid"):
		new_path = new_path.insert(0,grid_full_path);   
		  
	if(debug_level == 0):
		print(new_path);
		print(get_node(new_path));
	return new_path

func deal_game(): 
	var c = 1; 
	var increment = 0;
	var new_path = "";
	var base_path = "Stock";  
	# Example
	new_path = build_path(base_path, "grid");  
	Grid_Container = get_parent().get_node(new_path);   
	if(debug_level == 0):
		print("Grid_Container");
		print(Grid_Container);
	
	new_path = build_path(base_path, "nogrid_node"); 
	ActivePile_Container = get_node(new_path);  
	if(debug_level == 0):
		print("ActivePile_Container");
		print(ActivePile_Container);
	
	new_path = build_path(base_path, "nogrid_sprite");
	SpriteHolder_Container = get_node(new_path); 
	if(debug_level == 0):
		print("SpriteHolder_Container");
		print(SpriteHolder_Container);
	offset = 10;
	
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
					print(my_deck);
				c = rand_range(0, my_deck.size()) as int;
				#print("c");
				card = my_deck[c]; 
				#print(card);
				base_path = "Tableau_1"; 
				tableau_work_horse(base_path, i, pile_cards_tableau_1, c);
				#print("pile 1");
			if( i < 3):
				if(debug_level == 0):		
					print("pile 2");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c];
				base_path = "Tableau_2"; 
				tableau_work_horse(base_path, i, pile_cards_tableau_2, c);
				
			if( i < 4):
				if(debug_level == 0):		
					print("pile 3");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c];
				base_path = "Tableau_3"; 
				tableau_work_horse(base_path, i, pile_cards_tableau_3, c);
				
			if( i < 5):
				if(debug_level == 0):		
					print("pile 4");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				base_path = "Tableau_4"; 
				tableau_work_horse(base_path, i, pile_cards_tableau_4, c);
				
			if( i < 6):
				if(debug_level == 0):		
					print("pile 5");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				base_path = "Tableau_5"; 
				tableau_work_horse(base_path, i, pile_cards_tableau_5, c);
				
			if( i < 7):
				if(debug_level == 0):		
					print("pile 6");
				c = rand_range(0, my_deck.size()) as int;
				card = my_deck[c]; 
				base_path = "Tableau_6"; 
				tableau_work_horse(base_path, i, pile_cards_tableau_6, c);
				
			if( i < 8):
				if(debug_level == 0):		
					print("pile 7"); 
				c = rand_range(0, my_deck.size()) as int; 
				card = my_deck[c]; 
				base_path = "Tableau_7"; 
				tableau_work_horse(base_path, i, pile_cards_tableau_7, c);
				 
		offset = offset + increment;
	
	offset = 10;
	for _x in range(3):
		c = rand_range(0, my_deck.size()) as int;
		card = my_deck[c]; 
		base_path = "Talon";
		talon_work_horse(base_path, pile_cards_stock, c);
		offset = offset + increment;
	
	for _n in range(my_deck.size()):
		c = rand_range(0, my_deck.size()) as int;
		card = my_deck[c]; 
		base_path = "Stock"; 
		stock_work_horse(base_path, pile_cards_stock, c);


func tableau_work_horse(base_path, i, pile_cards_pile, c):
	### Do This withing the loop but after the if statements define the pile
	ActivePile_Container = get_Container(base_path,"nogrid_node"); 
	#print(ActivePile_Container) 
	SpriteHolder_Container = get_Container(base_path,"nogrid_sprite"); 	
	#print(SpriteHolder_Container) 
	card_handler(i, "vshift")
	move_card_to_new_container(pile_cards_pile, c);

func stock_work_horse(base_path, pile_cards_pile, c):
	### Do This withing the loop but after the if statements define the pile
	ActivePile_Container = get_Container(base_path,"nogrid_node"); 
	SpriteHolder_Container = get_Container(base_path,"nogrid_sprite"); 	
	card_handler(1, "noshift");
	move_card_to_new_container(pile_cards_pile, c);
		
func talon_work_horse(base_path, pile_cards_pile, c):
	### Do This withing the loop but after the if statements define the pile
	ActivePile_Container = get_Container(base_path,"nogrid_node"); 
	SpriteHolder_Container = get_Container(base_path,"nogrid_sprite"); 	
	card_handler(1, "hshift")
	move_card_to_new_container(pile_cards_pile, c);

func card_handler(i, shifter):
	print(SpriteHolder_Container);
	print(card);
	card.position = SpriteHolder_Container.get_transform().get_origin();
	card.position = card_position(card.position, offset*i, shifter); 
	card.move(SpriteHolder_Container);  
	pass;
	
					
func get_Container(base_path, node_def):
	var new_path = build_path(base_path, node_def); 
	var myContainer = get_node(new_path);   
	return(myContainer);

func move_card_to_new_container(pile_cards_pile, c):
	Grid_Container = card.get_parent()
	Grid_Container.remove_child(card);     
	ActivePile_Container.add_child(card);   
	pile_cards_pile.append(card);
	print(card);
	my_deck.remove(c); 
	
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
	#var return_vars = [];
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
	var _Active_Container = get_parent().get_node(grid_full_path);
	#var Grid_Container = get_parent().get_node(grid_full_path);
	
	# standard variable holders
	var piles_grids_coordinates_x = 0;
	var piles_grids_coordinates_y = 0;
	var piles_name_string = "String"; 
	if(debug_level == 0):
		print(piles_grids_coordinates_x);  
		print(piles_grids_coordinates_y);  
		print(piles_name_string);
	var position_origin_x
	var position_origin_y
	var position_base_x
	var position_base_y
	var position_size_width
	var position_size_height
	if(debug_level == 0):
		print(position_size_width);  
		print(position_size_height);
	#Active Pile Variables
	var base_path = "Stock";
	var new_path = build_path(base_path, "grid"); 
	var active_pile_name = new_path; 	
	var pickup_pile_true = false;
	if(debug_level == 0):
		print(active_pile_name);
		print (pickup_pile_true);
	var pixel_x = 0;
	var pixel_y = 0; 
	#var drop_pile_true = false;
	
	if(debug_level == 0):
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
		pixel_x = clicked_here_x;
		pixel_y = clicked_here_y;
		if(debug_level == 0):
			print ("P to p: Overlap Check: Pile: ", p, " Pixel X: ", pixel_x, " >= ", position_origin_x, " : ", pixel_x, " <= ", position_base_x, " Pixel Y: ", pixel_y, " >= ", position_origin_y, " : ", pixel_y, " <= ", position_base_y, " . ")	

		if pixel_x >= position_origin_x && pixel_x <= position_base_x:
			if(debug_level == 0):
				print ("Pixel to Pile Function X: ", pixel_x, " >= ", position_origin_x, " : ", pixel_x, " <= ", position_base_x, " . ");
				print ("Next Check: Y: ", pixel_y, " >= ", position_origin_y, " : ", pixel_y, " <= ", position_base_y, " . "); 

			if pixel_y >= position_origin_y  && pixel_y <= position_base_y:

				if(debug_level == 0):
					print ("Pixel to Pile Function Y: ", pixel_y, " >= ", position_origin_y, " : ", pixel_y, " <= ", position_base_y, " . "); 
					print ("Confirmed pixel location matches a pile: ", piles_name_string);  
					print ("Pickup pile: ", piles_name_string); 
				pickup_pile_true = true; 
				return piles_name_string; 
			else: 
				if(debug_level == 0):
					print ("Nope: failed test y: ", piles_name_string); 
		else: 
			if(debug_level == 0):
				print ("Nope: failed test of x: ", piles_name_string); 
	 
	return "";
	
	
func CheckPileName(piles_name_string):	
	var Active_Container = get_parent().get_node("Grid");
	# note to self, undoing this move is complicated
	if piles_name_string == "Stock":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);  
			
	if piles_name_string == "Talon":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);  
			
	if piles_name_string == "Foundation_1":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);   
			
	if piles_name_string == "Foundation_2":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);   
			
	if piles_name_string == "Foundation_3":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);    
			
	if piles_name_string == "Tableau_1":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);    
			
	if piles_name_string == "Tableau_2":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);   
			
	if piles_name_string == "Tableau_3":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);    
			
	if piles_name_string == "Tableau_4":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);     
			
	if piles_name_string == "Tableau_5":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);    
			
	if piles_name_string == "Tableau_6":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);     
			
	if piles_name_string == "Tableau_7":
		Active_Container = get_parent().get_node(piles_name_string);
		if(debug_level == 0):
			print(piles_name_string);    
					
	return Active_Container;

func GetPileArray(piles_name_string):	 
	var PileArray = [];
	# note to self, undoing this move is complicated
	if piles_name_string == "Stock": 
		PileArray = pile_cards_stock;  
	if piles_name_string == "Talon":
		PileArray = pile_cards_talon;  
	if piles_name_string == "Foundation_1":
		PileArray = pile_cards_foundation1;  
	if piles_name_string == "Foundation_2":
		PileArray = pile_cards_foundation2;  
	if piles_name_string == "Foundation_3":
		PileArray = pile_cards_foundation3;  
	if piles_name_string == "Tableau_1":
		PileArray = pile_cards_tableau_1;  
	if piles_name_string == "Tableau_2":
		PileArray = pile_cards_tableau_2;  
	if piles_name_string == "Tableau_3":
		PileArray = pile_cards_tableau_3;  
	if piles_name_string == "Tableau_4":
		PileArray = pile_cards_tableau_4;  
	if piles_name_string == "Tableau_5":
		PileArray = pile_cards_tableau_5;  
	if piles_name_string == "Tableau_6":
		PileArray = pile_cards_tableau_6;  
	if piles_name_string == "Tableau_7":
		PileArray = pile_cards_tableau_7; 
					
	return PileArray;

func pickup_card(clicked_here_x, clicked_here_y): 
	var Active_Container = get_parent().get_node(grid_full_path);
	#var Grid_Container = get_parent().get_node(grid_full_path); 
	var piles_name_string = "";
	var PileArray = [] ;
	var set_number = 0;
	
	piles_name_string = pixel_to_pile(clicked_here_x, clicked_here_y);
	
	if  piles_name_string != "":
		var full_path_piles_name_string = grid_full_path + piles_name_string;
		Active_Container = get_parent().get_node(full_path_piles_name_string);
		if(debug_level == 0):
			print("Active_Container: ", Active_Container);  
			print("piles_name_string: ", piles_name_string);  
			
		PileArray = GetPileArray(piles_name_string);
		set_number = PileArray.size();
		if(debug_level == 0):
			print("PileArray: ", PileArray);    
			print("set_number: ", set_number);  
			
		if(set_number > 0):
			card = PileArray[set_number].duplicate();
			if(debug_level == 0):
				print("card: ", card);  
				print("PileArray: ", PileArray[set_number]); 
				
			PileArray[set_number].remove(); 
			Active_Container.remove_child(card);   
			Grid_Container.add_child(card); 
			return card;
		else:
			if(debug_level == 0):
				print("Pile is empty.")	   
	else:
		pass;
	pass;

func drop_card(clicked_here_x, clicked_here_y):
	var Active_Container = get_parent().get_node("Grid");
	#var Grid_Container = get_parent().get_node("Grid");
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
	if(debug_level == 0):
		print("Moved to: ", piles_name_string);
	pass; 
	
func move_card(position_x, position_y):	 
	#move the card following the mouse pointer
	card.position = Vector2(position_x, position_y)
	card.move(SpriteHolder_Container);
	pass;
		 
func make_visible():
	if(debug_level == 0):
		print("Game Grid: Make Visible");
	self.show();
	if(debug_level == 0):
		print("New Game Grid: should now be visible.");
	pass # Replace with function body.
	
func make_invisible():
	if(debug_level == 0):
		print("Game Grid: Make inVisible");
	self.hide();
	if(debug_level == 0):
		print("New Game Grid: should now be invisible.");
	pass # Replace with function body.

func check_visiblity():
	if self.visible:
		if(debug_level == 0):
			print("Game Grid: is viible. ");
		return(1);
	else:
		if(debug_level == 0):
			print("Game Grid: is not visible. ");
		return(0);
	pass;
