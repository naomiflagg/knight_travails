class Board
  attr_accessor :moves_graph

  def initialize
    clean_board
    build_graph
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

  def possible_moves(row, col)
    moves = [
      [row - 2, col - 1], [row - 2, col + 1], [row - 1, col - 2], [row - 1, col + 2],
      [row + 1, col - 2], [row + 1, col + 2], [row + 2, col - 1], [row + 2, col + 1]
    ]
    # Select moves that are on the board
    moves.select do |move|
      move[0].between?(0, 7) && move[1].between?(0, 7)
    end
  end

  def build_graph
    @moves_graph = []
    @board.each_with_index do |val, row|
      val.each_index do |col|
        @moves_graph << [[row, col], possible_moves(row, col)]
      end
    end
    @moves_graph
  end
end
