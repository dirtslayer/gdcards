extends Node2D

onready var status = get_parent().get_node("VBoxContainer/Status")
onready var spriteList = get_parent().get_node("VBoxContainer/SpriteList")

var grabbed_card = null

var card_offsets = Array()
var back_offsets = Array()

func _ready():
	for r in range (4):
		for n in range(13):
			if not (r==0 and n==0):
				card_offsets.append(Vector2((n) * 263.25,(r)*351.25))
			
	
	back_offsets.append(Vector2(-263,0))
	back_offsets.append(Vector2(-526,0))
	# todo: add the rest
	
	var aceofclubs = get_node("aceofclubs")
	var backs = get_node("aceofclubs/backs")
	var redback = get_node("aceofclubs/backs/redback")
	var rr # region rect
	
	for o in back_offsets:
		var newback = redback.duplicate()
		rr = redback.get_region_rect()
		rr.position.x += o.x
		rr.position.y += o.y
		newback.set_region_rect(rr)
		backs.add_child(newback)
		newback.visible = true
	
	aceofclubs.z_index = 1
	var s
	var t2
	var spread = 20
	var z = 1
	
	for o in card_offsets:
		t2 = aceofclubs.duplicate()
		s = t2.get_node("face")
		rr = s.get_region_rect()
		rr.position.x += o.x
		rr.position.y += o.y
		s.set_region_rect(rr)
		add_child(t2)
		t2.position.x += spread
		z += 1
		t2.z_index = z
		spread += 20

var sprites = []
var top_sprite = null

# top_node will have its z_index = cards.size()
# all the rest will be renumbered preserving the current order
# so the cards after the previous zindex will be bumped down
func setz(top_node):
	var split = top_node.z_index
	print('split %s',split)
	var i = 1
	for c in get_children():
		if (c is Area2D): #sanity check really may not need this
			if ( c.z_index > split):
				print('set node z index %s' % [i])
				c.z_index -= 1
		i += 1
	top_node.z_index = get_child_count()

class SpritesSorter: #Custom sorter
	static func z_index(a, b): #Sort by z_index
		if a.z_index > b.z_index:
			return true
		return false

func _add_sprite(sprt): #Add sprite to list
	if not sprites.find(sprt) == -1: #If sprite exists
		return #Do nothing
	sprites.append(sprt) #Add sprite to list

func _remove_sprite(sprt): #Remove sprite from list
	var idx = sprites.find(sprt) #find the index
	sprites.remove(idx) #remove

func _top_sprite(): #Get the top sprite
	if len(sprites) == 0: #If the list is empty
		return null
	sprites.sort_custom(SpritesSorter, "z_index") #Sort by z_index
	return sprites[0] #Return top sprite

var grabbed_offset

func _on_aceofclubs_input_event(viewport, event, shape_idx):
	#print("_on_aceofclubs_input_event")
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			top_sprite = _top_sprite()
			if top_sprite: 
				top_sprite.is_dragging = true 
				
				if (top_sprite.z_index != get_child_count()):
#					top_sprite.z_index = get_child_count()
					setz(top_sprite)
		else : 
			if top_sprite:
				top_sprite.is_dragging = false #Set dragging to false
				top_sprite = null #Top sprite to null
	_print_status()

func _print_status():
	var aux_sprt = []
	var aux_sprt_can_drag = []
	for i in sprites:
		aux_sprt.append(i.z_index)
	for i in sprites:
		aux_sprt_can_drag.append(i.is_dragging)
	if not top_sprite == null:
		status.text = "Top: " + str(top_sprite.z_index) + " - Dragging: " + str(top_sprite.is_dragging)
		spriteList.text = "Sprites: " + str(aux_sprt) + " - Can drag: " + str(aux_sprt_can_drag)
	else:
		status.text = "Top: null - Dragging: False"
		spriteList.text = "Sprites: " + str(aux_sprt) + " - Can drag: " + str(aux_sprt_can_drag)
