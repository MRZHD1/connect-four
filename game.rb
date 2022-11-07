class Game
  def initialize
    @values = []
    @board = ''
    @player = 'yellow'
    update_board()
  end

  def update_board
    if @values == []
      @values = Array.new(7)
      7.times do |i|
        @values[i] = Array.new(6, " ")
      end
    end
    @board = "▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃\n▍      ✏ 𝗖𝗼𝗻𝗻𝗲𝗰𝘁 𝗙𝗼𝘂𝗿       ▍\n▍ 1 | 2 | 3 | 4 | 5 | 6 | 7 ▍"
    6.times do |c| 
      @board += "\n▍---------------------------▍"
      @board += "\n▍ #{@values[0][5-c]} | #{@values[1][5-c]} | #{@values[2][5-c]} | #{@values[3][5-c]} | #{@values[4][5-c]} | #{@values[5][5-c]} | #{@values[6][5-c]} ▍"
    end
    @board += "\n▍▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▍"
    system('clear')
    puts @board
  end

  def play(pos)
    nums = ('0'..'9').to_a
    placed = false
    unless nums.include?(pos)
      puts "Invalid input, try again!"
      return false
    end
    pos = pos.to_i - 1
    @player = @player == 'red' ? 'yellow' : 'red'
    6.times do |i|
      if @values[pos][i] == ' '
        @values[pos][i] = @player == 'red' ? "\e[0;31;49m◍\e[0m" : "\e[0;33;49m◍\e[0m"
        placed = true
        break
      end
    end
    if placed == false
      puts "Off the board, try again!"
      return false
    end
    update_board()
  end

  def check
    if @values == []
      return false
    end
    check_list = []

    # Horizontal
    6.times do |i|
      for array in @values

        if check_list.length == 4
          puts "\nGame over! #{@player.capitalize} won"
          return true
        end
        if array[i] == ' ' || array[i] != check_list[0]
          check_list = [array[i]]
        else
          check_list += [array[i]]
        end
      end
    end

    i = 0
    for array in @values
      j = 0
      check_list = []

      for item in array
        
        # Vertical 
        if check_list.length == 4
          puts "Game over! #{@player} won"
          return true
        end
        if (item == ' ' || item != check_list[0])
          check_list = [item]
        else
          check_list += [item]
        end

        # Diagonal
        if i <= 3 && j <= 4 
          arr = [@values[i][j], @values[i+1][j+1], @values[i+2][j+2], @values[i+3][j+3]]
          if arr.uniq.size <= 1 && arr[0] != ' ' && arr[0] != nil
            puts "Game over! #{@player} won"
            return true
          end
        end
        j += 1
      end
      i += 1
    end
    return false
  end
end
