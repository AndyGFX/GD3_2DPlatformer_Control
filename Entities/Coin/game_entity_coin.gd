extends Area2D


var item_type = "coins"
export var item_amount = 1
export var item_id = 0

func _get_item_rect():
	return self.get_node("Sprite").get_item_rect()
	
func _ready():
	pass

# pickup item method is called from area detector assigned on player
func PickupCoin():
	if !GameData: return	
	GameData.Add(item_type,item_amount)
	Utils.Instantiate(Globals.pickup_anim,get_global_position())
	Globals.player_sfx.Play("Pickup")
	queue_free()
	
func PickupControl(state):
	$CollisionShape2D.disabled = !state