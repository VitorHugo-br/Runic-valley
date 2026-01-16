extends CharacterBody2D

@export var speed = 500.0

@export var dash_speed = 2000.0
@export var dash_duration = 0.18
@export var dash_cooldown = 0.8

var is_dashing = false
var can_dash = true

func _physics_process(_delta):
	if is_dashing:
		move_and_slide()

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("run"):
		start_run()
		
	if Input.is_action_just_released("run"):
		speed = 500
		
	if Input.is_action_just_pressed("dash") and can_dash and direction != Vector2.ZERO:
		start_dash(direction)

func start_dash(direction):
	is_dashing = true
	can_dash = false
	
	velocity = direction.normalized() * dash_speed
	
	await get_tree().create_timer(dash_duration).timeout
	is_dashing = false
	
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true
	
func start_run():
	speed = 800
