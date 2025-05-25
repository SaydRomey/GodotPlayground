# StateMachine.gd

extends Node

class_name StateMachine

var states = {}
var current_state = null

func _ready():
	if current_state and states.has(current_state):
		states[current_state]._enter()

func add_state(name: String, state_node: Node):
	states[name] = state_node
	state_node.state_machine = self

func change_state(new_state: String):
	if current_state and states.has(current_state):
		states[current_state]._exit()

	current_state = new_state

	if states.has(current_state):
		states[current_state]._enter()

func _process(delta):
	if current_state and states.has(current_state):
		states[current_state]._process(delta)

# func _ready():
# 	for child in get_children():
# 		if child is BaseState:
# 			states[child.name] = child
# 			child.state_machine = self
# 			child._on_enter()

# func change_state(state_name):
# 	if current_state:
# 		current_state._on_exit()
# 	current_state = states.get(state_name, null)
# 	if current_state:
# 		current_state._on_enter()

# func _process(delta):
# 	if current_state:
# 		current_state._on_update(delta)
