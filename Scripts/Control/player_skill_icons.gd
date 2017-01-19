extends HBoxContainer

var player
var weaponR
var weaponL

var skill_texture_frame_script

func _ready():
	skill_texture_frame_script = load("res://Scripts/Control/skill_texture_frame.gd")
	connect_skills()
	pass

func set_player(player):
	self.player = player
	weaponR = player.get_weapon(0)
	weaponL = player.get_weapon(1)

func connect_skills():
	var controller = player.find_node("Controller")
	
	var frame
	var label
	var scancode
	var action
	
	#Adds the right hand weapon skills
	frame = skill_texture_frame_script.new()
	frame.call_deferred("connect_to_skill",weaponR.get_skill(0),weaponR.get_skill_ids()[0])
	add_child(frame)
	label = Label.new()
	scancode
	action = "gm_p"+str(player.player_number+1)+"_attack"
	for event in InputMap.get_action_list(action):
		if (event.type == InputEvent.KEY): label.set_text(OS.get_scancode_string(event.scancode))
	add_child(label)
	
	frame = skill_texture_frame_script.new()
	frame.call_deferred("connect_to_skill",weaponR.get_skill(1),weaponR.get_skill_ids()[1])
	controller.connect("skill_0_changed",frame,"connect_to_skill")
	add_child(frame)
	label = Label.new()
	scancode
	action = "gm_p"+str(player.player_number+1)+"_skill_0"
	for event in InputMap.get_action_list(action):
		if (event.type == InputEvent.KEY): label.set_text(OS.get_scancode_string(event.scancode))
	add_child(label)
	
	#Adds the left hand weapon skills
	frame = skill_texture_frame_script.new()
	frame.call_deferred("connect_to_skill",weaponL.get_skill(1),weaponL.get_skill_ids()[1])
	controller.connect("skill_1_changed",frame,"connect_to_skill")
	add_child(frame)
	label = Label.new()
	scancode
	action = "gm_p"+str(player.player_number+1)+"_skill_1"
	for event in InputMap.get_action_list(action):
		if (event.type == InputEvent.KEY): label.set_text(OS.get_scancode_string(event.scancode))
	add_child(label)
