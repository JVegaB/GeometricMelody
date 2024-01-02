class_name Player
extends CharacterBody2D


@export var max_speed : Vector2 = Vector2(200, 200);
@export var acceleration : float = 1;

var curr_velocity : Vector2;
var input_movement : Vector2;
const particles_scene : PackedScene = preload("res://particles/onhit.tscn")

static var instance : Player;

var inmortal : bool;


func make_inmortal():
	$HeartC.done = true

func _ready():
	instance = self;
	$HeartC.depleted.connect(die);
	$Hurtbox.area_entered.connect(_enemy_entered)

func _enemy_entered(enemy : Node2D) -> void:
	if not enemy.has_meta("enemy_hitbox"):
		return;
	velocity = enemy.global_position.direction_to(global_position) * 100
	move_and_slide()
	enemy.get_parent().die()
	$HeartC.damage(1)

func die():
	Globals.player_died.emit();
	var particles : Node2D = particles_scene.instantiate();
	Globals.add_particle.emit(
		particles,
		global_position,
		global_position,
	);
	queue_free()

func _input(event : InputEvent) -> void:
	input_movement = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()
	var face_direction := global_position.direction_to(
		get_global_mouse_position());
	var next_rotation = Vector2.RIGHT.angle_to(face_direction)
	global_rotation = next_rotation

func _physics_process(delta : float) -> void:
	curr_velocity += input_movement * acceleration;
	curr_velocity = curr_velocity.clamp(-max_speed, max_speed);
	velocity = curr_velocity
	move_and_slide();
	curr_velocity = lerp(curr_velocity, Vector2.ZERO, delta)
