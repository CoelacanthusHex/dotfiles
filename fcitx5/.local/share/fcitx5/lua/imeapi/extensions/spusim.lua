-- modified from https://github.com/hosxy/fcitx5-lua-spusim
local fcitx = require("fcitx")

local app_im = {
  ['telegram-desktop'] = 'pinyin',
  ['yakuake'] = 'keyboard-us',
  ['konsole'] = 'keyboard-us',

  -- for fcitx5-android
  ['com.tencent.mobileqq'] = 'pinyin',
  ['com.tencent.mm'] = 'pinyin',
  ['com.keylesspalace.tusky'] = 'pinyin',
  ['com.xmflsct.app.tooot'] = 'pinyin',
  ['de.spiritcroc.riotx.testing.foss'] = 'pinyin',
  ['com.termux'] = 'keyboard-us',
  ['ml.docilealligator.infinityforreddit'] = 'keyboard-us',
  --['org.mozilla.firefox'] = 'keyboard-us',
  --['org.mozilla.fenix'] = 'keyboard-us',
}

function onContextCreated()
  local a = app_im[fcitx.currentProgram()]
  if a then
    fcitx.setCurrentInputMethod(a, true)
  end
end

fcitx.watchEvent(fcitx.EventType.ContextCreated, "onContextCreated")
