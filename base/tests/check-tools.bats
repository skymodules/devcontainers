#!/usr/bin/env bats

@test "vault is installed and available" {
    run vault --version
    [ "$status" -eq 0 ]
}

@test "terraform is installed and available" {
    run terraform --version
    [ "$status" -eq 0 ]
}

@test "trunk is installed and available" {
    run trunk --version
    [ "$status" -eq 0 ]
}

@test "doppler is installed for node user" {
    run su node -c "doppler --version"
    [ "$status" -eq 0 ]
}

@test "dotenvx is installed for node user" {
    run su node -c "dotenvx --version"
    [ "$status" -eq 0 ]
}
