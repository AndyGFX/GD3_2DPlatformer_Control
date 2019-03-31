extends "res://Prefabs/PowerUps/PowerUp.gd"

	
func Initialize():	
	GameData.powerup_speed = 1
	move_control.SetSpeed(new_value)
	timer.start()
	pass
	
func on_timer_complete():
	GameData.powerup_speed = 0
	move_control.RestoreSpeed()	
	queue_free()
		