# Chess

![image of the chess board with pieces set](../media/ReadMe_Images/1_title_image.png?raw=true)

## About the project
This is a basic chess game application
that is played through a command line interface.
It does not feature ai opponents or 
advanced game mechanics like
castling,en passant or pawn promotion.

* The application was developed using:
    * Linux Ubuntu version 5.4.0-80-generic
    * ruby version 2.5.3
    * Bundler version 2.2.24

* Learning objectives for this project were:  
    * Know when and why private methods are used
    * Be able to read UML diagrams
    * Know how class inheritance works
    * Getting familiar with implementing and using modules
    * Getting to use the Singleton module

## How to run

* Clone the project repository
* Navigate to the project directory through the terminal
* Run the command `ruby game.rb`

* If there are issues with bundler version or gem dependencies:
    * Try running `bundle update`
    * Alternatively, delete Gemfile.lock and run `bundle install`

## How to play

* Use the direction keys to move the cursor
* Current player is denoted below the board (due to visibility issues
black pieces are colored pink and white are colored green)

![image with arrow to player turn message](../media/ReadMe_Images/2_player_turn.png?raw=true)

* Place the cursor above the piece you want to move

![image indicating cursor starting position ](../media/ReadMe_Images/3_cursor_starting_position.png?raw=true)
![image of cursor placement above piece](../media/ReadMe_Images/4_piece_cursor_placement.png?raw=true)

* Hit enter to select the piece

![selecting a piece](../media/ReadMe_Images/5_piece_selection.png?raw=true)

* Subsequently, place the cursor to the position you want 
the selected piece to move to 

![image of cursor placed above tile](../media/ReadMe_Images/6_cursor_move_placement.png?raw=true)

* Hit enter to make the move

![image of moved piece](../media/ReadMe_Images/7_piece_moved.png?raw=true)

(You can make an invalid move to cancel piece selection)

* You can exit the game by hitting Ctrl-c

Enjoy,the game!






