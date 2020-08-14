extends Control
  
var my_z_index = 0;
var TITLESCREEN = [];
var PARENT = [];
var GUI = [];

# Called when the node enters the scene tree for the first time.
func _ready():     
	pass # Replace with function body

func create_timer(seconds):
	var t = Timer.new()
	t.set_wait_time(seconds)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout");
	t.queue_free();

func make_visible():   
	
	var children_array = self.get_children();
	print(children_array);
	for n in range(children_array.size()):
		if n == 0:
			TITLESCREEN = children_array[n];
			 
	if(TITLESCREEN):
		print("TitleScreen is child of TitleScreenGUI");
		print(TITLESCREEN);
	else:
		print("TitleScreen node definition failed");
		
	PARENT = self;
	if(PARENT):
		print("TitleScreenGUI is parent of TitleScreen, and child of GUI");
		print(PARENT);
	else:
		print("TitleScreenGUI node as parent of TitleScreen failed");
	
	GUI = PARENT.get_parent(); 
	if(GUI):
		print("Title Screen super parent is GUI");
		print(GUI);
	else:
		print("Title Screen GUI node definition of parent failed");  
		
	self.show();
	
	#my_z_index = self.get_z_index(); 
	#Parser Error: The method "get_z_index" isn't declared in the current class.
	my_z_index = PARENT.get_z_index();
	#Invalid call. Nonexistent function 'get_z_index' in base 'Nil'.
	
	PARENT.set_z_index(100);
	var check = self.check_visiblity(); 
	if(check == 1):
		print("TitleScreen set to show. ");
	else:
		var SELF = self;
		SELF.show();
		var LOGO = get_node("Menu/Logo")
		LOGO.show(); 
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("TitleScreen set to show. ");	
		
func make_invisible(): 
	self.hide();	
	PARENT.set_z_index(my_z_index);
	var check = self.check_visiblity(); 
	if(check == 0):
		print("TitleScreen set to hide. ");
	else:
		var SELF = self;
		SELF.hide();
		var check2 = self.check_visiblity(); 
		if(check2 == 0):
			print("TitleScreen set to hide. ");

func check_visiblity(): 
	if self.visible:
		print("TitleScreen Visible!") 
		return(1)
	else:
		print("TitleScreen Not Visible!")
		return(0) 
	pass;
	
	
