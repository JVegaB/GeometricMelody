class_name Gun extends Node2D;


@export_global_file var bullet_path;
@onready var timer = $Timer;

var index : int = 0;
var positions : Array[Marker2D];


func _ready() -> void:
	timer.timeout.connect(spawn);
	for child in get_children():
		if child is Marker2D:
			positions.append(child);

func spawn() -> void:
	var child_count := positions.size();
	if child_count == 0:
		return;
	index += 1;
	if index >= child_count:
		index = 0;
	var spawn_position : Vector2 = positions[index].global_position;
	var bullet_scene : PackedScene = load(bullet_path);
	var bullet : Bullet = bullet_scene.instantiate();
	var parent_node := get_tree().root.get_child(0);
	parent_node.add_child(bullet);
	bullet.global_position = spawn_position;
	bullet.rotation = global_rotation;

func _input(event : InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		spawn();
		timer.start()
	if Input.is_action_just_released("click"):
		timer.stop()
