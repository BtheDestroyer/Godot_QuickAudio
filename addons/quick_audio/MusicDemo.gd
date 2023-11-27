# Put this script on something you want to control music
extends Node

# Set this in the inspector
@export var song_1: AudioStream
@export var song_2: AudioStream
var music_player: AudioStreamPlayer

func _ready():
  var valid := true
  if not is_instance_valid(song_1):
    print("QuickAudio Music Demo script is lacking a \"song_1\". Set it in the inspector on the node: {0}".format([get_path()]))
    valid = false
  if not is_instance_valid(song_2):
    print("QuickAudio Music Demo script is lacking a \"song_2\". Set it in the inspector on the node: {0}".format([get_path()]))
    valid = false
  if valid:
    print("QuickAudio Music Demo script active! Press 4 and 5 to play music")
    music_player = Audio.play_sound(song_1)

func _input(event):
  if not is_instance_valid(song_1) or not is_instance_valid(song_2) or not is_instance_valid(music_player):
    return
  var current_song := music_player.stream
  var other_song := song_2 if current_song == song_1 else song_1
  match event:
    var key when key is InputEventKey:
      if key.pressed:
        match key.physical_keycode:
          KEY_4:
            # Crossfade
            var old_player := music_player
            music_player = Audio.play_sound(other_song, false)
            Audio.cross_fade(old_player, music_player)
            music_player.play()
          KEY_5:
            # Sequential fade
            var old_player := music_player
            music_player = Audio.play_sound(other_song, false)
            Audio.sequential_fade(old_player, music_player)
            music_player.play()
