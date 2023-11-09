class_name Enemy extends Node2D

var cur_health
var max_health
var damage
var fireSpeed = 2
var fireTimer = 0

@onready
var projectile = preload("res://Scenes/laserProjectile.tscn")
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
	fireTimer += delta
	
	if(fireTimer >= fireSpeed):
		var playerPosition = get_node("../Player").position
		var directionToFire = get_angle_to(playerPosition)
		var angle = Vector2(cos(directionToFire), sin(directionToFire))
		
		if(check_fire(angle, directionToFire)):
			fireAtPlayer(angle, directionToFire)
			fireTimer = 0
	
func move(distanceToMove: Vector2):
	self.global_translate(distanceToMove)
	
func check_fire(angle: Vector2, rotation: float) -> bool:
	# see if we have line of sight of player
	var testLaser = projectile.instantiate().duplicate()
	testLaser.rotation += rotation
	testLaser.global_position = self.global_position+angle*5
	get_node("../.").add_child(testLaser)
	var collision = testLaser.move_and_collide(angle*200, false)
	
	if(collision):
		var collider = collision.get_collider()
		if(collider) is Player:
			testLaser.queue_free()
			return true
		else: 
			testLaser.queue_free()
			return false
	else:
		testLaser.queue_free()
		return false
	
func fireAtPlayer(angle: Vector2, rotation: float):
	var laser = projectile.instantiate().duplicate()
	laser.rotation += rotation
	laser.global_position = self.global_position+angle*5
	get_node("../.").add_child(laser)
	laser.set_move(angle)
	pass
