extends HordeSpawn;


func _ready():
	$Random.spawn_target_container = spawn_target_container;
	$Random.spawn()
