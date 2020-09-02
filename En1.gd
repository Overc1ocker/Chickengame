extends KinematicBody2D

var motion = Vector2(0, 200)
var desired

func _ready():
	attack()

func attack():
	if $Damage.is_colliding():
		$Damage.get_collider().get_parent().hp -= 1
		yield(get_tree().create_timer(1.0), "timeout")
	
	yield(get_tree().create_timer(0.01), "timeout")
	attack()

func _physics_process(_delta):
	
	desired = find_node_by_name(get_tree().get_root(), "Player").position
	
	if desired.x + 25 < position.x and motion.x > -100:
		motion.x -= 10
	elif desired.x - 25 > position.x and motion.x < 100:
		motion.x += 10
	elif motion.x > 0:
		motion.x -= 10
	elif motion.x < 0:
		motion.x += 10
	
	if desired.y < position.y and is_on_wall():
		motion.y = -300
	elif motion.y < 300:
		motion.y += 12
	elif is_on_wall():
		motion.y = 0
	
	if position.y > 100:
		position.y = -500
	
	move_and_slide(motion)

func find_node_by_name(root, name):
	if(root.get_name() == name): return root
	for child in root.get_children():
		if(child.get_name() == name):
			return child
		var found = find_node_by_name(child, name)
		if(found): return found
	return null
