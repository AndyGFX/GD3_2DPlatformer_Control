extends Area2D

export var source_name = "<undefined>"
export var target_name = "<undefined>"
export var on_button = "key_use"
export var need_key_item = false
export var key_item_name = "<undefined>"
export var teleport_type = 0

var eventOwner = null
var item_type = "teleport"
var _enabled_btn_check = false
#------------------------------------------------
# 
#------------------------------------------------
func _ready():
	self.source_name = self.name
	pass
	
#------------------------------------------------
# teleport to target area when key_use is pressed on player
#------------------------------------------------
func Teleport(player):
	
	if need_key_item:
		if GameData.HasItem(key_item_name,1):
			_enabled_btn_check = false
			return
			pass
		pass
	
	_enabled_btn_check = true	
	eventOwner = player
	pass

#------------------------------------------------
# reset prepared teleportation
#------------------------------------------------
func ResetTeleport():
	print("btn stop")
	_enabled_btn_check = false

#------------------------------------------------
# MAIN Loop
#------------------------------------------------
func _process(delta):
	update()
	if Input.is_action_pressed(on_button) and _enabled_btn_check:
		_enabled_btn_check = false
		var target_node = Utils.FindNode(target_name)
		var target_pos = target_node.get_node("SpawnPosition")
		var pos = target_pos.get_global_position()
		eventOwner.set_position(pos)
	pass
	
#------------------------------------------------
# Draw portal connection
#------------------------------------------------
func _draw():
	var obj = Utils.FindNode(self.target_name)
	if obj:
		draw_line(self.position,obj.position,Color(0,1,0,1))
	pass
