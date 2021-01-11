extends Node2D

onready var Table = get_parent()

func _ready():
	var cf = get_node("Color_52_Faces_v20")
	var bgarea = get_node("Color_52_Faces_v20/bgarea")
	for i in range(6):
		var nn = bgarea.duplicate()
		var nnshape = nn.get_node("bgshape")
		nnshape.position.x += ( 263 * (i+1) )
		cf.add_child(nn)
	
	pass # Replace with function body.



func _on_Area2D_input_event(viewport, event, shape_idx):
	
	pass # Replace with function body.
