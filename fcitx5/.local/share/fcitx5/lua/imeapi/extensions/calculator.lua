function preprocess(input)
  -- 去除无效符号
  input = string.gsub(input, "[^-+*/^.()%d]", "")
  -- 去尾
  input = string.gsub(input, "[-+*/^.(]+$", "")

  -- 标记负号,删除正号
  input = string.gsub(input, "^+", "")
  input = string.gsub(input, "^-", "~")
  input = string.gsub(input, "%(%+", "(")
  input = string.gsub(input, "%(%-", "(~")

  return input
end

function split_input(input)
  local input_splited = {}
  local input_byte = {string.byte(input, 1, -1)}

  local tmp = ""
  local item = ""
  local flag = false
  for i=1, #input_byte do
    tmp = input_byte[i]

    -- ASCII '0':48, '9':57, '.':46
    if tmp == 46 or (tmp >= 48 and tmp <= 57) then
      item = item .. string.char(tmp)
      flag = true
      if i == #input_byte then
        table.insert(input_splited, item)
      end
    elseif flag then
      table.insert(input_splited, item)
      table.insert(input_splited, string.char(tmp))
      item = ""
      flag = false
    else
      table.insert(input_splited, string.char(tmp))
    end
  end

  return input_splited
end

function shunting_yard(input)
  local priority = {}
  priority["#"] = 0
  priority["+"] = 1
  priority["-"] = 1
  priority["~"] = 2
  priority["*"] = 2
  priority["/"] = 2
  priority["^"] = 3

  local stack = {"#"}
  local output = {}

  for i=1, #input do
    local tmp = input[i]
    if tonumber(tmp) then
      table.insert(output, tmp)
    elseif tmp == '(' then
      table.insert(stack, tmp)
    elseif tmp == ')' then
      while stack[#stack] ~= '(' do
        table.insert(output, table.remove(stack))
      end
      table.remove(stack)
    elseif tmp == '^' then
      while priority[stack[#stack]] ~= nil and priority[tmp] < priority[stack[#stack]] do
        table.insert(output, table.remove(stack))
      end
      table.insert(stack, tmp)
    else
      while priority[stack[#stack]] ~= nil and priority[tmp] <= priority[stack[#stack]] do
        table.insert(output, table.remove(stack))
      end
      table.insert(stack, tmp)
    end
  end


  while #stack > 1 do
    -- 去除不匹配的括号
    if stack[#stack] == '(' then
      table.remove(stack)
    else
      table.insert(output, table.remove(stack))
    end
  end
  return output
end

function calculator(input)
  if input == "" then
    return "simple calculator: just input"
  end
  local result = -1

  -- 预处理
  input = preprocess(input)
  input = split_input(input)
  -- 用调度场算法转换为逆波兰表达式
  input = shunting_yard(input)

  local stack = {}
  for i=1, #input do
    local tmp = input[i]
    if tonumber(tmp) then
      table.insert(stack, tonumber(tmp))
    elseif tmp == '+' then
      local a1 = table.remove(stack)
      local a2 = table.remove(stack)
      table.insert(stack, a1+a2)
    elseif tmp == '-' then
      local a1 = table.remove(stack)
      local a2 = table.remove(stack)
      table.insert(stack, a2-a1)
    elseif tmp == '*' then
      local a1 = table.remove(stack)
      local a2 = table.remove(stack)
      table.insert(stack, a1*a2)
    elseif tmp == '/' then
      local a1 = table.remove(stack)
      local a2 = table.remove(stack)
      table.insert(stack, a2/a1)
    elseif tmp == '^' then
      local a1 = table.remove(stack)
      local a2 = table.remove(stack)
      table.insert(stack, a2^a1)
    elseif tmp == '~' then
      local a1 = table.remove(stack)
      table.insert(stack, -a1)
    end
  end

  result = stack[1]
  -- 结果为整数时去掉小数部分(6.0 -> 6)
  local inte, frac = math.modf(result)
  if frac == 0.0 then
    result = inte
  end
  return result
end

ime.register_command("cc", "calculator", "a simple calculator", "none")
