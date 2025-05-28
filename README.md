# GodotPlayground

> 🚧 **Work in Progress**  
> Experimental Godot 4.x playground featuring native C++ GDExtension integration, 
reusable GD scripts, and dev automation tools.

---

## The idea

Basically i wanted to learn how to use `C++` with `Godot`, 
and gradually build a library of `gdscript` functions i keep rewriting in different projects 
so it could be used by simply including the library.  
And while i'm at it, why not try to automate it all...\
So when this works properly, we should have some makefile commands to:
- Start a new Godot project
- Build a new `CPP` module
- Add some functions to the `gdlib`
- Link and sync everything up

I'll be playing with scripts through makefiles, bash scripts and some templates with good ol' `sed`...\
Let's see how this goes :)


## Setup

> [!NOTE]
> Most of this will be handled automatically with `makefile` targets...\
> Like `make dep` or something, to check and install dependencies and submodules

### 1. Clone with submodules

```bash
git clone --recurse-submodules https://github.com/SaydRomey/GodotPlayground
```

> Already cloned ?  
> Run this to initialize submodules:

```bash
git submodule update --init --recursive
```

### 2. Project-specific symlinks

Run this once after cloning:

```bash
cd projects/testgame
ln -s ../../../common/gdlib gdlib
ln -s ../../../common/cpp/mynative/libmynative.so native/libmynative.so
```

---

## 🧩 Features (WIP)

- 🧠 Shared GD script modules (via symlinked `gdlib`)

- ⚙️ Native C++ module (`MyNativeThing`) via GDExtension

- 🛠️ Custom SCons + Makefile support for automation

- 🎮 Modular project layout with reuse-friendly structure

- 🎧 Optional dev audio cues (`utils/wav`)

---

## 🌲 File Strucure Overview

```
.
├── common
│   ├── cpp
│   │   ├── godot-cpp/               # Submodule: Godot C++ bindings
│   │   └── mynative/                # Native extension module
│   └── gdlib/                       # Shared GDScript modules
├── projects/
│   ├── testgame/                    # Example Godot project
│   │   ├── gdlib -> ../../common/gdlib
│   │   └── native/
│   │       └── libmynative.so -> ../../../common/cpp/mynative/libmynative.so
├── utils/
│   ├── makefiles/                   # Modular Make targets
│   ├── scripts/                     # CLI helpers (project, build, run)
│   ├── templates/                   # .env template
│   └── wav/                         # Dev SFX
├── Makefile                         # Main entrypoint
├── .env                             # Local env (git-ignored)
├── .gitmodules                      # Tracks godot-cpp
├── .gitignore
└── README.md
```

---

## 🧰 Make Targets

> Run with `make <target>` (or `make help` to list available targets)

### 🛠️ Utility

| Target | Description                    |
|--------|--------------------------------|
| `help` | Display available targets      |
| `repo` | Open the GitHub repository     |

### 🎯 Main Targets

| Target | Description                         |
|--------|-------------------------------------|
| `new`  | Runs `gd-run` (requires `.env`)     |
| `run`  | Launch selected Godot project       |

### 📚 Documentation

| Target | Description                 |
|--------|-----------------------------|
| `doc`  | Show documentation links    |


### `.env` Automation

| Target       | Description                                             |
|--------------|---------------------------------------------------------|
| `env`        | Generate `.env` (uses `env.mk` variables)               |
| `env-create` | Generate `.env` (with prompt to overwrite)              |
| `env-script` | Generate `.env` via `generate-env.sh`                   |
| `env-copy`   | Generate `.env` using `.env.template`                   |
| `env-clean`  | Remove `.env` files                                     |
| `env-reset`  | Overwrite `.env`                                        |

### 🤖 Class Creator

| Target  | Description                      |
|---------|----------------------------------|
| `class` | Prompt-assisted class creation   |


### 📜 Scripts

| Target         | Description                             |
|----------------|-----------------------------------------|
| `script`       | Interactive script selection menu       |
| `script-clean` | Clean test artifacts and logs           |


### 🎮 Godot

| Target     | Description                     |
|------------|---------------------------------|
| `gd-new`   | Create a new Godot project      |
| `gd-delete`| Delete a Godot project          |
| `gd-run`   | Launch a Godot project          |


### 👾 Godot-CPP

| Target        | Description                              |
|---------------|------------------------------------------|
| `cpp-bindings`| Build godot-cpp bindings                 |
| `cpp-build`   | Build all native C++ modules             |
| `cpp-clean`   | Clean all compiled C++ modules           |
| `cpp-re`      | Clean and rebuild                        |

### 🌳 File Structure

> Modify the `TREE_IGNORES` makefile variable in `utils/makefiles/tree.mk`  
> To specify what to omit from the `tree` command  

| Target       | Description                                    |
|--------------|------------------------------------------------|
| `tree`       | Show file structure (respects ignore config)   |
| `tree-log`   | Log structure to `tmp_tree.txt`                |
| `tree-clean` | Delete tree output file                        |

### 💾 Backup

| Target | Description                          |
|--------|--------------------------------------|
| `backup`| Prompted `.zip`/`.tar.gz` backup    |

### 🔈 Sound

| Target    | Description               |
|-----------|---------------------------|
| `pushit`  | Push it to the limit 🎵   |
| `welcome` | "What can I say" 🎶       |

<!--
Target	Description
`godot`	Launches Godot Editor for `testgame`
`cpp`	Builds native C++ module via `scons`
`gd-new`	Creates new Godot project (helper script)
`cpp-new`	Creates new C++ module (boilerplate)


---

## 🧪 Dev Scripts

-->

---

## 🔍 Notes

- The Godot version must match the `godot-cpp` submodule version.

- `libmynative.so` is symlinked into each project under `native/`.

- Reusable GDScripts (`gdlib/`) are symlinked too.

---
