# YuyaYamada-N

- [2022solver_existent-container.tar.gz](https://drive.google.com/file/d/1Lw7bwGOlxvQkv-_ybKJKgEbmj3wtBS-S/view?usp=sharing)
- [2022solver_shortest.tar.gz](https://drive.google.com/file/d/1nNZO2nQ3N1FNDrLxkoiWTPcAMZVUzrIg/view?usp=sharing)
- [2022solver_longest.tar.gz](https://drive.google.com/file/d/19jlSYX5ltf5PQx4Zv9OXIJJw13wOAmZS/view?usp=sharing)

## Import
```bash
cat 2022solver_existent-container.tar.gz | gzip -d | docker import - yuya-yamada-n-existent-solver:latest
cat 2022solver_shortest.tar.gz | gzip -d | docker import - yuya-yamada-n-shortest-solver:latest
cat 2022solver_longest.tar.gz | gzip -d | docker import - yuya-yamada-n-longest-solver:latest
```

## Run
```bash
docker run -it --name=yuya-yamada-n-existent-solver-container yuya-yamada-n-existent-solver /bin/bash
docker run -it --name=yuya-yamada-n-shortest-solver-container yuya-yamada-n-shortest-solver /bin/bash
docker run -it --name=yuya-yamada-n-longest-solver-container yuya-yamada-n-longest-solver /bin/bash
```

## Example
```bash
chmod +x /2022solver/run.sh
/2022solver/run.sh /2022solver/example/hc-toyno-01.col /2022solver/example/hc-toyno-01_01.dat
```