extends Node2D
  
var timer = 2;
var timer_switch = true;
var timer_string = "";
var my_z_index = 0;  
var TITLESCREEN_NODEGUI = self;  #1525 #TitleScreenNodeGUI #Node2d
onready var TITLESCREEN_CONTROL = self.get_node("TitleScreenControl"); #1526 Control #TitleScreenControl
 
# Called when the node enters the scene tree for the first time.
func _ready(): 
	print("Title Screen Ready")
	#print(TITLESCREEN_NODEGUI);
	TITLESCREEN_CONTROL = self.get_node("TitleScreenControl"); #1524 #TitleScreenControl
	#print(TITLESCREEN_CONTROL);
 
	pass # Replace with function body
	
func start():
	make_visible(); 
	pass # Replace with function body
	
func stop(): 
	make_invisible();
	pass # Replace with function body
 
func countdown_timer(seconds, _DISPLAYTIMER): 
	#print(_DISPLAYTIMER);  		
	print("seconds: ", seconds);	
	var reversal = seconds;
	for x in range(seconds): 
		timer_switch = true
		_DISPLAYTIMER.set_text(String(reversal)); 
		reversal = reversal - 1;
		timer_string = String(timer_string) + String(x);

func _process(delta):
	if (timer_switch == true):
		if timer > 0:
			timer -= delta
		else:
			timer_switch = false;
			#player code
			print(timer)
	pass;

func make_visible():   
	print(TITLESCREEN_NODEGUI);
	TITLESCREEN_NODEGUI.show();
	TITLESCREEN_NODEGUI.set_z_index(1000)
	my_z_index =  TITLESCREEN_NODEGUI.get_z_index()  

	var check = TITLESCREEN_NODEGUI.check_visiblity(); 
	if(check == 1):
		print("TitleScreen set to show. ");
	else: 
		TITLESCREEN_NODEGUI.show();
		var LOGO = get_node("Menu/Logo")
		LOGO.show(); 
		var check2 = TITLESCREEN_NODEGUI.check_visiblity(); 
		if(check2 == 1):
			print("TitleScreen set to show. ");	
		
func make_invisible(): 
	print(TITLESCREEN_NODEGUI);
	TITLESCREEN_NODEGUI.hide();
	TITLESCREEN_NODEGUI.set_z_index(0)
	my_z_index =  TITLESCREEN_NODEGUI.get_z_index()   
	
	var check = TITLESCREEN_NODEGUI.check_visiblity(); 
	if(check == 0):
		print("TitleScreen set to hide. ");
	else: 
		TITLESCREEN_NODEGUI.hide();
		var check2 = TITLESCREEN_NODEGUI.check_visiblity(); 
		if(check2 == 0):
			print("TitleScreen set to hide. ");

func check_visiblity(): 
	if TITLESCREEN_NODEGUI.visible:
		print("TitleScreen Visible!") 
		return(1)
	else:
		print("TitleScreen Not Visible!")
		return(0) 
	pass;
	
	
