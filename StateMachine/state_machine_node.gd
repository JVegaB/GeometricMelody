class_name StateMachineNode extends Node;


@export var debug : bool;
var states : Dictionary = {};
var _current : String;


func _ready():
	for child in get_children():
		if child is StateNode:
			add_state(child);
	assert(_current != "", "No initial state was defined.");
	states[_current].enter("");

func add_state(state_node: StateNode):
	var context : Node = get_parent();
	state_node.context = context;
	states[state_node.state_name] = state_node;
	if state_node.initial:
		_current = state_node.state_name;

func switch_to_state(new_state : String) -> void:
	var paylaod : Variant = states[_current].exit(new_state);
	var old_state : String = _current;
	_current = new_state;
	states[_current].enter(old_state, paylaod);

func _physics_process(delta : float) -> void:
	var new_state : String = states[_current].physics_process(delta);
	if new_state != "":
		if debug:
			print('changing to state: ', new_state)
		switch_to_state(new_state);
