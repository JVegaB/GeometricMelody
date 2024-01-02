extends HordeSpawn


func _ready():
	$Inline.global_position = Globals.get_spawn_position();
	$Inline.look_at(Globals.get_center_screen());
