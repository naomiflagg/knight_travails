class KnightTravails
  require_relative('board.rb')

  attr_accessor :current

  def initialize
    @current = [3, 3]
    @board = Board.new
    @board.move_piece(@current)
    @board.display_board
    turn
  end

  def turn
    loop do
      shortest_path(ask_dest)
      @board.move_piece(@current)
      @board.display_board
      break unless keep_moving?
    end
  end

  def ask_dest
    puts "Your current space: #{@current}. Destination? Format: row, col."
    loop do
      dest = gets.chomp.split(',').map(&:to_i)
      if dest == @current
        puts 'You are already at your destination. Choose another.'
      # Ensure destination is an array of two indices on the board
      elsif dest.size == 2 && dest[0].between?(0, 7) && dest[1].between?(0, 7)
        return dest
      else
        puts 'Destination is not on the board. Try again.'
      end
    end
  end

  def shortest_path(dest)
    temp_dest = dest
    path = [dest]
    loop do
      # Find nearest parent of destination
      step = breadth_first_search(@current, temp_dest)
      # Make nearest parent the destination of next search
      temp_dest = step
      break if @current == temp_dest

      # Add nearest parent to path
      path.unshift(step)
    end
    puts "You made it in #{path.size} moves! Here's your path: #{path}"
    @current = dest
  end

  # Search adjacent spaces for destination via BFS
  def breadth_first_search(pointer, dest, q = [@current])
    # Find children aka adjacent spaces of pointer space
    poss_moves = @board.possible_moves(pointer)
    poss_moves.each do |move|
      # Break search if destination is adjacent. Otherwise, enqueue adjacent.
      move == dest ? (return q.first) : (q << move)
    end
    # Dequeue parent space
    q.shift
    # Move pointer to first child
    pointer = q.first
    breadth_first_search(pointer, dest, q)
  end

  def keep_moving?
    puts 'Would you like to keep making moves? Press Y and then enter to keep going.'
    gets.chomp.upcase == 'Y'
  end
end

KnightTravails.new
