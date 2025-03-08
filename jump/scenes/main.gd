extends Node

# Game variables
const DINO_START_POS := Vector2(150, 485)  # Starting position of the Dino
const CAM_START_POS := Vector2(576, 324)  # Starting position of the camera

var speed : float = START_SPEED
const START_SPEED : float = 10.0
const MAX_SPEED : float = 25 # Max speed of the Dino and camera

var screen_size : Vector2  # Store the screen size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size  # Get the screen size of the viewport
	new_game()

func new_game():
	# Reset the nodes
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2(0, 0)  # Assuming Dino has a velocity property
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2(0, 0)  # Starting position of the ground

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Gradually increase speed over time, but don't exceed max speed
	if speed < MAX_SPEED:
		speed += delta * 2  # Increase speed gradually

	# Move Dino and camera horizontally based on speed
	$Dino.position.x += speed * delta
	$Camera2D.position.x += speed * delta

	# Move the ground and background
	$GroundContainer.position.x -= speed * delta
	$BgContainer.position.x -= speed * delta * 0.5  # Move background slower for parallax

	# Get ground width (assuming both Ground1 and Ground2 have the same width)
	var ground_width = $GroundContainer/Ground1.texture.get_width()
	
	# Loop ground
	if $GroundContainer/Ground1.position.x <= -ground_width:
		$GroundContainer/Ground1.position.x += ground_width * 2
	if $GroundContainer/Ground2.position.x <= -ground_width:
		$GroundContainer/Ground2.position.x += ground_width * 2

	# Get background width (same logic as ground)
	var bg_width = $BgContainer/Bg1.texture.get_width()
	
	# Loop background
	if $BgContainer/Bg1.position.x <= -bg_width:
		$BgContainer/Bg1.position.x += bg_width * 2
	if $BgContainer/Bg2.position.x <= -bg_width:
		$BgContainer/Bg2.position.x += bg_width * 2
