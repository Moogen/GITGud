extends Area2D

# Strength of the gravitational pull
var gravity_strength = 10.0

func _ready():
	# Setting up the gravity here is optional, depending on your requirements
	gravity = gravity_strength

	gravity_point = true

func _on_Blackhole_body_entered(body):
	if body.has_method("apply_gravity"):
		body.apply_gravity(global_position, gravity_strength)

func _on_Blackhole_body_exited(body):
	if body.has_method("reset_gravity"):
		body.reset_gravity()
