#!/usr/bin/env zsh

check_for_tests(){
    local dir="$1"
    echo "Checking for test project in $dir"

    # Look for test files
    local test_files=$(find "$dir" -maxdepth 2 -type f  \(\
        -name "*test*.csproj" -o \
        -name "*tests*.csproj" -o \
        -name "*Test*.csproj" -o \
        -name "*Tests*.csproj" -o \
        -name "*.Tests.csproj" -o \
        -name "*.Test.csproj" \
        \) 2>/dev/null)

    if [[ -n "$test_files" ]]; then
        echo "Test project found"
        echo "$test_files" | while read -r file; do
            echo " -$(basename $file)" 
        done
        return 0
    else
        echo "No test project found"
        return 1
    fi
}

try_run_test()
{
    local dir=$1

    if check_for_tests $dir; then
        cd $dir
        testFound=true

        # Should i run test with build or no build
        echo "Run test with build? press y/n"
        read -r build
        if [[ $build == 'y' ]]; then
            echo "Running test with build"
            dotnet test 2>&1
        elif [[ $build == 'n' ]]; then
            echo "Running test with no build"
            dotnet test --no-build 2>&1
        else
            echo "Invalid input"
        fi
    fi
}

main() {
    local currentDirectory=$(pwd)
    testFound=false

    # try running test on current directory
    try_run_test $currentDirectory

    # if test found exit
    if [[ $testFound == true ]]; then
        read -n1 -s
        return 0
    fi

    # try running test on parent directory
    local parentdirectory=$(dirname $currentDirectory)

    try_run_test $parentdirectory

    read -n1 -s
    return 0
}

main
