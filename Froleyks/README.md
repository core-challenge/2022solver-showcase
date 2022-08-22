# Froleyks

## Import
```bash
cat reconfaigeration-ex-container.tar.gz | gzip -d | docker import - froleyks-solver:latest
```

## Run
```bash
docker run -it --name=froleyks-solver-container froleyks-solver /bin/bash
```

## Example
```bash
/2022solver/run.sh /2022solver/example/hc-toyno-01.col /2022solver/example/hc-toyno-01_01.dat
```