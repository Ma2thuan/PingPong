extends CharacterBody2D

var win_size : Vector2
const START_SPEED: int = 500
const ACCEL: int = 50 #Gia tốc

var speed: int # tốc độ hiện tại

var dir: Vector2 #hướng 


const MAX_Y_VECTOR: float = 0.6

#Gọi khi node được thực hiện lần đầu
func _ready():
	win_size = get_viewport_rect().size
	
func new_ball():
	
	#Khởi tạo vị trí ngẫu nhiên và hướng đi của bóng
	position.x = win_size.x / 2 # Tọa độ x giữa màn hình
	position.y = randi_range(200 ,win_size.y - 200)
	
	speed = START_SPEED
	
	dir = random_direction()
	



func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	
	if collision:
		collider = collision.get_collider()
		
		#nếu trúng thanh đánh
		if collider == $"../CPU" or collider == $"../Player":
			speed += ACCEL
			dir = new_direction(collider)
			$AudioStreamPlayer2D.play()
			
		else: #nếu trúng tường
			dir = dir.bounce(collision.get_normal())
	
func random_direction():
	var new_dir:= Vector2()
	
	new_dir.x = [1,-1].pick_random()
	new_dir.y = randi_range(-1,1)
	
	return new_dir.normalized()	
	
	
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir:= Vector2()
	
	
	#nếu banh hướng vào từ bên phải thì sẽ bật lại phía bên trái
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	
	return new_dir.normalized()





