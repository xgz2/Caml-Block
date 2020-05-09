# Welcome
Welcome to Caml Blocks! 

This game was created by Ling Cao and George (Xiaoming) Zhuang as a final
project for the CS3110: Data Structure and Functional Programming (SP20) at Cornell University. In this text file, you will find an installation guide and some helpful instructions. Theses instructions are designed for an OSX based system, although the game will also run on other systems with some different installation properties. For other systems, a guide can be found on the CS3110 website (https://www.cs.cornell.edu/courses/cs3110/2020sp/install.html) for the basic OCaml installation. Thank you for playing, and we hope you enjoy!

# Acknowledgements
- Thank you to Professor Nate Foster and the CS3110 Course team for their efforts this semester.
- Thank you to 1010! Block Puzzle Game (https://play.google.com/store/apps/details?id=com.gramgames.tenten&hl=en_US) by Gram Games Limited for inspiring many of the gameplay functions. 
- Thank you to Edgar Aroutiounian for the devleopment of the Emoji module for OCaml (https://github.com/fxfactorial/ocaml-emoji).

# Caml-Block Overview
- The objective of the game is to fill rows and/or columns of the board.
- Upon filling an entire row and/or column, that row and/or column will clear.
- Points are awarded for every placement of a shape as well as for the successful clearing of a row (1 point for any placement *and* 1 point per block cleared).
- Place a shape by typing  ```place [column #] [row #]``` when prompted, with the column number representing the column of the top left corner of the shape and the row number representing the row of the top left corner of the shape.
- The queue below the board will show you three shapes, but it will only be possible to place the top shape. 
- Once you reach a point where you can't place your shape into the board anymore, the game will produce a message and exit.
- Exit the game at any time by typing  ```quit```.

# Installation Instructions
Please follow the following instructions to play the game
1. Open terminal
2. Installations for the game:
```
make opam
```
4. Starting the game:
```
make play
```