#!/usr/bin/env lua

local strsub = string.gsub
local _strupper = string.upper

-- map (final) constanant+tone to tone+constanant
mapConstTone2ToneConst = {
  n1 = '1n',
  n2 = '2n',
  n3 = '3n',
  n4 = '4n',
  ng1 = '1ng',
  ng2 = '2ng',
  ng3 = '3ng',
  ng4 = '4ng',
  r1 = '1r',
  r2 = '2r',
  r3 = '3r',
  r4 = '4r',
}

-- map vowel+vowel+tone to vowel+tone+vowel
mapVowelVowelTone2VowelToneVowel = {
  ai1 = 'a1i',
  ai2 = 'a2i',
  ai3 = 'a3i',
  ai4 = 'a4i',
  ao1 = 'a1o',
  ao2 = 'a2o',
  ao3 = 'a3o',
  ao4 = 'a4o',
  ei1 = 'e1i',
  ei2 = 'e2i',
  ei3 = 'e3i',
  ei4 = 'e4i',
  ou1 = 'o1u',
  ou2 = 'o2u',
  ou3 = 'o3u',
  ou4 = 'o4u',
}

-- map vowel-number combination to unicode
mapVowelTone2Unicode = {
  a1 = 'ā',
  a2 = 'á',
  a3 = 'ǎ',
  a4 = 'à',
  e1 = 'ē',
  e2 = 'é',
  e3 = 'ě',
  e4 = 'è',
  i1 = 'ī',
  i2 = 'í',
  i3 = 'ǐ',
  i4 = 'ì',
  o1 = 'ō',
  o2 = 'ó',
  o3 = 'ǒ',
  o4 = 'ò',
  u1 = 'ū',
  u2 = 'ú',
  u3 = 'ǔ',
  u4 = 'ù',
  v1 = 'ǜ',
  v2 = 'ǘ',
  v3 = 'ǚ',
  v4 = 'ǜ',
}

function strupper(c)
  local specials = {
    ['ā'] = 'Ā',
    ['á'] = 'Á',
    ['ǎ'] = 'Ǎ',
    ['à'] = 'À',
    ['ē'] = 'Ē',
    ['é'] = 'É',
    ['ě'] = 'Ě',
    ['è'] = 'È',
    ['ī'] = 'Ī',
    ['í'] = 'Í',
    ['ǐ'] = 'Ǐ',
    ['ì'] = 'Ì',
    ['ō'] = 'Ō',
    ['ó'] = 'Ó',
    ['ǒ'] = 'Ǒ',
    ['ò'] = 'Ò',
    ['ū'] = 'Ū',
    ['ú'] = 'Ú',
    ['ǔ'] = 'Ǔ',
    ['ù'] = 'Ù',
    ['ǜ'] = 'Ǜ',
    ['ǘ'] = 'Ǘ',
    ['ǚ'] = 'Ǚ',
    ['ǜ'] = 'Ǜ',
  }
  if specials[c] then
    return specials[c]
  else
    return _strupper(c)
  end
end

function ConvertPinyinToneNumbers(lineIn)
  local lineOut = lineIn

  -- first transform
  for x, y in pairs(mapConstTone2ToneConst) do
    lineOut = strsub(strsub(lineOut, x, y), strupper(x), strupper(y))
  end

  -- second transform
  for x, y in pairs(mapVowelVowelTone2VowelToneVowel) do
    lineOut = strsub(strsub(lineOut, x, y), strupper(x), strupper(y))
  end

  -- third transform
  for x, y in pairs(mapVowelTone2Unicode) do
    lineOut = strsub(strsub(lineOut, x, y), strupper(x), strupper(y))
  end

  return strsub(strsub(lineOut, 'v', 'ü'), 'V', 'Ü')
end

InputPinyin = ConvertPinyinToneNumbers

ime.register_command("py", "InputPinyin", "带声调的拼音输入")
