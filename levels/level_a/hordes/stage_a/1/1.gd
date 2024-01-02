extends HordeSpawn


func _ready():
	$pivot.global_position = Globals.get_spawn_position();
	$pivot.look_at(Globals.get_center_screen());
