extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _input(event): 
	if event.is_action_pressed("GameMenu"):
		print("GameMenu, Escape Pressed.");
		if(get_parent().get_node("GUI/YSort/GameMenu").visible):
			get_parent().get_node("GUI/YSort/GameMenu").hide();
			print("GameMenu should now be hidden.");
		else:
			get_parent().get_node("GUI/YSort/GameMenu").show();
			print("GameMenu should now be visible.");
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SettingsButton_pressed():
	print("Options/Settings button clicked.");
	get_parent().get_node("GUI/YSort/OptionsGUI").show();
	print("Settings should now be visible.");
	if(get_parent().get_node("GUI/YSort/GameMenu").visible):
		get_parent().get_node("GUI/YSort/GameMenu").hide();	
	if(get_parent().get_node("GUI/YSort/ScoreGUI").visible):
		get_parent().get_node("GUI/YSort/ScoreGUI").hide();	
	pass # Replace with function body.


func _on_ExitGameButton_pressed():
	get_tree().quit(-1)
	pass # Replace with function body.


func _on_ScoresButton_pressed():
	print("High Score button clicked."); 
	get_parent().get_node("GUI/YSort/ScoreGUI").show();
	print("High Scores should now be visible.");
	if(get_parent().get_node("GUI/YSort/GameMenu").visible):
		get_parent().get_node("GUI/YSort/GameMenu").hide();	
	if(get_parent().get_node("GUI/YSort/OptionsGUI").visible):
		get_parent().get_node("GUI/YSort/OptionsGUI").hide();
	pass # Replace with function body.


func _on_ReturnToMenuButton_pressed():   
	get_parent().get_node("GUI/YSort/GameMenu").show();
	print("GameMenu should now be visible.");
	if(get_parent().get_node("GUI/YSort/ScoreGUI").visible):
		get_parent().get_node("GUI/YSort/ScoreGUI").hide();	
	if(get_parent().get_node("GUI/YSort/OptionsGUI").visible):
		get_parent().get_node("GUI/YSort/OptionsGUI").hide();
	pass # Replace with function body.


func _on_PlayButton_pressed():	
	if(get_parent().get_node("GUI/YSort/GameMenu").visible):
		get_parent().get_node("GUI/YSort/GameMenu").hide();	
	if(get_parent().get_node("GUI/YSort/ScoreGUI").visible):
		get_parent().get_node("GUI/YSort/ScoreGUI").hide();	
	if(get_parent().get_node("GUI/YSort/OptionsGUI").visible):
		get_parent().get_node("GUI/YSort/OptionsGUI").hide();
	pass # Replace with function body.
