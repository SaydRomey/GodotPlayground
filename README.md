# GodotPlayground

## Setup

Run this once after cloning:

```bash
cd projects/testgame
ln -s ../../../common/gdlib gdlib
ln -s ../../../common/cpp/mynative/libmynative.so native/libmynative.so
```

## File Strucure

```
.
├── common
│   ├── cpp
│   │   └── godot-cpp/ (submodule)
│   │   └── mynative
│   │       ├── godot_includes.hpp
│   │       ├── libmynative.so
│   │       ├── MyNativeThing.cpp
│   │       ├── MyNativeThing.hpp
│   │       ├── register_types.cpp
│   │       ├── .sconsign.dblite
│   │       └── SConstruct
│   └── gdlib
│       ├── BaseState.gd
│       └── StateMachine.gd
├── .env
├── .gitattributes
├── .gitignore
├── .gitmodules
├── LICENSE
├── Makefile
├── projects
│   ├── testgame
│   │   ├── gdlib -> ../../common/gdlib
│   │   ├── native
│   │   │   ├── libmynative.so -> ../../../common/cpp/mynative/libmynative.so
│   │   │   └── mynative.gdextension
│   │   ├── project.godot
│   │   ├── scenes
│   │   │   └── main.tscn
│   │   └── scripts
│   │       ├── main.gd
│   │       └── MyAI.gd
│   └── todelete
│       ├── gdlib -> ../../common/gdlib
│       ├── project.godot
│       ├── scenes
│       └── scripts
├── README.md
└── utils
    ├── makefiles
    │   ├── class.mk
    │   ├── cpp.mk
    │   ├── dependencies.mk
    │   ├── doc.mk
    │   ├── env.mk
    │   ├── godot.mk
    │   ├── misc.mk
    │   ├── scripts.mk
    │   └── utils.mk
    ├── scripts
    │   ├── ansi_colors.sh
    │   ├── gd-cpp-new-module.sh
    │   ├── gd-delete-project.sh
    │   ├── gd-new-project.sh
    │   ├── gd-run-project.sh
    │   ├── generate-env.sh
    │   ├── _generate-gdextension-template.sh
    │   └── show_colors.sh
    ├── templates
    │   └── .env.template
    └── wav
        ├── push.wav
        └── welcome.wav

```


