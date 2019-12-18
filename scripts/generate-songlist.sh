#!/bin/sh
# ./scripts/generate-songlist.sh [<songs-directory>]

SONGS_DIR=${1:-$PWD/src/songs}
INDEX_FILE=$PWD/src/pdf/other/common-songs.tex

cd $SONGS_DIR
rm -f $INDEX_FILE


for song in `ls **/*.tex | LC_COLLATE=C sort`
do
  echo "\input{/songs/$song}" >> $INDEX_FILE
done
