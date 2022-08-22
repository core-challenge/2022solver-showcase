# toda5603

## Import
```bash
cat bmcsolver-container.tar.gz | gzip -d | docker import - toda5603-solver:latest
```

## Run
```bash
docker run -it --name=toda5603-solver-container -w /2022solver toda5603-solver /bin/bash
```

## Example
```bash
/2022solver/run.sh /2022solver/example/hc-toyno-01.col /2022solver/example/hc-toyno-01_01.dat
```
