# codebook-builder
a latex container with Consolas and NotoSansCJK fonts

## Usage

> change directory to your local file first

### Using the environment to do your jobs
Mount your local file to the container and run inside the container
```
$ docker run -it -v $(pwd):/storage codebook-builder
```

### Or compiling the codebook directly
```
$ docker run --rm -v $(pwd):/storage codebook-builder /bin/bash -c "texliveonfly codebook.tex --compiler=xelatex ; latexmk -pdfxe codebook.tex"
```