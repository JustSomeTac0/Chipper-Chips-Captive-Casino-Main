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

func _ready():
	var m = MeshInstance3D.new()
	m.mesh = SphereMesh.new()

	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color.RED

	m.material_override = mat
	m.scale = Vector3.ONE * 0.25

	add_child(m)

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
