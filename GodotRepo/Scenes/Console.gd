class_name Console extends Node

@onready var debug_toggle = true
@onready var ui_container = $"." #call self

@onready var debug_text
@onready var player_velocity_x = 0
@onready var player_velocity_y = 0
@onready var coyote_time = false
@onready var jump_buffer = false #currently unused debug variable

var player_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = debug_toggle
	add_to_group("Debug Group")
	pass # Replace with function body.

func _process(delta):
	#update the text of the object
	var coyote_time_text = ("Coyote time" if coyote_time else "")
	var jumb_buffer_text = ("Jump buffer" if jump_buffer else "")
	self.text = "Velocity X: %0.2f\nVelocity Y: %0.2f\nGravity: %0.0f\n%s \n%s" % [player_velocity_x, player_velocity_y, player_gravity, coyote_time_text, jumb_buffer_text] 
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func update_velocity(player_velocity):
	player_velocity_x = player_velocity.x
	player_velocity_y = player_velocity.y
	pass
	
func update_coyote_time(_coyote_time):
	coyote_time = _coyote_time
	pass
	
func update_gravity(_gravity):
	player_gravity = _gravity
	pass
	
func _input(_event):
	
	if Input.is_action_just_pressed('Debug Key'):
		debug_toggle = !debug_toggle
		self.visible = debug_toggle
	pass
