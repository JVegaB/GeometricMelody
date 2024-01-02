extends Node2D

func show_text():
	await modulate_node($A)
	await modulate_node($B, true)

func modulate_node(node : Node2D, final : bool = false):
	var tween := create_tween();
	node.visible = true;
	tween.tween_property(node, "modulate", Color.WHITE, .5)
	await tween.finished;
	if final:
		return;
	await get_tree().create_timer(2.5).timeout
	tween = create_tween()
	tween.tween_property(node, "modulate", Color.TRANSPARENT, .5)
	await tween.finished;
