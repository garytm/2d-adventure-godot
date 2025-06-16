extends CharacterBody2D
class_name Player

@export var move_speed: float = 100
@export var push_strength: float = 1
func _ready() -> void:
	if SceneManager.player_spawn_position != Vector2(0, 0):
		position = SceneManager.player_spawn_position

func _physics_process(delta: float) -> void:
	
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed
	
	if velocity.x > 0:
		$AnimatedSprite2D.play("move_right")

	elif velocity.x < 0:
		$AnimatedSprite2D.play("move_left")
		
	elif velocity.y < 0:
		$AnimatedSprite2D.play("move_up")
		
	elif velocity.y > 0:
		$AnimatedSprite2D.play("move_down")
		
	else:	
		$AnimatedSprite2D.stop()

	# Get the last collision
	# Check if it is the block
	#If it is, push it
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision: 
		
		var collider_node = collision.get_collider()
		
		if collider_node.is_in_group("Pushable"):
			var collision_normal: Vector2 = collision.get_normal()
			
			collider_node.apply_central_force(-collision_normal * push_strength)
	
	move_and_slide()
