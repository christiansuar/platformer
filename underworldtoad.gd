extends CharacterBody2D


var SPEED = -20
var facing_right = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_alive = true


@onready var animated_sprite_2d = $AnimatedSprite2D


func _ready():
	add_to_group("Enemy")


func _physics_process(delta):
	if not is_on_floor():# Add the gravity.
		velocity.y += gravity * delta
		
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
		
	# Set the hortizontal velocity to a constant negative value to m
	velocity.x = SPEED
	
	update_animation()
	move_and_slide()
	
func update_animation():
	animated_sprite_2d.play("hop")



func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		is_alive = false
		#deletes sprite 
		queue_free()

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1
