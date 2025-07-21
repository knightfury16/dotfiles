#!/usr/bin/env zsh

# Script to check for and build .NET projects in current directory

# Get current working directory
current_dir=$(pwd)

echo "Checking for .NET projects in: $current_dir"
echo

# Check if we have .NET project files
if find "$current_dir" -maxdepth 1 -type f \( -name "*.csproj" -o -name "*.fsproj" -o -name "*.vbproj" -o -name "*.sln" \) | grep -q .; then
    echo "✅ .NET project found!"
    
    # List the found project files
    echo "Found project files:"
    find "$current_dir" -maxdepth 1 -type f \( -name "*.csproj" -o -name "*.fsproj" -o -name "*.vbproj" -o -name "*.sln" \) -exec basename {} \;
    echo
    
    echo "🔨 Building .NET project..."
    echo "----------------------------------------"
    
    # Run dotnet build and capture exit code
    if dotnet build; then
        echo "----------------------------------------"
        echo "✅ Build completed successfully!"
    else
        echo "----------------------------------------"
        echo "❌ Build failed!"
    fi
else
    echo "❌ No .NET project found in current directory."
    echo "Looked for: *.csproj, *.fsproj, *.vbproj, *.sln files"
    echo
    echo "Make sure you're in a directory containing a .NET project."
fi

# If running interactively (not in a script), wait for user input
if [[ -t 0 && -t 1 ]]; then
    echo
    echo "Press any key to continue..."
    read -n1 -s
fi
