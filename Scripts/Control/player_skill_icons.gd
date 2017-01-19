extends HBoxContainer

var player
var weaponR
var weaponL
var weaponR_labels
var weaponL_labels
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
	#Adds the right hand weapon skills
	var weaponRIDs = weaponR.get_skill_ids()
	weaponR_labels = []
	for i in range(weaponRIDs.size()):
		var tex = load("res://Textures/SkillIcons/skill_"+str(weaponRIDs[i])+".tex")
		var cl_tex = load("res://Textures/SkillIcons/skill_"+str(weaponRIDs[i])+"_cooldown.tex")
		var frame = skill_texture_frame_script.new()
		frame.set_textures(tex,cl_tex)
		var skill = weaponR.get_skill(i)
		frame.set_time(skill.cooldown)
		skill.connect("entered_cooldown",frame,"_activate_cooldown_frame")
		skill.connect("exited_cooldown",frame,"_deactivate_cooldown_frame")
		skill.connect("error_using",frame,"_set_error")
		add_child(frame)
		var label = Label.new()
		var scancode
		var action
		if (i == 0): action = "gm_p"+str(player.player_number+1)+"_attack"
		else: action = "gm_p"+str(player.player_number+1)+"_skill_0"
		for event in InputMap.get_action_list(action):
			if (event.type == InputEvent.KEY): label.set_text(OS.get_scancode_string(event.scancode))
		add_child(label)
		#weaponR_labels.append(label)
	#Adds the left hand weapon skills
	var weaponLIDs = weaponL.get_skill_ids()
	weaponL_labels = []
	for i in range(1,weaponLIDs.size()):
		var tex = load("res://Textures/SkillIcons/skill_"+str(weaponLIDs[i])+".tex")
		var cl_tex = load("res://Textures/SkillIcons/skill_"+str(weaponLIDs[i])+"_cooldown.tex")
		var frame = skill_texture_frame_script.new()
		frame.set_textures(tex,cl_tex)
		var skill = weaponL.get_skill(i)
		frame.set_time(skill.cooldown)
		skill.connect("entered_cooldown",frame,"_activate_cooldown_frame")
		skill.connect("exited_cooldown",frame,"_deactivate_cooldown_frame")
		skill.connect("error_using",frame,"_set_error")
		add_child(frame)
		var label = Label.new()
		var scancode
		var action = "gm_p"+str(player.player_number+1)+"_skill_1"
		for event in InputMap.get_action_list(action):
			if (event.type == InputEvent.KEY): label.set_text(OS.get_scancode_string(event.scancode))
		add_child(label)
		#weaponL_labels.append(label)
