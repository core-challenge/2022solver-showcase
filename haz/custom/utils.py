
import glob, os, random, sys

USAGE = """
\n\tUsage: python3 utils.py [setup|test|prune|longest|clone-shortest]

    setup: setup the environment for running all the evals again
    test: run all the evals
    prune: remove all the evals that have been solved
    longest: will keep only those to solve that have solutions in the "/SHORTEST-SOLUTIONS" folder
    clone: clones the shortest solutions to the longest folder for those unsolved
"""

def setup():
    with open('/BENCHMARKS/list/list-all-benchmark.csv', 'r') as f:
        lines = f.readlines()
    slugs = [line.strip().replace(',', 'COMMA').replace('/', 'SLASH') for line in lines]
    if not os.path.isdir('tosolve'):
        os.mkdir('tosolve')
    for slug in slugs:
        os.system(f'touch tosolve/{slug}')

def test():
    while True:
        problems = glob.glob('tosolve/*')
        if len(problems) == 0:
            print(f'\n\tAll done!')
            return
        problem = random.choice(problems)
        os.system(f'rm {problem}')

        problem = problem.replace('tosolve/', '')
        problem = problem.replace('SLASH', '/')
        col, dat = problem.split('COMMA')

        col = '/BENCHMARKS/' + col
        dat = '/BENCHMARKS/' + dat
        prob = dat.split('/')[-1].split('.')[0]

        os.system(f'./run.sh {col} {dat} > /SOLUTIONS/{prob} 2>&1')

def prune():
    probs = glob.glob('tosolve/*')
    for prob in probs:
        _, dat = prob.replace('tosolve/', '').replace('SLASH', '/').split('COMMA')
        pfile = '/SOLUTIONS/' + dat.split("/")[-1].split(".")[0]
        if os.path.isfile(pfile):
            with open(pfile, 'r') as f:
                sol_text = f.read()
                if 'a YES' in sol_text or 'a NO' in sol_text:
                    os.system(f'rm {prob}')

def longest():
    probs = glob.glob('tosolve/*')
    for prob in probs:
        _, dat = prob.replace('tosolve/', '').replace('SLASH', '/').split('COMMA')
        pfile = '/SHORTEST-SOLUTIONS/' + dat.split("/")[-1].split(".")[0]
        if os.path.isfile(pfile):
            with open(pfile, 'r') as f:
                sol_text = f.read()
                if 'a YES' not in sol_text:
                    os.system(f'rm {prob}')

def cloneshortest():
    solutions = glob.glob('/SOLUTIONS/*')
    unsolved = []
    for sol in solutions:
        # Check if "c UNKNOWN" in the solution
        with open(sol, 'r') as f:
            sol_text = f.read()
            if 'c UNKNOWN' in sol_text:
                unsolved.append(sol)
    for sol in sorted(unsolved):
        df = sol.split('/')[-1]
        cmd = f'cp /SHORTEST-SOLUTIONS/{df} /SOLUTIONS/{df}'
        os.system(cmd)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(USAGE)
        sys.exit(1)
    elif sys.argv[1] == 'setup':
        setup()
    elif sys.argv[1] == 'test':
        test()
    elif sys.argv[1] == 'prune':
        prune()
    elif sys.argv[1] == 'longest':
        longest()
    elif sys.argv[1] == 'clone-shortest':
        cloneshortest()
    else:
        print(USAGE)
        sys.exit(1)
