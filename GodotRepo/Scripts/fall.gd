extends State

@export
var idle_state: State
@export
var move_state: State
@export
var jump_state: State

@export
var jump_buffer_time : float = 0.5 #amount of time to hold jumps before hitting floor

var jump_buffer_timer: float = 0

func enter() -> void:
	parent.animations.play(animation_name)
	pass 
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('ui_accept'):
		jump_buffer_timer = jump_buffer_time
	return
	
func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	jump_buffer_timer -= delta

	var movement = Input.get_axis('ui_left', 'ui_right') * move_speed
	if movement != 0:
		parent.animations.flip_h = movement > 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if jump_buffer_timer > 0:
			return jump_state
		if movement != 0:
			return move_state
		return idle_state
	return null
