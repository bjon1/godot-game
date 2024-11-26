extends Node
class_name HashSet

const PRESENT = null
var dict : Dictionary = {}

func add(key : Variant) -> bool:
	var has : bool = has(key)
	dict.get_or_add(key, PRESENT)
	return has

func remove(key : Variant) -> bool:
	return dict.erase(key)

func has(key : Variant) -> bool:
	return dict.has(key)

func has_All(keys : Array) -> bool:
	return dict.has_all(keys)

func get_keys() -> Array:
	return dict.keys()

func size() -> int:
	return dict.size()
	
func clear() -> void:
	dict.clear()

func is_empty() -> bool:
	return dict.is_empty()
