#!/usr/bin/bash

MEMORY_LIMIT=16G

function run_solver {

    echo "c Running for $1 seconds: $2"

    # Should limit time to $1 seconds
    eval "timeout $1 $2"
    PLANNER1_EXIT_CODE=$?
    if [ "$PLANNER1_EXIT_CODE" -eq "0" ]
    then
        echo "Instance is solvable"
        exit 0
    elif [ "$PLANNER1_EXIT_CODE" -eq "10" ] || [ "$PLANNER1_EXIT_CODE" -eq "11" ] || [ "$PLANNER1_EXIT_CODE" -eq "12" ]
    then
        echo "Instance is unsolvable"
        exit 10
    fi
}

run_solver 10 "python3 /SOLVER/mip/check-unsolvability.py $3 $4"

run_solver 4200 "python3 /SOLVER/symk/fast-downward.py --overall-memory-limit ${MEMORY_LIMIT} --plan-file $1 $2 --search \"sym-fw()\""

# A* with uniform cost partitioning over h^1 and RHW landmarks.
run_solver 4200 "python3 /SOLVER/fd/fast-downward.py --overall-memory-limit ${MEMORY_LIMIT} --plan-file $1 $2 --landmarks \"lmg=lm_merged([lm_rhw(use_orders=true), lm_hm(use_orders=true, m=1)])\" --evaluator \"hlm=lmcount(lmg, admissible=true, pref=false, cost_partitioning=suboptimal, greedy=false, reuse_costs=false)\" --search \"astar(hlm)\""

# GBFS with uniform cost partitioning over h^1 landmarks.

run_solver 4200 "python3 /SOLVER/fd/fast-downward.py --overall-memory-limit ${MEMORY_LIMIT} --plan-file $1 $2 --landmarks lmg=\"lm_hm(use_orders=False, m=1)\" --evaluator \"hlm=lmcount(lmg, admissible=True, pref=false)\" --search \"eager(single(hlm),reopen_closed=False)\""

run_solver 50000 "python3 /SOLVER/mip/check-unsolvability.py $3 $4"

