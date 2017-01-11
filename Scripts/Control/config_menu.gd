extends VBoxContainer

var message_label
var save_button

func _ready():
	message_label = find_node("MessageLabel")
	save_button = find_node("SaveButton")
	save_button.connect("pressed",self,"_save_button_pressed")

func _save_button_pressed():
	var file = ConfigFile.new()
	
	file.set_value("General", "HRes", get_text_int("HResC"))
	file.set_value("General", "VRes", get_text_int("VResC"))
	
	var config = get_node("/root/config")
	if (config.save_config(file)): message_label.set_text("Configuration saved successfully")
	else: message_label.set_text("Error saving configuration")

func get_text(node):
	return find_node(node).find_node("LineEdit").get_text()

func get_text_int(node):
	return int(get_text(node))