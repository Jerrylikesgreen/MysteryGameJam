## Autoload - DialogueManager 
extends Node

var dialogue_data = {}

var dialogue_nodes = {}
var boards = {}
var jumpers = {}
var connections = {}

var starting_element = ""
var _debug = null

func _ready() -> void:
	_load_dialogue()
	_parse_boards()
	_parse_dialogue_data()
	_parse_jumpers()
	_parse_connections()
	_parse_starting_element()
	


func _load_dialogue():
	var file = FileAccess.open("res://assets/json/dialogue_test.json", FileAccess.READ)
	
	if file == null:
		print("Failed to open JSON file")
		return
		
	var json = JSON.parse_string(file.get_as_text())
	
	if json == null:
		print("Failed to parse JSON")
		return
		
	dialogue_data = json
	print("Dialogue Loaded")


func _parse_boards():

	var board_data = dialogue_data.get("boards", {})
	
	for board_id in board_data:
		
		var board = board_data[board_id]
		
		boards[board_id] = {
			"name": board.get("name", ""),
			"elements": board.get("elements", []),
			"jumpers": board.get("jumpers", []),
			"branches": board.get("branches", []),
			"variables": board.get("variables", []),
			"connections": board.get("connections", [])
		}



func _parse_dialogue_data() -> void:
	
	var elements = dialogue_data.get("elements", {})
	
	for id in elements:
		
		var element = elements[id]
		
		dialogue_nodes[id] = {
			"id": id,
			"title": element.get("title", ""),
			"text": element.get("content", ""),
			"type": element.get("type", ""),
			"outputs": element.get("outputs", []),
			"components": element.get("components", [])
		}



func _parse_jumpers():

	var elements = dialogue_data.get("elements", {})

	for board_id in boards:
		
		var board = boards[board_id]
		
		for jumper_id in board["jumpers"]:
			
			var jumper = elements.get(jumper_id, {})
			
			jumpers[jumper_id] = {
				"id": jumper_id,
				"title": jumper.get("title", ""),
				"type": jumper.get("type", ""),
				"target": jumper.get("target", ""),
				"outputs": jumper.get("outputs", [])
			}

	print("Jumpers Parsed")


func _parse_connections():

	var connection_data = dialogue_data.get("connections", {})

	for connection_id in connection_data:
		
		var connection = connection_data[connection_id]
		
		connections[connection_id] = {
			"from": connection.get("from", ""),
			"to": connection.get("to", ""),
			"output": connection.get("output", "")
		}




func _parse_starting_element():

	starting_element = dialogue_data.get("startingElement", "")
	


func _get_next_node(current_id): # Gets the Next Dialogue Node

	for connection_id in connections:
		
		var connection = connections[connection_id]
		
		if connection["from"] == current_id:
			
			var next_id = connection["to"]
			
			return dialogue_nodes.get(next_id, null)

	return null


func start_dialogue():
	
	var node = dialogue_nodes.get(starting_element, null)
	
	return node




func print_dialogue():

	for id in dialogue_nodes:
		
		print("Node: ", id)
		print(dialogue_nodes[id]["text"])
