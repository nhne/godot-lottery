extends Node2D


@export var ball_scene: PackedScene

var elapsed = 0
var spin_speed = PI / 8
var ball_numbers = []

var angular_speed = PI
var speed = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1, 46):
		ball_numbers.append(i)
	ball_numbers.shuffle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(ball_numbers) > 0:
		elapsed += delta
		if elapsed > 0.06:
			elapsed -= 0.06
			_spawn_ball(ball_numbers.pop_front())
	else:
		# box
		rotation -= spin_speed * delta

		# pusher
		var pusher = $Pusher
		pusher.rotation += angular_speed * delta
		var velocity = Vector2.UP.rotated(pusher.rotation) * speed
		pusher.position += velocity * delta * 2


func _spawn_ball(number):
	var ball = ball_scene.instantiate()
	ball.position = $SpawnLocation.position
	ball.position += Vector2(randf_range(-5, 5), 0)
	ball.set_label(number)
	add_child(ball)
