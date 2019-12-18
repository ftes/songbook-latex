#!/bin/sh

SCRIPTS_DIR="`dirname $0`"

$SCRIPTS_DIR/internal/generate-chordsheet-page.py ./src/pdf/chords/chords-1.tex maj,sus2,sus4,6,7,7sus4
$SCRIPTS_DIR/internal/generate-chordsheet-page.py ./src/pdf/chords/chords-2.tex 9,m,m6,m7,m9
