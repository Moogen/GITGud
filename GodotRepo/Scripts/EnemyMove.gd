extends "res://Scripts/EnemyState.gd"

@export
var idle_state: EnemyState

func enter(previous_state: EnemyState) -> void:
	super(previous_state)

func process_input(event: InputEvent) -> EnemyState:
	return null

func process_physics(delta: float, gravity_influence: Vector2) -> EnemyState:
	parent.velocity.y += gravity * delta 
	
	var movement = Input.get_axis('ui_left', 'ui_right') * move_speed
	
	if movement == 0:
		return idle_state
		
	#gravity needs to fall off over time
	if gravity_influence.x == 0:
		parent.velocity.x *= .90
		
	var grav_to_use = gravity
	
	if gravity_influence.y != 0:
		grav_to_use = gravity_influence.y
	parent.velocity.y += grav_to_use * delta
	
	parent.animations.flip_h = movement > 0
	parent.velocity.x = movement + gravity_influence.x
	get_tree().call_group("Debug Group", "update_velocity", parent.velocity)
	parent.move()
	return null
