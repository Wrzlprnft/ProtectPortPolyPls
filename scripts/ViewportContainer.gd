extends ViewportContainer

func _ready():
	Events.connect("mount_positon",self,"update_mount_position")
	Events.connect("mount_selected",self,"show_turret_menu")
	Events.connect("mount_deselected",self,"hide_turret_menu")
	

func _input( event ):
	if event is InputEventMouse:
		var mouseEvent = event.duplicate()
		mouseEvent.position = get_global_transform().xform_inv(event.global_position)
		$Viewport.unhandled_input(mouseEvent)
	else:
		$Viewport.unhandled_input(event)

func update_mount_position(pos):
	$Mount.rect_global_position = $Viewport/Camera.unproject_position(pos) - $Mount.rect_size/2.0
	
func show_turret_menu() -> void:
	$Mount.show()
	$NinePatchRect.show()
	
func hide_turret_menu() -> void:
	$Mount.hide()
	$NinePatchRect.hide()


func _on_Button_pressed():
	Events.emit_signal("build_turret",-1)
	Events.emit_signal("mount_deselected")
