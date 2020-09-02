extends Node2D

func _ready():
	pass

func _physics_process(_delta):
	$Camera2D.position.y = $Player.position.y

#func buildtower(delta):
#	if delta < 2:
#		drop = scene.instance()
#		randomize()
#		piece = round(rand_range(1, 2))
#		drop = scene.instance()
#		drop.position.y = delta * -290
#		drop.piece = piece
#		$"Tower Pieces".add_child(drop)
#		buildtower(delta + 1)
