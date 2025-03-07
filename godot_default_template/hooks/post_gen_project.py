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
		os.symlink(symlink_target, symlink_name)
		print("Symlink created successfully")
	else:
		print("Symlink already exists")

	print("Submodule added and symlinks created")

# Step 1: Initialize the Git repository
run_command("git init")
print("Repository initialized")

# Step 2: Create the master branch
run_command("git checkout -b master")
print("Checked out master branch")

# Step 3: Add the existing submodule
add_submodule("https://github.com/winkensjw/godot-console.git", "external/godot-console")

# Step 4: Create a symlink
add_simlink(os.path.join("..", "external", "godot-console", "addons", "console"), os.path.join("addons", "console"))

# Step 5: Add all files to the repository
run_command("git add .")

# Step 6: Commit all files
run_command("git commit -m \"Initial commit\"")
print("Added initial commit")

print("Setup finished!")