extends State

@export
var idle_state: State
@export
var move_state: State
@export
var jump_state: State

@export
var jump_buffer_time : float = 0.5 #amount of time to hold jumps before hitting floor
@export
var coyote_time : float = 0.2
@export
var gravity_time : float = 0.2

@export
var gravity_constant : float = 0.2

var gravity_timer : float = 0
var coyote_timer : float = 0
var jump_buffer_timer: float = 0

var previous_state : State

func enter(previous_state: State) -> void:
	super(previous_state)
	parent.animations.play(animation_name)
	coyote_timer = coyote_time
	gravity_timer = gravity_time
	self.previous_state = previous_state
	pass 
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('ui_accept'):
		if coyote_timer > 0 and previous_state != jump_state: 
			print("Coyote time activated")
			return jump_state
		else:
			jump_buffer_timer = jump_buffer_time
	
	return
	
func process_physics(delta: float) -> State:

	jump_buffer_timer -= delta
	coyote_timer -= delta
	gravity_timer -= delta
	
	if(gravity_timer > 0):
		parent.velocity.y += gravity * delta
	else:
		parent.velocity.y += gravity * gravity_constant * delta
	
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
