#!/bin/bash
# Interactive data engineering tool selector

DATA_TOOLS_SELECTION_FILE="$HOME/.config/dotfiles/data-tools.conf"

# Tool definitions: "package_name:display_name:install_method"
DATA_TOOLS=(
    "azure-cli:Azure CLI (az):yay"
    "databricks-cli:Databricks CLI:pip"
    "snowflake-cli-labs:Snowflake CLI (snow):pip"
    "sqlfluff:SQLFluff (SQL linter/formatter):pip"
    "dbt-core:dbt Core:pip"
    "azure-identity:Azure Identity SDK (for Fabric):pip"
)

select_data_tools() {
    echo "======================================"
    echo "  Data Engineering Tools"
    echo "======================================"

    mkdir -p "$(dirname "$DATA_TOOLS_SELECTION_FILE")"

    # Check for previous selection
    if [[ -f "$DATA_TOOLS_SELECTION_FILE" ]]; then
        echo ""
        echo "  Previous selection found:"
        while IFS= read -r line; do
            echo "    - $line"
        done < "$DATA_TOOLS_SELECTION_FILE"
        echo ""
        read -p "  Re-use previous selection? [Y/n] " reuse
        if [[ "$reuse" != "n" && "$reuse" != "N" ]]; then
            install_selected_data_tools
            return
        fi
    fi

    # Present menu
    echo ""
    echo "  Available tools:"
    echo ""

    local -a tool_keys=()
    local -a tool_names=()
    local -a tool_methods=()

    for i in "${!DATA_TOOLS[@]}"; do
        IFS=':' read -r key name method <<< "${DATA_TOOLS[$i]}"
        tool_keys+=("$key")
        tool_names+=("$name")
        tool_methods+=("$method")
        echo "    $((i+1)). $name ($key) [$method]"
    done

    echo ""
    echo "  Enter numbers separated by spaces, 'all', or 'none':"
    read -p "  > " choices

    local -a selections=()

    if [[ "$choices" == "all" ]]; then
        selections=("${tool_keys[@]}")
    elif [[ "$choices" != "none" && -n "$choices" ]]; then
        for num in $choices; do
            local idx=$((num - 1))
            if [[ $idx -ge 0 && $idx -lt ${#tool_keys[@]} ]]; then
                selections+=("${tool_keys[$idx]}")
            fi
        done
    fi

    if [[ ${#selections[@]} -eq 0 ]]; then
        echo "  No tools selected."
        echo "" > "$DATA_TOOLS_SELECTION_FILE"
        return 0
    fi

    # Save selection
    printf "%s\n" "${selections[@]}" > "$DATA_TOOLS_SELECTION_FILE"
    echo ""
    echo "  Selection saved to $DATA_TOOLS_SELECTION_FILE"

    install_selected_data_tools
}

install_selected_data_tools() {
    echo ""
    echo "  Installing selected data tools..."

    while IFS= read -r tool; do
        [[ -z "$tool" ]] && continue

        # Find the install method for this tool
        local method="unknown"
        for entry in "${DATA_TOOLS[@]}"; do
            IFS=':' read -r key name m <<< "$entry"
            if [[ "$key" == "$tool" ]]; then
                method="$m"
                break
            fi
        done

        case "$method" in
            yay)
                install_packages "$tool"
                ;;
            pip)
                pip_install "$tool"
                ;;
            *)
                echo "  - unknown install method for $tool"
                ;;
        esac
    done < "$DATA_TOOLS_SELECTION_FILE"

    echo "  Data tools installation complete."
}
