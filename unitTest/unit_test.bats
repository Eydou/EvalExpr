#!/usr/bin/env bats

bn='\n'

@test "test error no argument 1" {
    run bash -c "echo $? | ./funEvalExpr"
    [ "$status" -eq 84 ]
}

@test "test error invalid no argument 2" {
    run bash -c "echo $? | ./funEvalExpr \"\""
    [ "$status" -eq 84 ]
}

@test "test error invalid no argument 3" {
    run bash -c "echo $? | ./funEvalExpr \"()\""
    [ "$status" -eq 84 ]
}

@test "test error invalid number 1" {
    run bash -c "echo $? | ./funEvalExpr oui"
    [ "$status" -eq 84 ]
}

@test "test error invalid number 2" {
    run bash -c "echo $? | ./funEvalExpr \"1 + (2 * 4) +\""
    [ "$status" -eq 84 ]
}

@test "test error invalid number 3" {
    run bash -c "echo $? | ./funEvalExpr \"1 + 2a\""
    [ "$status" -eq 84 ]
}

@test "test error divide by 0" {
    run bash -c "echo $? | ./funEvalExpr \"1/0\""
    [ "$status" -eq 84 ]
}

@test "test error infinity numbers" {
    run bash -c "echo $? | ./funEvalExpr \"10 ^ 10 ^ 10\""
    [ "$status" -eq 84 ]
}

@test "test error blank 1" {
    run bash -c "echo $? | ./funEvalExpr \"1 20 + 5\""
    [ "$status" -eq 84 ]
}

@test "test error blank 2" {
    run bash -c "echo $? | ./funEvalExpr \"1${bn}20 + 5\""
    [ "$status" -eq 84 ]
}

@test "test error forgot parens" {
    run bash -c "echo $? | ./funEvalExpr \"1 + (20 + 5\""
    [ "$status" -eq 84 ]
}

@test "test error reverse parens" {
    run bash -c "echo $? | ./funEvalExpr \"1 + )20 + 5(\""
    [ "$status" -eq 84 ]
}

@test "test error adding too much operator1" {
    run bash -c "echo $? | ./funEvalExpr \"1 + (20 ++ 5)\""
    [ "$status" -eq 84 ]
}

@test "test error adding too much operator2" {
    run bash -c "echo $? | ./funEvalExpr \"1 + (20 + 5) +\""
    [ "$status" -eq 84 ]
}

@test "---------------------------------- ✓" {
    run bash -c "echo | ./funEvalExpr \"1 + 2\""
    [ "$output" = "3.00" ]
}

@test "test basic addition" {
    run bash -c "echo | ./funEvalExpr \"1 + 2\""
    [ "$output" = "3.00" ]
}

@test "test intermediate addition" {
    run bash -c "echo | ./funEvalExpr \"1 + 2 + (2 + 4 + 5) + 10\""
    [ "$output" = "24.00" ]
}

@test "test advanced addition" {
    run bash -c "echo | ./funEvalExpr \"1 + 2 + (2 + 4 + ((5 + 3 + (20 + 34)))) + (10 + 1)\""
    [ "$output" = "82.00" ]
}

@test "test basic substraction" {
    run bash -c "echo | ./funEvalExpr \"1 - 2\""
    [ "$output" = "-1.00" ]
}

@test "test intermediate substraction" {
    run bash -c "echo | ./funEvalExpr \"1 - 2 - (2 - 4 - 5) - 10\""
    [ "$output" = "-4.00" ]
}

@test "test advanced substraction" {
    run bash -c "echo | ./funEvalExpr \"1 - 2 - (2 + 4 - ((5 - 3 - (20 + 34)))) - (10 - 1)\""
    [ "$output" = "-68.00" ]
}

@test "test basic multiplication" {
    run bash -c "echo | ./funEvalExpr \"1 + 2 * 4\""
    [ "$output" = "9.00" ]
}

@test "test intermediate multiplication" {
    run bash -c "echo | ./funEvalExpr \"1 + 2 * 4 * (5 - 3 - 4) - 3 * 6\""
    [ "$output" = "-33.00" ]
}

@test "test advanced multiplication + mixed" {
    run bash -c "echo | ./funEvalExpr \"6 * 12 / 2 * (1 - 2 - (2 - 4 - 5) - 10) ^ 2 * (2 - 7 - 4) ^ 3\""
    [ "$output" = "-419904.00" ]
}