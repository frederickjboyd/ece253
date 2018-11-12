# ECE253

## Known Bugs

### Lab 6

- Incorrect encodings for letters
- Morse code encoding produces an endless stream of dots
  - Due to `d` not being properly assigned in the `morseLengthCounter` module
  - Results in `z = (q == d)` not being assigned according to the initial design
