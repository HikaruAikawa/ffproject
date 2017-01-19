extends HBoxContainer

var player
var weaponR
var weaponL
var weaponR_frames
var weaponL_frames
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
	weaponR_frames = []
	for i in range(weaponRIDs.size()):
		var tex = load("res://Textures/SkillIcons/skill_"+str(weaponRIDs[i])+".tex")
		var cl_tex = load("res://Textures/SkillIcons/skill_"+str(weaponRIDs[i])+"_cooldown.tex")
		var frame = skill_texture_frame_script.new()
		frame.set_textures(tex,cl_tex)
		var skill = weaponR.get_skill(i)
		frame.set_time(skill.cooldown)
		skill.connect("entered_cooldown",frame,"_activate_cooldown_frame")
		skill.connect("exited_cooldown",frame,"_deactivate_cooldown_frame")
		add_child(frame)
	#Adds the left hand weapon skills
	var weaponLIDs = weaponL.get_skill_ids()
	weaponL_frames = []
	for i in range(1,weaponLIDs.size()):
		var tex = load("res://Textures/SkillIcons/skill_"+str(weaponLIDs[i])+".tex")
		var cl_tex = load("res://Textures/SkillIcons/skill_"+str(weaponLIDs[i])+"_cooldown.tex")
		var frame = skill_texture_frame_script.new()
		frame.set_textures(tex,cl_tex)
		var skill = weaponL.get_skill(i)
		frame.set_time(skill.cooldown)
		skill.connect("entered_cooldown",frame,"_activate_cooldown_frame")
		skill.connect("exited_cooldown",frame,"_deactivate_cooldown_frame")
		add_child(frame)
