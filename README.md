# Solve-Puzzle-with-Image-Processing


This project reads an input image and solves a puzzle using patch images provided in a specified folder.

## Features

- **Puzzle Solving**: Reads the `Output.tif` image and solves the puzzle using patch images.
- **Flexible Input**: Can handle different images and varying numbers of patches.

## Usage

To run the project, execute `MAIN.m`. This script will:

1. Read the `Output.tif` image.
2. Solve the puzzle using patch images located in the `Puzzles` folder.
3. Allow for different images and varying numbers of patches.

## Folder Structure

- `Puzzles`: Contains the patch images used for solving the puzzle.

## How It Works

1. **Image Reading**: The script reads the `Output.tif` image.
2. **Puzzle Solving**: Utilizes patch images from the `Puzzles` folder to solve the puzzle.
3. **Flexible Execution**: Capable of running on different images with various numbers of patches.

## Example

1. Place your patch images in the `Puzzles` folder.
2. Ensure the main image is named `Output.tif`.
3. Run `MAIN.m`.
