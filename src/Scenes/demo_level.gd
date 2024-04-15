extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var game_over_ui: Control = $GameOverUI
@onready var game_over_label: Label = $GameOverUI/Label
@onready var hint_ui: Control = $HintUI
@onready var hint_label: Label = $HintUI/Label
@onready var hint_timer: Timer = $HintTimer
@onready var beats = [$BeatA, $BeatB, $BeatC, $BeatD]
@onready var basses = [$BassA, $BassB, $BassC, $BassD]
@onready var leads = [$LeadA, $LeadB, $LeadC, $LeadD]
@onready var synths = [$SynthA, $SynthB]
@onready var music_timer = $Timer

var is_box_placed = false
var is_game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var volumn_db = -30
	for beat in beats:
		beat.volume_db = volumn_db
	for bass in basses:
		bass.volume_db = volumn_db
	for lead in leads:
		lead.volume_db = volumn_db
	for synth in synths:
		synth.volume_db = volumn_db
	_on_timer_timeout()
	music_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_kernel_out_of_sockets():
	hint_timer.start()
	hint_ui.show()
	hint_label.text = "Hint: delete a unit to make room for an open slot."

func _on_kernel_com_summons():
	game_over_ui.show()
	game_over_label.text = "Game Over!"
	is_game_over = true
	var synth = synths[randi() % synths.size()]
	synth.play()

func _on_kernel_player_summons():
	game_over_ui.show()
	game_over_label.text = "Victory!"
	is_game_over = true
	var synth = synths[randi() % synths.size()]
	synth.play()


func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_hint_timer_timeout():
	hint_ui.hide()


func _on_timer_timeout():
	for beat in beats:
		beat.stop()
	for bass in basses:
		bass.stop()
	for lead in leads:
		lead.stop()
	for synth in synths:
		synth.stop()
	var beat = beats[randi() % beats.size()]
	beat.play()
	if is_box_placed:
		var bass = basses[randi() % basses.size()]
		bass.play()
	if Globals.is_violent:
		var lead = leads[randi() % leads.size()]
		lead.play()
	if is_game_over:
		var synth = synths[randi() % synths.size()]
		synth.play()
	


func _on_kernel_box_placed():
	if not is_box_placed:
		var bass = basses[randi() % basses.size()]
		bass.play()
	is_box_placed = true	
