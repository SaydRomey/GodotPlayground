
# Notes - Shared gdscript code

## Symlink the `gdlib/` directory
```bash
ln -s ../../../common/gdlib gdlib
```
Inside a project (e.g., `projects/testgame/`), 
any files or subfolders we later add inside `common/gdlib/` 
will be automatically visible inside our project through that symlink.\

### Example:
If we later add `common/gdlib/states/Jump.gd`, 
then in your project we can access it as:
```gdscript
load("res://gdlib/states/Jump.gd")
```
Or reference it as a node in the scene tree under a `States` node if we add it that way.

---

## FSM (Finite State Machine)

### Register States at Runtime
In player scene's `ready()`:
```gdscript
func _ready():
	var sm = $StateMachine
	sm.add_state("walk", $States/Walk)
	sm.add_state("jump", $States/Jump)
	sm.add_state("dash", $States/Dash)
	sm.change_state("walk")
```

### Add project-specific states locally  
(Extend shared states):
```gdscript
# CustomWalk.gd in project/scripts/states/
extends "res://common/gdlib/states/Walk.gd"

func _enter():
	print("Custom behavior before walk")
	.super()._enter()
```
Then register that state instead of the original.

### Auto-Discovery Tooling
We could build a helper method that auto-registers 
all children of a States node that extend BaseState.\
But for larger projects, explicit add_state() calls are safer.

### Use Signals for Transition Triggers
Emit signals like request_state_change("jump") from our player or input handler, 
and connect them to your StateMachine.

---
