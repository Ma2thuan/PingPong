extends StaticBody2D


var ball_pos: Vector2
var dist: int
var move_by: int
var win_height: int  # chiều cao của màn hình
var p_height: int #chiều cao của thanh đánh


# Called when the node enters the scene tree for the first time.
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#di chuyển thanh đánh về phía banh
	ball_pos =  $"../Ball".position
	dist = position.y - ball_pos.y
	
	
	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		move_by = get_parent().PADDLE_SPEED * delta * (dist / abs(dist))
	else:
		move_by = dist
	#move by được dùng đề xác định CPU cần phải di chuyển đi đâu
	# (dist / abs(dist) được dùng để xác định banh đang ở nữa trên hay nữa dưới màn hình với abs lun có giá trị dương 
	# nếu đang ở nữa dưới dist sẽ âm và trả về -1 nếu nữa trên dist sẽ dương
	
	
	position.y -= move_by
	
		
	# Giới hạn thanh đánh trong màn hình thấy được
	position.y = clamp(position.y , p_height / 2 ,win_height - p_height / 2)
