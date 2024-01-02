extends HordeSpawn


func _ready():
	$SpinSpawner.global_position = Globals.get_spawn_position();
	$SpinSpawner.look_at(Globals.get_center_screen());
