extends Node

@onready var debugToggle = false
@onready var uiContainer = $"." #call self

# Called when the node enters the scene tree for the first time.
func _ready():
	uiContainer.visible = debugToggle
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(_event):
	if Input.is_action_just_pressed('Debug Key'):
		debugToggle = !debugToggle
		uiContainer.visible = debugToggle
	pass
