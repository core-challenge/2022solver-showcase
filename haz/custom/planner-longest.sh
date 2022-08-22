#!/usr/bin/bash

MEMORY_LIMIT=16G
MAXCOST=0

function run_solver {
    # Should limit time to $1 seconds
    eval "timeout $1 $2"
    PLANNER1_EXIT_CODE=$?
    if [ "$PLANNER1_EXIT_CODE" -eq "0" ]
    then
        echo "Instance is solvable."
        # exit 0
    elif [ "$PLANNER1_EXIT_CODE" -eq "10" ] || [ "$PLANNER1_EXIT_CODE" -eq "11" ]
    then
        echo "Instance is unsolvable."
        exit 1
    fi
}

function update_plan_cost {
    if test -f "$1"; then
	CURCOST=$(tail -1 $1 | sed 's/[^0-9]*//g')
        echo "$1 exists with cost $CURCOST."
	MAXCOST=$(( CURCOST > MAXCOST ? CURCOST : MAXCOST ))
        echo "MAXCOST: $MAXCOST"
    fi
}

# Get just the filename for $4, not including the extension
SSOLUTION=$(basename "$4")
SSOLUTION="/SHORTEST-SOLUTIONS/${SSOLUTION%.*}"

# Count the number of lines starting with "a " in the initial solution file,
#   and subtract 1 (for "a YES"),
#   and subtract 1 (for the initial state)
#   and multiply by 2 for the pick/place actions
SSOLUTION_LINES=$(grep -c "^a " "$SSOLUTION")
SSOLUTION_COST=$(( (SSOLUTION_LINES - 2) * 2 ))
MAXCOST=$SSOLUTION_COST
echo "Starting with a MAXCOST: $MAXCOST"

# Run gbfs-hm1
run_solver 330 "python3 /SOLVER/fd/fast-downward.py --overall-memory-limit ${MEMORY_LIMIT} --overall-time-limit 300s --plan-file $1 $2 --landmarks lmg=\"lm_hm(use_orders=True, m=1)\" --evaluator \"hlm=lmcount(lmg, admissible=True, pref=false)\" --search \"eager(single(hlm),reopen_closed=False)\""

update_plan_cost $1
echo ""

# Run Symk (set correct limits)?
run_solver 4200 "python3 /SOLVER/symk/fast-downward.py --overall-memory-limit ${MEMORY_LIMIT} --plan-file $1 $2 --search \"symk-fw(plan_selection=isr_challenge(num_plans=infinity,overwrite_plans=true,plan_cost_bound=$MAXCOST),silent=true,simple=true)\""

update_plan_cost $1
echo ""

# Exit with an error if we haven't improved the cost
if [ "$MAXCOST" -eq "$SSOLUTION_COST" ]
then
    echo "No improvement found."
    exit 1
fi
