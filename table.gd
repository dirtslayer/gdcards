extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

var face
var c
var table
var cards

func _on_stack_cards_button_up():
	table = self
	cards = table.get_node("cards").get_children()
	for c in cards:
		face = c.get_node("face")
		face.visible = false
		c.position = Vector2(20,20)
		
	
const SHUFFLE_FACTOR = 1000


var i1
var i2
var i3

func _on_shuffle_cards_button_up():
	table = self
	cards = table.get_node("cards").get_children()
	var randzindecies = range(cards.size())
	for n in range(SHUFFLE_FACTOR):
		randzindecies.shuffle()
		
	var i = 0	
	for c in cards:
		c.z_index = randzindecies[i]
		i += 1
		
	
	
	pass # Replace with function body.


func _on_change_back_button_up():
		get_node("bgselector").visible = true
		# for some reason when we set it to true again the cards are 
		# put back will look into
		get_node("cards").visible = false

