extends Control

@onready var DisplayText = $DisplayText
@onready var ListItem = $ListItem
@onready var RestartButton = $RestartButton
@onready var QuitButton = $Quit

var items : Array = read_json_file("res://minigame/quiz/Assets/questions.json")
var item : Dictionary
var index_item : int = 0

var correct : float = 0
var wrong: int = 0
var give_candy : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_scene()

func read_json_file(filename):
	var json_as_text = FileAccess.get_file_as_string(filename)
	var json_data = JSON.parse_string(json_as_text)
	print(json_data)
	return json_data
	
func refresh_scene():
	if index_item >= items.size():
		show_result()
	else:
		show_question()
		#displayScore()

func show_question():
	ListItem.show()
	RestartButton.hide()
	QuitButton.hide()
	ListItem.clear()
	item = items[index_item]
	DisplayText.text = item.question
	var options = item.options
	for option in options:
		ListItem.add_item(option)

func show_result():
	ListItem.hide()
	RestartButton.show()
	QuitButton.show()
	var score = round(correct/items.size()*100)
	var greet
	if score >= 80:
		greet = "Congratulations! You passed and can have some candy"
		give_candy = true
	else:
		greet = "Oh no! You didn't get enough points..."
		give_candy = false
	DisplayText.text = "{greet}! Your score is {score}%".format({"greet": greet, "score": score})


func _on_item_list_item_selected(index):
	if index == item.correctOptionIndex:
		correct +=1
	index_item +=1
	refresh_scene()


func _on_button_pressed():
	correct = 0
	index_item = 0	
	refresh_scene()


func _on_quit_pressed():
	Global.change_to_main_street("quiz", give_candy)
