class_name Enemy extends Node2D;


@export var hurt_box : Area2D;
@export var hit_box : Area2D;
@export var health_c : HealthC;
@export var color : Color = Color.WEB_GRAY;

const particles_scene : PackedScene = preload("res://particles/onhit.tscn")

var activate_side_effect : bool;


func _ready() -> void:
	get_tree().create_timer(40).timeout.connect(queue_free)
	if health_c != null:
		health_c.depleted.connect(die)
	if hurt_box != null:
		hurt_box.body_entered.connect(take_damage)
	if hit_box != null:
		hit_box.set_meta("enemy_hitbox", true);
	modulate = color;

func take_damage(body : Node2D) -> void:
	if !(body is Bullet):
		return
	if health_c != null:
		health_c.damage(body.damage);
	var particles : Node2D = particles_scene.instantiate();
	Globals.add_particle.emit(
		particles,
		body.global_position,
		particles.global_position + global_position.direction_to(body.global_position),
	);
	body.queue_free();

func die():
	var particles : Node2D = particles_scene.instantiate();
	Globals.add_particle.emit(
		particles,
		global_position,
		global_position,
	);
	queue_free()
