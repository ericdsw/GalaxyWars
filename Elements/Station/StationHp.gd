extends '../General/HpBar.gd'

func _initial_configuration():
	initial_corner = get_node("InitialCorner").get_pos()
	final_corner   = get_node("FinalCorner").get_pos()

	._initial_configuration()
