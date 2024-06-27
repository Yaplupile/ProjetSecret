extends SpringArm3D

@onready var spring_arm = $"."

var mouse_sens := 0.001

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * mouse_sens
		rotation.x = clamp(rotation.x,deg_to_rad(-30),deg_to_rad(30))
		
		rotation.y -= event.relative.x * mouse_sens
		rotation.y = wrapf(rotation.y,deg_to_rad(0),deg_to_rad(360))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
