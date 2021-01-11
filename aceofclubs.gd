extends Area2D

onready var face:Sprite = $face
onready var cards:Node2D = get_parent()

var grabbed_offset = Vector2()

var mouse_in = false
var is_dragging = false
var mouse_to_center_set = false
var mouse_to_center
var sprite_pos
var mouse_pos

onready var p = get_parent()

func _process(_delta):
	if (is_dragging):
		#position = get_global_mouse_position() + p.grabbed_offset
		mouse_pos = get_viewport().get_mouse_position()
		#Set the position of the sprite to
		#mouse position + static mouse_to_center vector
		set_position(sumaVectores(mouse_pos, mouse_to_center))

func restaVectores(v1, v2): #vector substraction
	return Vector2(v1.x - v2.x, v1.y - v2.y)

func sumaVectores(v1, v2): #vector sum
	return Vector2(v1.x + v2.x, v1.y + v2.y)

func _on_aceofclubs_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			mouse_pos = get_viewport().get_mouse_position()
			mouse_to_center = restaVectores(self.position, mouse_pos)
	if  event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and !event.pressed: 
		face.visible = not face.visible
		get_tree().set_input_as_handled()

func _on_aceofclubs_mouse_exited():
	mouse_in = false
	get_parent()._remove_sprite(self)  #Remove the sprite from the sprite list

func _on_aceofclubs_mouse_entered():
	mouse_in = true
	get_parent()._add_sprite(self) #Add the sprite to the sprite list
