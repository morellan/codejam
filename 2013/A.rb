def who_won(value)
  if value == 4 || value == 103
    return "X won"
  elsif value == 40 || value == 130
    return "O won"
  end
  return ""
end

cases = STDIN.readline.to_i

for i in 1..cases do
  horizontal = [0, 0, 0, 0]
  vertical = [0, 0, 0, 0]
  diagonal_1 = 0
  diagonal_2 = 0
  result = ""
  fullgame = true

  for j in 0..3 do
    line = STDIN.readline
    #puts line
    for k in 0..3 do
      value = 0
      char = line[k]

      case char
      when 'X'
        value = 1
      when 'O'
        value = 10
      when 'T'
        value = 100
      else
        value = 0
        fullgame = false
      end

      horizontal[j] += value
      vertical[k] += value
      if j == k
        diagonal_1 += value
      end
      if k == 3 - j
        diagonal_2 += value
      end
    end

    result = who_won(horizontal[j]) if result == ""
  end

  for j in 0..3 do
    result = who_won(vertical[j]) if result == ""
  end

  result = who_won(diagonal_1) if result == ""
  result = who_won(diagonal_2) if result == ""

  if result == ""
    if fullgame
      result = "Draw"
    else
      result = "Game has not completed"
    end
  end

  STDIN.readline
  printf "Case #%d: %s\n", i, result
end
