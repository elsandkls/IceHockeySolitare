extends Node

# script Global.gd
var current_scene = null
var currentScene = null
var PlayerName = "Mike"
 
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1) 

func goto_scene(path): 
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path): 
	current_scene.free() 
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	
func setScene(scene):
   #clean up the current scene
   currentScene.queue_free()
   #load the file passed in as the param "scene"
   var s = ResourceLoader.load(scene)
   #create an instance of our scene
   currentScene = s.instance()
   # add scene to root
   get_tree().get_root().add_child(currentScene)   
   
#simple accessor function to retrieve playerName   
func getPlayerName():
   return PlayerName
