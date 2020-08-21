extends Node
 
var SaveGame_path = "res://Resources/SaveGames/";
var SaveGame_file = "ice_hockey_save_game.dat";
var SaveGame_Location = SaveGame_path + SaveGame_file;
var SaveGameContent = "username,color,cash,score";
var SaveGameContent_matrix = [] 

# Called when the node enters the scene tree for the first time.
func _ready(): 
	print("Save Game File: " + String(SaveGame_Location));
	pass;

func new():
	print("save game node is active.");
	pass; 

func parse_save_content(content):
	var delim = ",";
	var newLineDelim = "\n"; 
	#print("Parse Flie Content: " + String(content));
	var SaveGameContent_Lines = content.split(newLineDelim, true, 0);
	#print("Parse Line: " + String(SaveGameContent_Lines));
	var SaveGameContent_LineEntryCount = SaveGameContent_Lines.size();
	for l in range(SaveGameContent_LineEntryCount):
		SaveGameContent_matrix.append([]);
		SaveGameContent = SaveGameContent_Lines[l];
		var SaveGameContent_Array = SaveGameContent.split(delim, true, 0);
		var SaveGameContent_EntryCount = SaveGameContent_Array.size();
		for n in range(SaveGameContent_EntryCount):			
			#print(String(l) + ":" + String(n) + ":" + SaveGameContent_Array[n]); # Prints n entry
			SaveGameContent_matrix[l].append(SaveGameContent_Array[n]);
	return(SaveGameContent_matrix);
	
func build_save_content(user_name, user_color, cash, score, content):
	### todo
	# this function is incomplete
	# needs to build the content to put in the file.
	#print(user_name);
	#print(user_color);
	#print(cash);
	#print(score);
	#print(content);
	var delim = ",";
	var newLineDelim = "\n"; 
	#print("Parse Flie Content: " + String(content));
	var SaveGameContent_Lines = content.split(newLineDelim, true, 0);
	#print("Parse Line: " + String(SaveGameContent_Lines));
	var SaveGameContent_LineEntryCount = SaveGameContent_Lines.size();
	for l in range(SaveGameContent_LineEntryCount):
		SaveGameContent_matrix.append([]);
		var SaveGameContent_Array = SaveGameContent_Lines[l].split(delim, true, 0);
		var SaveGameContent_EntryCount = SaveGameContent_Array.size();
		for n in range(SaveGameContent_EntryCount):			
			#print(String(l) + ":" + String(n) + ":" + SaveGameContent_Array[n]); # Prints n entry
			SaveGameContent_matrix[l].append(SaveGameContent_Array[n]);
	return(SaveGameContent_matrix);	
	
func extract_cash_total(SGC_matrix):
	print("extract cash total function: ");
	var cash = 0;
	var trigger = -1;
	for a in range(SGC_matrix.size()):
		var SaveGameContent_Array = SGC_matrix[a];
		for n in range(SaveGameContent_Array.size()):
			#print("Looking for cash total :" + String(n) + ":" + SaveGameContent_Array[n]);
			if(SaveGameContent_Array[n] == "cash"):
				trigger = n;
			if (a > 0):
				if (trigger == n):
					cash = SaveGameContent_Array[n];
	return (cash);
	
func extract_score_total(SGC_matrix):
	print("extract score function: ");
	var score = 0;
	var trigger = -1;
	for a in range(SGC_matrix.size()):
		var SaveGameContent_Array = SGC_matrix[a];
		for n in range(SaveGameContent_Array.size()):
			#print("Looking for score total :" + String(n) + ":" + SaveGameContent_Array[n]);
			if(SaveGameContent_Array[n] == "score"):
				trigger = n;
			if (a > 0):
				if (trigger == n):
					score = SaveGameContent_Array[n];			
	return (score);
	
func extract_user_color_total(SGC_matrix):
	print("extract user_color function: ");
	var user_color = 0;
	var trigger = -1;
	for a in range(SGC_matrix.size()):
		var SaveGameContent_Array = SGC_matrix[a];
		for n in range(SaveGameContent_Array.size()):
			#print("Looking for user_color total :" + String(n) + ":" + SaveGameContent_Array[n]);
			if(SaveGameContent_Array[n] == "user_color"):
				trigger = n;
			if (a > 0):
				if (trigger == n):
					user_color = SaveGameContent_Array[n];			
	return (user_color);
	
func extract_user_name_total(SGC_matrix):
	print("extract user_name function: ");
	var user_name = 0;
	var trigger = -1;
	for a in range(SGC_matrix.size()):
		var SaveGameContent_Array = SGC_matrix[a];
		for n in range(SaveGameContent_Array.size()):
			#print("Looking for user_name total :" + String(n) + ":" + SaveGameContent_Array[n]);
			if(SaveGameContent_Array[n] == "user_name"):
				trigger = n;
			if (a > 0):
				if (trigger == n):
					user_name = SaveGameContent_Array[n];			
	return (user_name);

func saveGame(content):
	#print("Save Game File: " + String(file_SaveGameContent));
	#print("Save Game Content: " + String(content)); 
	var flag = saveFILE(content, SaveGame_Location );
	return(flag); 
	

func loadGame():
	print("Load Game File: " + String(SaveGame_Location));  
	var content = loadFile( SaveGame_Location ); 
	print("Load Game Content: " + String(content));  
	return content;

func saveFILE(content, fileName ):
	#print("Save File: " + String(file_SaveGameContent));
	#print("Save Content: " + String(content));  
	var file = File.new();
	file.open(fileName, File.WRITE);
	file.store_string(content);
	file.close();
	return(1);
	
func loadFile( fileName):
	#print("Load File: " + String(fileName)); 
	var file = File.new();
	file.open(fileName, File.READ);
	var content = file.get_as_text();
	file.close();
	#print("Load Content: " + String(content));  
	return content
	 
