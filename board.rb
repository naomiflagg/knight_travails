class Board
  attr_accessor :moves_graph

  def initialize
    clean_board
  end

  def clean_board
    @board = Array.new(8) { Array.new(8, '|  ') }
  end

  def display_board
    board_break = '---------------------------------'
    puts board_break
    @board.each do |row|
      puts "#{row.join(' ')} |"
      puts board_break
    end
  end

  def move_piece(move)
    clean_board
    @board[move[0]][move[1]] = '| K'
  end

  def possible_moves(arr)
    row = arr[0]
    col = arr[1]
    moves = [
      [row - 2, col - 1], [row - 2, col + 1], [row - 1, col - 2], [row - 1, col + 2],
      [row + 1, col - 2], [row + 1, col + 2], [row + 2, col - 1], [row + 2, col + 1]
    ]
    # Select for moves that are on the board
    moves.select do |move|
      move[0].between?(0, 7) && move[1].between?(0, 7)
    end
  end
end
