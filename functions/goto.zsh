# --- Custom goto alias and completion ---

# Define the base directory for your projects
# *************************************************************************
# IMPORTANT: REPLACE THIS PATH with the actual, absolute path to your
# directory containing all your project folders (e.g., /Users/yourusername/my_repos)
# *************************************************************************
PROJECTS_DIR="$HOME/projects" # <-- CHANGE THIS LINE!

# Define the goto function
goto() {
    if [ -z "$1" ]; then
        echo "Usage: goto <project_name>"
        echo "Available projects in $PROJECTS_DIR:"
        if [ -d "$PROJECTS_DIR" ]; then
            ls -1 "$PROJECTS_DIR" | while read -r dir; do
                if [ -d "$PROJECTS_DIR/$dir" ]; then
                    echo "  - $dir"
                fi
            done
        else
            echo "Error: PROJECTS_DIR '$PROJECTS_DIR' does not exist."
        fi
        return 1
    fi

    local target_dir="$PROJECTS_DIR/$1"

    if [ -d "$target_dir" ]; then
        cd "$target_dir"
        echo "Navigated to: $(pwd)"
    else
        echo "Error: Project '$1' not found in '$PROJECTS_DIR'."
        echo "Available projects:"
        if [ -d "$PROJECTS_DIR" ]; then
            ls -1 "$PROJECTS_DIR" | while read -r dir; do
                if [ -d "$PROJECTS_DIR/$dir" ]; then
                    echo "  - $dir"
                fi
            done
        else
            echo "Error: PROJECTS_DIR '$PROJECTS_DIR' does not exist."
        fi
        return 1
    fi
}

# Zsh completion for the goto function
_goto_completion() {
    local -a projects

    if [ -d "$PROJECTS_DIR" ]; then
        projects=( "${PROJECTS_DIR}"/*(/Nom) )
        projects=( "${projects[@]##*/}" )
    else
        projects=()
    fi

    _describe 'projects' projects
}

# Register the completion function for the goto command
compdef _goto_completion goto

# --- End of custom goto alias and completion ---with

