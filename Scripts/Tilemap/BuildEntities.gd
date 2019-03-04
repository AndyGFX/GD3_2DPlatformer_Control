extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var root_entities

var file_name = "res://TMX_Map/TiledObjectTypes/objecttypes.tiled"
var objectTypes

func Initialize_ObjectTypes():
	
	# load TMX objecttypes 
	print("ObjectTypes data loaded.")
	
	self.objectTypes = Utils.LoadJSON(file_name) 
	
#	for obj in self.objectTypes.objecttypes.objecttype:	
#		print("   | "+obj.name)
#

# Called when the node enters the scene tree for the first time.
func _ready():

	self.Initialize_ObjectTypes()

	self.root_entities = Utils.FindNode("Entities")

	print("Post-process: build entities in scene at runtime ... ")
	var scene = Utils.FindNode(self.name)
	
	for node in scene.get_children():
		if node is Node2D:
			print("TMX: scan objects ...")
			
			for object in node.get_children():
				object.hide()
				if object.has_meta("Type"):
					var type = object.get_meta("Type")
					#print(type)

					match type:
						"Health":
							Create_health(object)
						"Ammo": 
							Create_ammo(object)
						"Granade":							
							Create_granade(object)
						"Coin":
							Create_coin(object)							
#						"panel":
#							Create_panel(scene,object)
#						"teleport":
#							Create_teleport(scene,object)

				pass
				
func GetObjectTypeFor(object_type_name):
	
	for object_properties in self.objectTypes.objecttypes.objecttype:
		if object_properties.name == object_type_name:
			return object_properties.property
	pass
	
func GetObjectPropertyFor(object_properties, property_name):
	for property in object_properties:
		if property.name == property_name:
			match property.type:
				"int": return int(property.default)
				"float": return float(property.default)
				"string": return property.default
				"boolean": return bool(property.default)
	return null
	
func CreateInstance(object,name,pos):
	
	var _instance = object.instance()
	_instance.name = name
	_instance.set_position(pos + Vector2(8, -8))	
	self.root_entities.add_child(_instance)
	_instance.set_owner(self.root_entities)
	return _instance
	
func CreateEntity(obj,entity_name,prefab_name):
	
	var entity_prefab = load(prefab_name)	
	var entity_pos = obj.get_position()
	return CreateInstance(entity_prefab,entity_name+"("+obj.name+")",entity_pos)

func GetObjectProperty(obj, property_name):

	if obj.has_meta(property_name):
		return obj.get_meta(property_name)

	var obj_type = self.GetObjectTypeFor(obj.get_meta("Type"))
	return self.GetObjectPropertyFor(obj_type,property_name)
	
	pass

func Create_health(obj):

	
	var prefabName = self.GetObjectProperty(obj,"PrefabName")
	var entityName = self.GetObjectProperty(obj,"Name")
	var entity = CreateEntity(obj,entityName,prefabName)
	
	entity.item_amount = self.GetObjectProperty(obj,"Amount")
	
func Create_ammo(obj):

	pass
	
func Create_granade(obj):

	pass
	
func Create_coin(obj):

	pass