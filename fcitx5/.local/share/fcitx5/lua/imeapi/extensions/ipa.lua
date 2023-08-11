#!/usr/bin/lua

local strsub = string.sub

mapping = {
  ["&"] = "ɣ",
  ["//"] = "/",
  ["/R"] = "ʁ",
  ["/e"] = "ə",
  ["/r"] = "ɹ",
  ["/y"] = "ʎ",
  ["A"] = "ɑ",
  ["L"] = "ʟ",
  ["OE"] = "ɶ",
  ["Y"] = "ʏ",
  ["ae"] = "æ",
  ["d"] = "d",
  ["e"] = "e",
  ["g"] = "g",
  ["i-"] = "ɨ",
  ["o"] = "o",
  ["oe"] = "œ",
  ["sh"] = "ʃ",
  ["u"] = "u",
  ["zh"] = "ʒ",
  ["'"] = "ˈ",
  ["/3"] = "ɛ",
  ["/a"] = "ɐ",
  ["/h"] = "ɥ",
  ["/v"] = "ʌ",
  ["3"] = "ʒ",
  ["E"] = "ɛ",
  ["M"] = "ʍ",
  ["R"] = "ʀ",
  ["`"] = "ˌ",
  ["c"] = "c",
  ["d'"] = "d",
  ["e-"] = "ɚ",
  ["gn"] = "ɲ",
  ["n"] = "n",
  ["o-"] = "ɵ",
  ["o|"] = "ɑ",
  ["t"] = "t",
  ["u-"] = "ʉ",
  ["|o"] = "ɒ",
  ["/'"] = "ˊ",
  ["/A"] = "ɒ",
  ["/c"] = "ɔ",
  ["/m"] = "ɯ",
  ["/w"] = "ʍ",
  [":"] = "ː",
  ["I"] = "ɪ",
  ["O"] = "O",
  ["U"] = "ʊ",
  ["a"] = "a",
  ["c,"] = "ç",
  ["dh"] = "ð",
  ["e|"] = "ɚ",
  ["i"] = "i",
  ["ng"] = "ŋ",
  ["o/"] = "ø",
  ["s"] = "s",
  ["th"] = "θ",
  ["z"] = "z",
  ["~"] = "̃",
  ["^h"] = "ʰ",
}

function translateIPA(a)
  local i = 1
  local head
  local ret = ''
  while i <= #a do
    head = strsub(a, i, i+1)
    if mapping[head] then
      ret = ret .. mapping[head]
      i = i + 2
    else
      head = strsub(a, i, i)
      if mapping[head] then
        ret = ret .. mapping[head]
      else
        ret = ret .. head
      end
      i = i + 1
    end
  end
  return ret
end

function LookupIPA(input)
  return translateIPA(input)
end

ime.register_command("yb", "LookupIPA", "国际音标输入")
