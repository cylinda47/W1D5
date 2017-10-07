require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.winner == @next_mover_mark
    return false if @board.winner == evaluator || @board.winner.nil?
    case1 = self.children.all? { |child| child.losing_node?(evaluator) }
    case2 = self.children.any? { |child| child.losing_node?(@next_mover_mark) }
    case1 || case2
  end

  def winning_node?(evaluator)
    return true if @board.winner == evaluator
    return false if @board.winner == @next_mover_mark
    case1 = self.children.any? {|child| child.winning_node?(evaluator)}
    case2 = self.children.all? {|child| child.winning_node?(@next_mover_mark)}
    
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    3.times do |x|
      3.times do |y|
        pos = [x, y]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = @next_mover_mark
          mark = switch_mark(@next_mover_mark)
          children << self.new(new_board, mark, pos)
        end
      end
    end
    children
  end

  def switch_mark(mark)
    if mark == :o
      :x
    else
      :o
    end
  end

end
