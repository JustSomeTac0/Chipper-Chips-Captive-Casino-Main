class_name Waypoint
extends Marker3D

@export var connected_nodes: Array[Waypoint] = []

@onready var mesh_instance = $MeshInstance3D

enum NodeType{
	NORMAL,
	SIDE_ROOM,
	VENT,
	TRAP_SETTING_SPOT
}
@export var node_type: NodeType = NodeType.NORMAL

func _process(delta):
	draw_connections()

func draw_connections():
	var mesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)

	for node in connected_nodes:
		mesh.surface_add_vertex(Vector3.ZERO)
		mesh.surface_add_vertex(to_local(node.global_transform.origin))

	mesh.surface_end()

	mesh_instance.mesh = mesh
