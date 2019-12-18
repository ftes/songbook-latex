#!/bin/bash
# ./scripts/watch.sh [<type>] [<songs-directory>]

TYPE=${1:-chordbook}
SCRIPTS_DIR="`dirname $0`"
SONGS_DIR=${2:-src/songs}

inotifywait --event modify -rm "$SONGS_DIR" |
while read events; do
  $SCRIPTS_DIR/generate-songlist.sh "$SONGS_DIR"
  $SCRIPTS_DIR/make.sh $TYPE "$SONGS_DIR"
done
