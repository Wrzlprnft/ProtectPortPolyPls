extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("speed1_changed",self,"speed1_changed")
	Events.connect("speed2_changed",self,"speed2_changed")
	Events.connect("speed3_changed",self,"speed3_changed")
	Events.connect("update_time",self,"update_time")
	Events.connect("game_started",self,"start_game")
	Events.connect("game_ended",self,"end_game")
	Events.connect("currency_changed",self,"update_currency")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_game() -> void:
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Start.text = "Restart"
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Pause.disabled = false
	$VBoxContainer2/RichTextLabel/AnimationPlayer.stop(true)
	
func end_game() -> void:
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Pause.disabled = true

func update_time(value) -> void:
	var time = "%.1f" % value	
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Timebox/Value.bbcode_text = "[right]"+ time +"[/right]"
	
func update_currency(value,dummy) -> void:
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Creditbox/Value.bbcode_text = "[right]" + str(value) + "$[/right]"

func speed1_changed(value) -> void:
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Ring1Box/RichTextLabel2.bbcode_text = "[center]"+str(value)+"[/center]"

func speed2_changed(value) -> void:
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Ring2Box/RichTextLabel2.bbcode_text = "[center]"+str(value)+"[/center]"

func speed3_changed(value) -> void:
	$VBoxContainer2/TabContainer/Buttons/VBoxContainer/Ring3Box/RichTextLabel2.bbcode_text = "[center]"+str(value)+"[/center]"

func _on_Ring1Left_pressed():
	Events.emit_signal("change_speed1",-1)


func _on_Ring1Right_pressed():
	Events.emit_signal("change_speed1",1)


func _on_Ring2Left_pressed():
	Events.emit_signal("change_speed2",-1)


func _on_Ring2Right_pressed():
	Events.emit_signal("change_speed2",1)


func _on_Ring3Left_pressed():
	Events.emit_signal("change_speed3",-1)


func _on_Ring3Right_pressed():
	Events.emit_signal("change_speed3",1)


func _on_Game_pressed():
	$VBoxContainer2/TabContainer.current_tab = 1


func _on_Instructions_pressed():
	$VBoxContainer2/TabContainer.current_tab = 0
