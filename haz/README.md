# Solver Entry Details

## Build Archives

You can find `shortest-build.zip` and `longest-build.zip` online [[here](https://queensuca-my.sharepoint.com/:f:/g/personal/cm290_queensu_ca/EmU48ECd0DtJhXRj87uTOpkBmkcTUupMsWJU6rr4qj-EUg?e=rfqY1C)]. These contain the necessary files to compile the submission Docker. The one caveat is that the portfolio approach for the shortest-track will further require ILOG CPLEX to be installed and located appropriately on the host machine. Due to licence restrictions, the ILOG CPLEX license is not included in the build archives.

## Shortest / Existent

Both the shortest and existent tracks are considered the same -- we report the best solution found for as many problems as possible.

### Solutions

You can find all of the existing solutions in the shorest-solutions directory. Those solved will have "a YES" or "a NO" in the file, and those we could not solved will have "c UNKNOWN" in the file.

The single-shortest-solutions directory contains solutions found using the single best solver available. All other solutions are considered portfolio approaches.

### Building

While developing (and when this repo is nested within the broader repository), building can be done via...

```bash
cd custom
./build.sh shortest
cd ..
docker build -t core-submission .
```

Alternatively (assuming you don't have access to the broader repository of all techniques explored), you can build via the following (see above for fetching the build archive):

```bash
cd custom
unzip shortest-build.zip
cd ..
docker build -t core-submission .
```

### Running

```bash
# Enter the docker image with a virtual directory for the solutions
docker run -it -v <path to this repository>/solver/shortest-solutions/:/SOLUTIONS core-submission

# Setup the problems (prune will remove all those already solved)
python3 utils.py setup
python3 utils.py prune

# Run as many threads as reasonable on the machine
python3 utils.py test &

# Check on the progress
echo && echo " Remaining: $(ls -l tosolve/ | wc -l)" && echo "    Solved: $(ls -l /SOLUTIONS/ | wc -l)" && echo
```

## Longest

Our general strategy is to run a quick solver, then a tailored approach that iteratively finds longer plans. Failing both, we just accept the plan found from the shortest track.


### Solutions

You can find all of the existing solutions in the longest-solutions directory. Those solved will have "a YES" or "a NO" in the file, and those we could not solved will have "c UNKNOWN" in the file.

The single-longest-solutions directory contains solutions found using the single best solver available. All other solutions are considered portfolio approaches.

### Building

While developing (and when this repo is nested within the broader repository), building can be done via...

```bash
# Build the solvers we need
cd custom
./build.sh longest

# Build the docker image
cd ..
docker build -t core-submission .
```

Alternatively (assuming you don't have access to the broader repository of all techniques explored), you can build via the following (see above for fetching the build archive):

```bash
cd custom
unzip longest-build.zip
cd ..
docker build -t core-submission .
```

### Running

```bash
# Enter the docker image, and bring along all the solved problems from the shortest track
docker run -it -v <path to this repository>/solver/shortest-solutions/:/SHORTEST-SOLUTIONS -v <path to this repository>/solver/longest-solutions/:/SOLUTIONS core-submission

# Setup the problems (first fetches all the problems and second prunes to just those already solved)
python3 utils.py setup
python3 utils.py longest

# Run as many threads as reasonable on the machine
python3 utils.py test &

# Check on the progress
echo && echo " Remaining: $(ls -l tosolve/ | wc -l)" && echo "    Solved: $(ls -l /SOLUTIONS/ | wc -l)" && echo

# Copy over all solutions that we weren't able to improve
python3 utils.py clone-shortest
```
