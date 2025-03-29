#!/usr/bin/env bats

@test "vscode user exists" {
    run id vscode
    [ "$status" -eq 0 ]
}

@test "/usr/local/bin is owned by vscode" {
    run stat -c '%U' /usr/local/bin
    [ "$status" -eq 0 ]
    [ "$output" = "vscode" ]
}
