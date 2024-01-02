class_name StateNode extends Node;


@export var state_name : String;
@export var initial : bool;
@export var context : Node;

var previous_state : String;


func _ready():
	randomize();

func physics_process(delta: float) -> String:
	return "";

func enter(from : String, payload : Variant = null) -> void:
	previous_state = from

func exit(to : String) -> Variant:
	return null;
