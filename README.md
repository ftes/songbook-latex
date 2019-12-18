[![Build Status](https://travis-ci.com/ftes/songbook-latex.svg?branch=master)](https://travis-ci.com/ftes/songbook-latex)

# DPSG Elsen Songbook
Songbook of the Scout (Pfadfinder) group DPSG Elsen.

## Getting started
- `$ scripts/make.sh chordbook && xdg-open output/chordbook.pdf`
- `$ scripts/make.sh lyricbook && xdg-open output/lyricbook.pdf`

## Using a different songs directory (your own songs)
- `$ scripts/generate-songlist.sh <your-song-directory>`
- `$ scripts/make.sh chordbook <your-song-directory>`

## Adding a song
1. Grab the lyrics with chords from [Ultimate guitar](https://ultimate-guitar.com).
2. Hit the edit button and copy the plain text from the pop up (usually has less superfluous newlines than if you copy the text directly).
3. Head to [ultimate.ftes.de](https://ultimate.ftes.de/), select `Latex` from the dropdown in the middle, and paste the text into the left text field. A slightly different version should appear on the right side.
4. Replace any `H` chords on the left side with `B`. If the left side includes German `B` chords that should be English `Bb` chords, replace them also.
5. Create a new file for the song in `./src/songs`.
6. Copy and paste the re-formatted Latex version from the right text box on the website into the new file.
7. Add an entry for the new song to `src/other/common-songs.tex`, again in the right order.
8. Fix things. Add the song title and artist to the first line. Have a look at the other song files to find out what the result should look like. Pay special attention to bridges, interludes (especially if they contain only chords and no lyrics), capo instructions.

## Notation
### `~H~` vs. `*B*`
The English scale is used (`C D E F G A B`).
That means `B/B♭` are used and not the German `H/B`.
So when you see a `B` it refers to the chord one half-step under `C`.

### Artist Names
In the `[by={<artist name>}]` field, artists with first and last name should be entered differently than made-up band names.

- `by={John Legend}` (artist index contains `Legend, John`)
- `by={Smash\ Mouth}` (artist index contains `Smash Mouth`)

## Transposing (key)
Include the chords in the original key (possibly corrected for capo, if that is how you found them). Use the `\transpose{<n>}` command to transpose chords. When doing so be sure to denote the original key (usually using something like `\musicnote{original +4 (C G F)}`).

## Common mistakes
### Bad math environment delimeter
Using chords (e.g. `\[C]`) outside of `\beginverse ... \endverse` or refrain environments.

### Flat chords with `b` instead of `&`
Search for `b]`. Replace with `&]`.

## Update chord sheets
Modify these files:
- `src/chords/chords.csv`
- `src/chords/chordbook-chords.tex`
- `scripts/generate-chordsheet-pages.sh`

Then run `$ ./scripts/generate-chordsheet-pages.sh`.

## Adding Latex packages
The docker image `blang/latex:ctanbasic` includes only a minimal set of Latex packages.

### Option A: Add .sty files to ./src/texmf
*This is the preferred option, as it keeps the docker image in use small (~500MB).*

Add additional packages (`.sty` and `.def` files) to `./src/texmf/tex/latex/`.

If you have `.dtx` and `.ins` files they must first be compiled using `docker run -v $PWD/src:/data blang/latex:ctanbasic latex <package>.
ins`.

### Option B: Switch docker image
Possibly `blang/latex:ctanfull` includes the package you need. But it's larger than 5GB, so avoid if possible.

### ~Option C: Custom docker image~
Unfortunately, the `blang/latex:*` images use the outdated 2017 texlive database. This prevents us from extending the docker image and installing additional packages via `tlmgr install`. If you want to go down that road, you have to do some more digging.
