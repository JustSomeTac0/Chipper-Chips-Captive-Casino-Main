extends CharacterBody3D

#this work?????

const ACCEL = 10
const DEACCEL = 30

var SPEED = 8.5
const SPRINT_MULT = 1.9
const JUMP_VELOCITY = 9
const MOUSE_SENSITIVITY = 0.7
var weight = 2
var regenTime = 0.1 #base Stamina Regen time

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var camera
var rotation_helper
var dir = Vector3.ZERO
var flashlight
var hitbox #THIS 
var waitfForTimer = false
var hitboxRadius: float = 0.5 #SHIT
var hitboxHeight: float = 2.0 #BETTER
var stamina: int = 100 #PULL
var maxStamina
var sprinting: bool = false
var StaminaRegenTimer

var isCrouched = false # Add states for diffrent actions
var isRunning = false


signal staminaChanged #call to update the Stamina bar


func _ready():
	camera = $rotation_helper/Camera3D
	rotation_helper = $rotation_helper
	flashlight = $rotation_helper/Camera3D/flashlight_player
	hitbox = $body
	StaminaRegenTimer = $StaminaRegenTimer
	maxStamina = $Hud/CanvasLayer/TextureProgressBar.max_value
	
	
	print(maxStamina)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# This section controls your player camera. Sensitivity can be changed.
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation
		camera_rot.x = clampf(camera_rot.x, -1.4, 1.4)
		rotation_helper.rotation = camera_rot
	
	
	
	
	
	# Release/Grab Mouse for debugging. You can change or replace this.
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
	
	
	
	
	# Flashlight toggle. Defaults to F on Keyboard.
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			if flashlight.is_visible_in_tree() and not event.echo:
				flashlight.hide()
			elif not event.echo:
				flashlight.show()




func _physics_process(delta):
	var moving = false
	# Add the gravity. Pulls value from project settings.
	if not is_on_floor():
		velocity.y -= gravity * delta * weight

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	
	
	
	
	##Crouching things I addded
	if Input.is_action_pressed("crouch"):
		SPEED = 6
		isCrouched = true
		regenTime = 0.05
		weight = 4 # fall faster 
		velocity.y -= 0.4 # ditto
		hitboxRadius = 0.3
		hitboxHeight = 1.2
		hitbox.shape.radius = float(hitboxRadius)
		hitbox.shape.height = float(hitboxHeight)
	else:
		SPEED = 8.5
		isCrouched = false
		regenTime = 0.1
		weight = 2
		hitboxRadius = 0.5
		hitboxHeight = 2.0
		hitbox.shape.radius = float(hitboxRadius)
		hitbox.shape.height = float(hitboxHeight)
	
	
	
	
	
	
	# This just controls acceleration. Don't touch it.
	var accel
	if dir.dot(velocity) > 0:
		accel = ACCEL
		moving = true
	else:
		accel = DEACCEL
		moving = false








	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with a custom keymap depending on your control scheme. These strings default to the arrow keys layout.
	var input_dir = Input.get_vector("moveSidewaysLeft", "moveSidewaysRight", "moveForward", "moveBackwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * accel * delta
	if Input.is_key_pressed(KEY_SHIFT) && stamina > 0 && isCrouched == false:
		isRunning = true
		stamina -= 1
		sprinting = true
		direction = direction * SPRINT_MULT
		staminaChanged.emit()
	else:
		isRunning = false
		if waitfForTimer == false:
			StaminaRegenTimer.start(regenTime)
			waitfForTimer = true
		
	
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_stamina_regen_timer_timeout() -> void: #Connect for the Stamina Regen Timer call StaminaRegenTimer.start(regenTime) to start it
	if not Input.is_key_pressed(KEY_SHIFT):
		if not self.stamina >= maxStamina:
			stamina += 1
			staminaChanged.emit()
			waitfForTimer = false
			
			
