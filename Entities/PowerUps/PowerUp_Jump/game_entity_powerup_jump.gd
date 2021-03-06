extends Area2D


export var new_jump_force = 300;
export var time_to_off = 10
export var item_id = 0

var item_type = "powerup_jump"


func _get_item_rect():
	return self.get_node("Sprite").get_item_rect()
	
func _ready():
	pass

# pickup key method which is called from area detector assigned on player
func PickupPowerUpJump():
	if GameData.Get("powerup_jump")==0:
		GameData.Set("powerup_jump",1)
		Utils.Instantiate(Globals.pickup_powerup_anim,get_global_position())
		Globals.player_sfx.Play("Pickup")
		Globals.powerup_jump_icon.modulate = Color.white
		queue_free()
