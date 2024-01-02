class_name Pentagon extends Enemy

var base_healt = 10;
var level = 2;


func die():
	await newborns()
	return super.die()

func newborns():
	if level <= 0:
		return
	for marker in $NewbornPos.get_children():
		var newborn = load("res://shape/pentagon_a/pentagon.tscn").instantiate()
		newborn.scale = scale / 1.75
		get_parent().add_child(newborn)
		newborn.base_healt = base_healt / 3
		newborn.health_c.health = base_healt / 3
		newborn.level = level - 1
		newborn.global_position = marker.global_position;
