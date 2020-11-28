extends Area2D

var estaSentado = true
var estaCaminando = false
onready var sprite = $Mascota

func _ready():
	sprite.play("quieto")
	sprite.offset.y = -15
	
func correr():
	sprite.play("correr")
	sprite.offset.y = -15
	
func caminar():
	sprite.play("caminar")
	sprite.offset.y = -15
	estaSentado = false

func _physics_process(delta):
	if (!estaSentado):
		if (estaCaminando):
			position.x -= 0.4
		else: 
			position.x -= 0.7


func rencuentro():
	sprite.play("rencuentro")
	estaSentado = true


func _on_Mascota_body_entered(body):
	if body.is_in_group("player"):
		rencuentro()
