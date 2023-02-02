function convert(num, target)
  local symbols = {'0','1','2','3','4','5','6','7','8','9',
                   'A','B','C','D','E','F'}
  local result = ""

  local tmp = num // target
  while  tmp ~= 0 do
    result = symbols[num % target + 1] .. result
    num = tmp
    tmp = num // target
  end
  result = symbols[num+1] .. result

  return result
end

function BinOctHex(input)
  if input == '' then
    return "convert Dec to Bin, Oct, Hex"
  end
  local num = tonumber(input)
  local output = {}

  table.insert(output, convert(num, 2))
  table.insert(output, convert(num, 8))
  table.insert(output, convert(num, 16))
  return output
end

ime.register_command("cv", "BinOctHex", "convert Dec to Bin, Oct, Hex", "alpha")
