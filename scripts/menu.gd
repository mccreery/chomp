extends Control

func _on_StartButton_pressed():
    get_tree().change_scene("res://scenes/test_level.tscn")

func _on_HowToPlayButton_pressed():
    get_tree().change_scene("res://scenes/how_to_play_menu.tscn")

func _on_QuitButton_pressed():
    get_tree().quit()
