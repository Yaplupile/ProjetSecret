extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var spring_arm_3d = $SpringArm
@onready var mesh = $MeshInstance3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input = Vector3.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.z = Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forwards")
	input = input.rotated(Vector3.UP,spring_arm_3d.rotation.y).normalized()
	
	var direction = input
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if velocity.length() > 0.2 : 
		var look_direction = Vector2(velocity.z,velocity.x)
		mesh.rotation.y = look_direction.angle()

func _process(delta):
	spring_arm_3d.position = position
