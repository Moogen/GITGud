extends CharacterBody2D

var projectile_direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	
	var collision = move_and_collide(projectile_direction)
	
	if(collision):
		var collider = collision.get_collider()
		if(collider) is Player:
			await get_tree().create_timer(.1).timeout
			self.position += projectile_direction
			queue_free()
		else:
			await get_tree().create_timer(.1).timeout
			self.position += projectile_direction
			queue_free()
	pass

func set_move(sped: Vector2):
	projectile_direction = sped
	
