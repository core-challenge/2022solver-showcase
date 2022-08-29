# Froleyks

- [reconfaigeration-ex-container.tar.gz](https://drive.google.com/file/d/15Dc_O2ptmK2GEHxpfMQX4p3fExUOmgMd/view?usp=sharing)

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