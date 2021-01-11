extends Area2D

#gross but i am at wits end trying to figure out a way to get the root node
onready var Table = get_parent().get_parent().get_parent()
onready var Cards = Table.get_node("cards")
onready var Bgselector = Table.get_node("bgselector")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_bgarea_input_event(viewport, event, shape_idx):
	
	var bgsel = Table.get_node("bgselector")
	var faces = Table.get_node("bgselector/Color_52_Faces_v20")
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not event.pressed:
			var ca = faces.get_children()
			var i = ca.find(self)
			print(i)
			var ii = 0
			for c in Cards.get_children():
				
				var Backs = c.get_node("backs")
				ii = Backs.get_child_count()
				for b in Backs.get_children():
					b.visible = (i == (ii-2))
					ii -= 1
			Bgselector.visible = false
			Cards.visible = true
		
			
	pass # Replace with function body.
