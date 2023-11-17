class_name projectile extends CharacterBody2D 

@onready var player = get_node("/root/Main/Player")

var projectile_direction = Vector2(0,0)
var gravity_influence = Vector2(0,0)
signal damage_dealt

# Called when the node enters the scene tree for the first time.
func _ready():
	if(player != null):
		damage_dealt.connect(player.take_damage)
	else:
		print("player not found")	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	
	var direction_to_move = projectile_direction + gravity_influence * delta
	
	if(gravity_influence != Vector2(0,0)):
		# update projectile_direction to be the most recent direction, but with simulated inertia
		projectile_direction = direction_to_move.normalized()*projectile_direction.length()*.25+projectile_direction*.755
		pass
	
	#update rotation to match direction
	rotation = projectile_direction.angle()
	
	var collision = move_and_collide(direction_to_move)
	
	if(collision):
		var collider = collision.get_collider()
		if(collider) is Player:
			damage_dealt.emit()
			damage_dealt.disconnect(player.take_damage)
			await get_tree().create_timer(.1).timeout
			queue_free()
		else:
			await get_tree().create_timer(.1).timeout
			queue_free()
	pass

func set_move(sped: Vector2):
	projectile_direction = sped

func set_influence(gravity: float, grav_center: Vector2, grav_center_radius : float) -> void:
	var projectile_center = self.global_position
	var distance = grav_center - projectile_center
	var radius = grav_center.distance_to(projectile_center)
	var norm_distance = distance.normalized()
	
	if(radius > grav_center_radius*1.25):
		gravity_influence = norm_distance * gravity * 1/(radius-grav_center_radius)
	else:
		gravity_influence = Vector2(0,0)
	get_tree().call_group("Debug Group", "update_gravity_influence", norm_distance * gravity * 1/(radius-grav_center_radius))
	
