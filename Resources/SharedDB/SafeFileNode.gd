extends Node
 
var path_SaveGames = "res://Resources/SaveGames/"
var file_SaveGameContent = path_SaveGames + "ice_hockey_dream_team_save_game.dat"
var SaveGameContent
var SaveGameContent_matrix = [] 

# Called when the node enters the scene tree for the first time.
func _ready(): 
	var delim = ","
	var newLineDelim = "\n"
		
	## open and read files 
	print(file_SaveGameContent)
	SaveGameContent = loadGame(file_SaveGameContent) 
	var SaveGameContent_Lines = SaveGameContent.split(newLineDelim, true, 0)
	var SaveGameContent_LineEntryCount = SaveGameContent_Lines.size()
	for l in range(SaveGameContent_LineEntryCount):
		SaveGameContent_matrix.append([])
		var SaveGameContent_Array = SaveGameContent_Lines[l].split(delim, true, 0)
		var SaveGameContent_EntryCount = SaveGameContent_Array.size()
		for n in range(SaveGameContent_EntryCount):
			print(String(l) + ":" + String(n) + ":" + SaveGameContent_Array[n]) # Prints n entry
			SaveGameContent_matrix[l].append(SaveGameContent_Array[n])
	saveGame(SaveGameContent, file_SaveGameContent)
	

func saveGame(content, fileName):
	saveFILE(content, fileName ) 

func loadGame(fileName):
	var content = loadFile( fileName) 
	return content

func saveFILE(content, fileName ):
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_string(content)
	file.close()
	
func loadFile( fileName):
	var file = File.new()
	file.open(fileName, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	 
