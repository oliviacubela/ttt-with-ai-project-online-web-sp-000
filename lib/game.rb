class Game
  attr_accessor :board, :player_1, :player_2

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    @board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |winner|
      @board.cells[winner[0]] == @board.cells[winner[1]] &&
      @board.cells[winner[1]] == @board.cells[winner[2]] &&
      (@board.cells[winner[0]] == "X" || @board.cells[winner[0]] == "O")
    end
  end

  def draw?
    @board.full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if winning_combo = won?
      @winner = @board.cells[winning_combo.first]
    end
  end

  def turn
    puts "It's now #{current_player.token}'s turn."
    input = current_player.move(board, timer).to_i
    if board.valid_move?(input.to_s)
      board.update(input, current_player)
      system('clear')
      puts "Game #{@counter}" if @wargame
      board.display
    elsif input.between?(1, 9) == false
      puts "That is an invalid move"
      turn
    else
      puts "Whoops! Looks like that position is taken"
      turn
    end
  end

  # def turn
  #   puts "Please enter a number (1-9):"
  #   if !(input.to_i.between?(1,9)) || position.taken?
  #     "Invalid number. Please enter a number (1-9):"
  #   else
  #     turn(@board)
  #   end
  #   @board
  # end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]


  end
