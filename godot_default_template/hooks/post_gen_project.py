import os
import subprocess

# Function to run shell commands
def run_command(command, check=True):
    print(f"Running: {command}")
    result = subprocess.run(command, shell=True, check=check, capture_output=True, text=True)
    if result.stdout:
        print(result.stdout.strip())
    if result.stderr:
        print(result.stderr.strip())

# Function to add git submodule
def add_submodule(submodule_repo, submodule_path):
	run_command(f"git submodule add {submodule_repo} {submodule_path}")
	run_command("git submodule update --init --recursive")
	
# Function to add a symlink from the addons folder to the submodule
def add_simlink(symlink_target, symlink_name):
	if not os.path.exists(symlink_name):
		# manual command: ln -s ../externa/path/to/addon/folder addon_name
		os.symlink(symlink_target, symlink_name)
		print("Symlink created successfully")
	else:
		print("Symlink already exists")

	print("Submodule added and symlinks created")

def add_addon(addon_repo, addon_external_name, addon_locale_name):
	add_submodule(addon_repo, "external/" + addon_external_name)
	add_simlink(os.path.join("..", "external", addon_external_name, "addons", addon_locale_name), os.path.join("addons", addon_locale_name))


# Step 1: Initialize the Git repository
run_command("git init")
print("Repository initialized")

# Step 2: Create the master branch
run_command("git checkout -b master")
print("Checked out master branch")

# Step 3: Add add ons
add_addon("https://github.com/winkensjw/godot-console.git", "godot-console", "console")
add_addon("https://github.com/winkensjw/resonate.git", "resonate", "resonate")

# Step 5: Add all files to the repository
run_command("git add .")

# Step 6: Commit all files
run_command("git commit -m \"Initial commit\"")
print("Added initial commit")

print("Setup finished!")