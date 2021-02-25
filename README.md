# codebook-builder
a latex container with Consolas and NotoSansCJK fonts

![docker status](https://github.com/hjackh/codebook-builder/actions/workflows/docker-publish.yml/badge.svg)

## Pull image
* Available on DockHub
```
$ docker pull hjackh/codebook-builder
```

## Usage

> change directory to your local file first

### Using the environment to do your jobs
Mount your local file to the container and run inside the container
```
$ docker run -it -v $(pwd):/storage hjackh/codebook-builder
```

### Or compiling the codebook directly
```
$ docker run --rm -v $(pwd):/storage hjackh/codebook-builder /bin/bash -c "texliveonfly codebook.tex --compiler=xelatex ; latexmk -pdfxe codebook.tex"
```
