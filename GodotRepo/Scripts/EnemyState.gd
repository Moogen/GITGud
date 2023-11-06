class_name EnemyState
extends Node

@export
var animation_name: String
@export
var move_speed: float = 200

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Hold a reference to the parent so that it can be controlled by the state
var parent: Enemy


func enter(prev_state: EnemyState) -> void:
	#parent.animations.play(animation_name)
	pass 
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> EnemyState:
	return null

func process_frame(delta: float) -> EnemyState:
	return null

func process_physics(delta: float, gravity_influence: Vector2) -> EnemyState:
	return null