extends StaticBody2D

var win_height: int  # chiều cao của màn hình
var p_height: int #chiều cao của thanh đánh

# Called when the node enters the scene tree for the first time.
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta #get_parent() để lấy biến hoặc hàm trong một script khác
	if Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta
		
	# Giới hạn thanh đánh trong màn hình thấy được
	position.y = clamp(position.y , p_height / 2 ,win_height - p_height / 2)
	#clamp giới hạn vị trí của một object trong khoảng (min , max)
		
