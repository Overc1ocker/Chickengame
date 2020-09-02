extends KinematicBody2D

var motion = Vector2(0, 200)
var double_jump
var hp = 3
var speed = 175
var moveabled = true

func _ready():
	fighting()

func _physics_process(_delta):
	if Input.is_action_pressed("1"):
		$Controller.position.y = -100
	elif Input.is_action_pressed("2"):
		$Controller.position.y = 100
	
	if Input.is_action_pressed("3"):
		$Controller.position.x = -100
	elif Input.is_action_pressed("4"):
		$Controller.position.x = 100
	
	if hp < 1:
		moveabled = false
	
	if Input.is_action_pressed("left") and motion.x > -speed and moveabled == true:
		motion.x -= speed/10
	elif Input.is_action_pressed("right") and motion.x < speed and moveabled == true:
		motion.x += speed/10
	elif motion.x > 0:
		motion.x -= speed/10
	elif motion.x < 0:
		motion.x += speed/10
	
	if Input.is_action_just_pressed("dashleft") and moveabled == true: #Elizabeth owes Clayton $5
		motion.x = -speed * 3
	elif Input.is_action_just_pressed("dashright") and moveabled == true:
		motion.x = speed * 3
	
	if Input.is_action_just_pressed("up") and is_on_wall() and moveabled == true:
		double_jump = 1
		motion.y = -300
	elif Input.is_action_just_pressed("up") and double_jump == 1 and moveabled == true:
		motion.y = -200
		double_jump = 0
	elif motion.y < 300 or Input.is_action_pressed("glide") and moveabled == true:
		if Input.is_action_pressed("glide") and motion.y > 0:
			motion.y = 30
		else:
			motion.y += 12
	elif is_on_wall():
		motion.y = 0
	
	if position.y > 100:
		position.y = -500
	
	$Bottom.speed_scale = 1 + (abs(motion.x) / 50)
	
	if motion.x > 0:
		$Bottom.flip_h = false
		$Bottom.playing = true
		$Bottom.animation = "Walk"
	elif motion.x < 0:
		$Bottom.flip_h = true
		$Bottom.playing = true
		$Bottom.animation = "Walk"
	else:
		$Bottom.playing = false
	
	if position.x < get_global_mouse_position().x:
		$Damage.cast_to.x = 50
		$Top.flip_h = false
		$Top.offset.x = 0
	elif position.x > get_global_mouse_position().x:
		$Damage.cast_to.x = -50
		$Top.flip_h = true
		$Top.offset.x = -70
	
	move_and_slide(motion)

func fighting():
	if Input.is_action_just_pressed("Item1") and moveabled == true:
		$Top.animation = "Punch"
		$Top.playing = true
		yield(get_tree().create_timer(0.4), "timeout")
		$Top.frame = 0
		$Top.stop()
	
	yield(get_tree().create_timer(0.01), "timeout")
	fighting()
