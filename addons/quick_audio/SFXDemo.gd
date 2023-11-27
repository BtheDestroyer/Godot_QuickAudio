# Put this script on something you want to play sound effects
extends Node

# Set this in the inspector
@export var sound: AudioStream

func _ready():
  if not is_instance_valid(sound):
    print("QuickAudio SFX Demo script is lacking a \"sound\". Set it in the inspector on the node: {0}".format([get_path()]))
  else:
    print("QuickAudio SFX Demo script active! Press 1, 2, or 3 to play sound effects")

func _input(event):
  if not is_instance_valid(sound):
    return
  match event:
    var key when key is InputEventKey:
      if key.pressed:
        match key.physical_keycode:
          KEY_1:
            # Play with no position
            Audio.play_sound(sound)
          KEY_2:
            # Play and set the position
            if has_method("get_global_position"):
              var pos = call("get_global_position")
              if pos is Vector3:
                Audio.play_sound_3d(sound).global_position = pos
                return
              elif pos is Vector2:
                Audio.play_sound_2d(sound).global_position = pos
                return
            push_warning("Can't play positional audio on non-positional node")
          KEY_3:
            # Play with a few extra settings
            var player = null
            if has_method("get_global_position"):
              var pos = call("get_global_position")
              if pos is Vector3:
                player = Audio.play_sound_3d(sound, false)
                player.unit_size = 1.0
              elif pos is Vector2:
                player = Audio.play_sound_2d(sound, false)
                player.attenuation = 0.1
            if player == null:
              player = Audio.play_sound(sound, false)
            player.pitch_scale = 1.25
            player.play()
