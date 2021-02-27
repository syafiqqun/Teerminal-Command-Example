# Syafiq @ TutorTomato
extends Node2D

onready var output = $Output
onready var terminal = $InputTerminal

var text_input = ""

var text_split = []
var command = ""
var subject = ""

func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		run_main_loop()


func run_main_loop():
	splitting_text()
	run_command()
	text_split = []
	command = ""
	subject = ""


func run_command():
	
	if command == "cd":
		append_text("Home/ Download/ Pictures/")
	
	if text_input == "shutdown -c":
		get_tree().quit()
	
	if text_input == "help":
		append_text("This is a demo only for more functionality,add it yourself") 
	
	if text_input == "command list":
		append_text("""
////////////////////////////////////////
------ List of available command ------
cd => return current directory
shutdown -c => shutdown computer
""")

#/// text splittin function 
func splitting_text():
	
	for t in text_input:
		text_split.append(t)
	
	var second_split = false
	
	var count = 0
	while count < text_split.size():
		if text_split[count] == " ":
			count += 1
			second_split = true
			
		if second_split == false:
			command += text_split[count]
			count += 1
		if second_split == true:
			subject += text_split[count]
			count += 1


#/// util func for output tab
func append_text(val):
	if output.text == "":
		output.text = val
	else:
		output.text += "\n" + val 


#/// util func for terminal
func get_text_before_curso_pos():
	return terminal.get_line(terminal.cursor_get_line())


func prevent_curso_moving_upper_line():
	if terminal.cursor_get_line() < terminal.get_line_count():
		terminal.cursor_set_line(terminal.get_line_count() + 1)


#/// signal func connection
func _on_InputTerminal_cursor_changed():
	prevent_curso_moving_upper_line()


func _on_InputTerminal_text_changed():
	text_input = get_text_before_curso_pos()
	print(text_input)
