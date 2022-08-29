# tigrisg

- [dockerarchive.tar.gz](https://drive.google.com/file/d/1FVKvckFvuUXsiCKDw1PQDID-zU8hr6pw/view?usp=sharing)

## Import
```bash
cat dockerarchive.tar.gz | gzip -d | docker import - tigrisg-solver:latest
```

## Run
```bash
docker run -it --name=tigrisg-solver-container tigrisg-solver /bin/bash
```

## Example
```bash
/2022solver/run.sh /2022solver/example/hc-toyno-01.col /2022solver/example/hc-toyno-01_01.dat
```

You can see output files in `/2022solver/output` directory.