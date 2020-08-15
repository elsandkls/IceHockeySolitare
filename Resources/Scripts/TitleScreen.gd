extends Control
  
var my_z_index = 0;
var TITLESCREEN = [];
var TITLESCREEN_NODEGUI = [];
var TITLESCREEN_CONTROL = [];
var PARENT = []; 

# Called when the node enters the scene tree for the first time.
func _ready():
	TITLESCREEN = get_node("TitleScreen")
	print(TITLESCREEN)
	TITLESCREEN_NODEGUI = get_node("TitleScreen/TitleScreenNodeGUI")
	print(TITLESCREEN_NODEGUI)
	TITLESCREEN_CONTROL = get_node("TitleScreen/TitleScreenNodeGUI/TitleScreenControl")
	print(TITLESCREEN_CONTROL)
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
	
	TITLESCREEN.show();
	my_z_index = TITLESCREEN.get_z_index();

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
	
	
