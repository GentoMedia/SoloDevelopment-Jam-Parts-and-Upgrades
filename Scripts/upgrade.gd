extends StaticBody3D

signal upgrade (upgrade_name : String)


func hit_machine(_damage : int):
	upgrade.emit(get_parent().name)
