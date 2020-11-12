extends Node2D

onready var boss = $Boss
onready var player = $Player
export var cantDeClones = 3

func _ready():
	player.setCantLimiteClones(cantDeClones)
	boss.personajePosition(player.position)
	

# warning-ignore:unused_argument
func _physics_process(delta):
	if player.activo:
		$Camera2D.position =  player.position
	elif player.new_clon != null:
		$Camera2D.position =  player.new_clon.position
	boss.personajePosition(player.position)
		
func _on_game_over():
	$TimerDead.start()
	player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	player.remove_clon(clone)


func _win_game(body):
	if body.is_in_group("player"):
		player.win()
		$win.play()