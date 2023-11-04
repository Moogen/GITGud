class_name GravityWell
extends Node2D

@onready var grav_area : Area2D = $Blackhole
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func remove_gravity():
	print("testing")
	grav_area.gravity_space_override = Area2D.SPACE_OVERRIDE_DISABLED
	pass
