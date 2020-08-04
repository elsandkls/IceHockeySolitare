extends Control
 
#Laod Scenes
var OPTIONS_SCENE =  load("res://Resources/Scenes/OptionsGUI.tscn").instance();
var DRAFT_SCENE =  load("res://Resources/Scenes/DraftCardsGUI.tscn").instance();
var SCORE_SCENE =  load("res://Resources/Scenes/ScoreGUI.tscn").instance();
var MENU_SCENE =  load("res://Resources/Scenes/GameMenuGUI.tscn").instance();

#Load scripts
var GRID = load("res://Resources/Scripts/Grid.gd").new()
var OPTIONS = load("res://Resources/Scripts/OptionsGUI.gd").new()
var SCORE = load("res://Resources/Scripts/ScoreGUI.gd").new()
var DRAFT = load("res://Resources/Scripts/DraftCardGUI.gd").new()
var MENU = load("res://Resources/Scripts/GameMenuGUI.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	make_invisible();
	pass # Replace with function body.

func start():	 
	check_visiblity();
	### to do list
	#load db  
	#update display 
	pass;

func make_visible():  
	self.show();	
	var check = self.check_visiblity(); 
	if(check == 1):
		print("ScoreGUI set to show. ");
	else:
		get_node("YSort/GUI/ScoreGUI").show();
		var check2 = self.check_visiblity(); 
		if(check2 == 1):
			print("ScoreGUI set to show. ");	
		
func make_invisible(): 
	self.hide();	
	var check = self.check_visiblity(); 
	if(check == 0):
		print("ScoreGUI set to hide. ");
	else:
		get_node("YSort/GUI/ScoreGUI").hide();
		var check2 = self.check_visiblity(); 
		if(check2 == 0):
			print("ScoreGUI set to hide. ");

func check_visiblity(): 
	if self.visible:
		print("ScoreGUI Visible!") 
		return(1)
	else:
		print("ScoreGUI Not Visible!")
		return(0) 
	pass;
	
func _on_ReturnToMenuButton_pressed():     
	SCORE.make_invisible();
	OPTIONS.make_invisible();
	DRAFT.make_invisible(); 
	MENU.make_visible(); 
	print("Clicked Return To Menu - GameMenu should now be visible. Score, Options, and Draft should be hidden.");
	pass # Replace with function body.
