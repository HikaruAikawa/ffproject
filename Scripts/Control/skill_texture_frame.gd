extends TextureFrame

var cooldown_frame
var skill_texture
var skill_cooldown_texture
var time
var timer
var error_time
var error_timer
var error_color
var error_cooldown_color
var error_active
#This indicates whether the square should stay grey or not
var stay

func _ready():
	error_time = 0.3
	error_color = Color(1,0,0,1)
	error_cooldown_color = Color(0.5,0,0,1)
	error_active = false
	#Initializes the timer
	timer = 0
	error_timer = 0
	#Creates a new frame and sets it as its child
	cooldown_frame = Sprite.new()
	add_child(cooldown_frame)
	cooldown_frame.set_owner(self)
	cooldown_frame.set_draw_behind_parent(false)
	#Sets the textures
	set_texture(skill_texture)
	cooldown_frame.set_texture(skill_cooldown_texture)
	#Sets the cooldown frame to be invisible
	cooldown_frame.set_centered(false)
	cooldown_frame.set_region(true)
	cooldown_frame.set_region_rect(Rect2(0,0,32,0))
	
	set_process(true)

func _process(delta):
	if (timer > 0):
		timer -= delta
	if (!stay): cooldown_frame.set_region_rect(Rect2(0,0,32,lerp(0,32,(timer/time))))
	
	if (error_active):
		error_timer -= delta
		if (error_timer <= 0):
			set_modulate(Color(1,1,1,1))
			cooldown_frame.set_modulate(Color(1,1,1,1))
			error_timer = 0
			error_active = false

func set_textures(skill_texture,skill_cooldown_texture):
	self.skill_texture = skill_texture
	self.skill_cooldown_texture = skill_cooldown_texture

func set_time(time):
	self.time = time

func _activate_cooldown_frame(stay):
	if (!stay):
		timer = time
	else:
		cooldown_frame.set_region_rect(Rect2(0,0,32,32))
	self.stay = stay

func _deactivate_cooldown_frame():
	timer = 0
	cooldown_frame.set_region_rect(Rect2(0,0,32,0))

func _set_error():
	set_modulate(error_color)
	cooldown_frame.set_modulate(error_cooldown_color)
	error_timer = error_time
	error_active = true

