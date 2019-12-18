#!/bin/bash
# ./scripts/make.sh [<type>] [<songs-directory>]
# <type>: `chordbook` (default) or `lyricbook`

TYPE=${1:-chordbook}
SONGS_DIR=${2:-$PWD/src/songs}
IMAGE=blang/latex:ctanbasic
LATEX="pdflatex --output-directory=/output"
LUATEX="luatex scripts/index-songs.lua"
CMD="$LATEX books/$TYPE.tex && \
    $LUATEX /output/$TYPE.title.sxd /output/$TYPE.title.sbx && \
    $LUATEX /output/$TYPE.author.sxd /output/$TYPE.author.sbx && \
    $LATEX books/$TYPE.tex"

docker run -v $PWD/src/pdf:/data -v "$SONGS_DIR":/songs -v $PWD/output:/output $IMAGE /bin/bash -c "$CMD"
