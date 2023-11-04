class_name Enemy extends Node2D

var cur_health
var max_health
var damage
var velocity = Vector2(0,0)

@onready
var enemy_state_machine = $"EnemyStateMachine"
@onready 
var animations = $"AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_state_machine.init(self)
	pass
	
# Pass a reference of the player to the state machine so it can react accordingly
func _unhandled_input(event: InputEvent) -> void:
	enemy_state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	enemy_state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	enemy_state_machine.process_frame(delta)
	
func move():
	self.position += velocity
