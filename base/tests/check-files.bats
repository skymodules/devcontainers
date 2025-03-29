#!/usr/bin/env bats

@test "install.sh is executable and exists" {
    run test -x /home/vscode/install.sh
    [ "$status" -eq 0 ]
}

@test "install-hashicorp.sh is executable and exists" {
    run test -x /home/vscode/install-hashicorp.sh
    [ "$status" -eq 0 ]
}

@test "shell.sh is executable and exists" {
    run test -x /home/vscode/shell.sh
    [ "$status" -eq 0 ]
}
