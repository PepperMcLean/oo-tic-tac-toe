require 'pry' 

class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5],  # Middle row
        [6,7,8],  # Bottom row
        [0,3,6],  # First column
        [1,4,7],  # Second column
        [2,5,8],  # Third column
        [0,4,8],  # Top Left - Bottom Right Diagnol 
        [2,4,6]  # Bottom Left - Top Right Diagnol
    ]

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        return input.to_i-1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            return false
        else
            return true
        end
    end

    def valid_move?(input)
        if input > 8 || input < 0 || position_taken?(input)
            return false
        else
            return true
        end
    end

    def turn
        # has_moved = false
        # until has_moved
            puts "What is the position of your move?(1-9)"
            move1 = input_to_index(gets.strip)
            if valid_move?(move1)
                move(move1, current_player)
                display_board
                # has_moved = true
            else
                turn
            end

    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def won?
        playerX = []
        playerO = []
        @board.each_with_index do |player, position|
            if player == 'X'
                playerX << position
            elsif player == 'O'
                playerO << position
            end
        end
        WIN_COMBINATIONS.each do |winningCombo|
            if winningCombo == winningCombo & playerO
                @winningPlayer = 'O'
                return winningCombo
            elsif winningCombo == winningCombo & playerX
                @winningPlayer = 'X'
                return winningCombo
            end
        end
        return false 
    end

    def full?
        @board.each do |position|
            if position == " "
                return false
            end
        end
        return true
    end

    def draw?
        if won?
            return false
        elsif full?
            return true
        end
    end

    def over?
        if draw?
            return true
        elsif won?
            return true
        else
            return false
        end
    end

    def winner 
        if won?
            return @winningPlayer
        end
    end

    def play
        until over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end


end