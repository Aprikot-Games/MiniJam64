extends Spatial
export (PackedScene) var TerrainBlock
export (PackedScene) var HeroBullet

const SHOT_SPEED = 250
var last_spawn_point = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var crosshair = $Player/Ship/Crosshair
	pass # Replace with function body.

func _process(delta):
	var camera_pos = $Player/Ship.transform.origin
	camera_pos.z -= 10
	camera_pos.y += 2
	$Camera.transform.origin.z = camera_pos.z
	var int_cam = int(camera_pos.z)
	if int(camera_pos.z) % 10 == 0 and int_cam != last_spawn_point:
		print("Spawn new square")
		last_spawn_point = int_cam
		var new_terrain_chunk = TerrainBlock.instance()
		var x = Vector3(5, 0, 0)
		var y = Vector3(0, 0.2, 0)
		var z = Vector3(0, 0, 5)
		new_terrain_chunk.transform.basis.x = x
		new_terrain_chunk.transform.basis.y = y
		new_terrain_chunk.transform.basis.z = z
		add_child(new_terrain_chunk)
		new_terrain_chunk.transform.origin.z = int_cam + 50
	var cam_diff_x = camera_pos.x - $Camera.transform.origin.x
	var cam_diff_y = camera_pos.y - $Camera.transform.origin.y
	if cam_diff_x > 0.5 and $Camera.transform.origin.x < 0.5:
		$Camera.transform.origin.x += 0.075
	elif cam_diff_x < -0.5 and $Camera.transform.origin.x > -0.5:
		$Camera.transform.origin.x -= 0.075
	if cam_diff_y > 0.5 and $Camera.transform.origin.y > -0.5:
		$Camera.transform.origin.y += 0.075
	elif cam_diff_y < -0.5 and $Camera.transform.origin.y > -0.5:
		$Camera.transform.origin.y -= 0.075
	var near_aim = $Player/Ship/NearAim
	var hud_near_aim = $HUD/NearAim
	var far_aim = $Player/Ship/FarAim
	var hud_far_aim = $HUD/FarAim
	hud_near_aim.position = $Camera.unproject_position(near_aim.global_transform.origin)
	hud_far_aim.position = $Camera.unproject_position(far_aim.global_transform.origin)

func on_hero_shoot():
	var new_bullet = HeroBullet.instance()
	add_child(new_bullet)
	new_bullet.global_transform.origin = $Player/Ship.global_transform.origin
	new_bullet.linear_velocity.z = SHOT_SPEED * $Player/Ship.transform.basis.z.z
	new_bullet.linear_velocity.x = SHOT_SPEED * $Player/Ship.transform.basis.z.x
	new_bullet.linear_velocity.y = SHOT_SPEED * $Player/Ship.transform.basis.z.y
