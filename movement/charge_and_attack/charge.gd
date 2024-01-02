extends StateNode


@export var charge_time : float = 2;


var player : Player;
var charged : bool;

func enter(from : String, payload : Variant = null) -> void:
	super.enter(from, payload);
	player = Player.instance;
	charged = false;
	get_tree().create_timer(charge_time).timeout.connect(
		func():
			charged = true;
	);

func physics_process(delta: float) -> String:
	if not is_instance_valid(player):
		return "to_target";
	var enemy : Enemy = context.context;
	if not charged:
		enemy.look_at(player.global_position);
		return "";
	return "attack"

func exit(to : String) -> Variant:
	if is_instance_valid(player):
		return player.global_position;
	return Vector2.ZERO;
