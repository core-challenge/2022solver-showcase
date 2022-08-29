# junkawahara

- [zdd-solver-container.tar.gz](https://drive.google.com/file/d/15GM0AuSf-5QNG-HCig3PSFL70k9mV8uG/view?usp=sharing)

## Import
```bash
cat zdd-solver-container.tar.gz | gzip -d | docker import - junkawahara-solver:latest
```

## Run
```bash
docker run -it --name=junkawahara-solver-container -w /2022solver junkawahara-solver /bin/bash
```

## Example
```bash
/2022solver/run.sh example/hc-toyno-01.col example/hc-toyno-01_01.dat
```