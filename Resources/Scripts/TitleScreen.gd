extends Control

  
# Called when the node enters the scene tree for the first time.
func _ready():
	self.show();
	pass # Replace with function body

func make_visible():  
	self.show();	
	var check = self.check_visiblity(); 
	if(check == 1):
		print("TitleScreen set to show. ");
	else:
		get_node("TitleScreen").show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("TitleScreen set to show. ");	
		
func make_invisible(): 
	self.hide();	
	var check = self.check_visiblity(); 
	if(check == 0):
		print("TitleScreen set to hide. ");
	else:
		get_node("TitleScreen").hide();
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
