vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# 取得光标处的匹配
def Lilydjwg_get_pattern_at_cursor(pat: string): string
  var col = col('.') - 1
  var line = getline('.')
  var ebeg = -1
  var cont = match(line, pat, 0)
  var elen = -1
  while (ebeg >= 0 || (0 <= cont) && (cont <= col))
    var contn = matchend(line, pat, cont)
    if (cont <= col) && (col < contn)
      ebeg = match(line, pat, cont)
      elen = contn - ebeg
      break
    else
      cont = match(line, pat, contn)
    endif
  endwhile
  if ebeg >= 0
    return strpart(line, ebeg, elen)
  else
    return ""
  endif
enddef

# 是否该调用 cycle?
def Lilydjwg_trycycle(dir: string): string
  var pat = Lilydjwg_get_pattern_at_cursor('[+-]\?\d\+')
  if !empty(pat)
    if dir ==? 'x'
      return "\<C-X>"
    else
      return "\<C-A>"
    endif
  else
    var mode = mode() =~ 'n' ? 'w' : 'v'
    var ndir = dir ==? 'x' ? -1 : 1
    return ":\<C-U>call Cycle('" .. mode .. "', " .. ndir .. ", v:count1)\<CR>"
  endif
enddef

nnoremap <expr> <silent> <C-X> Lilydjwg_trycycle('x')
vnoremap <expr> <silent> <C-X> Lilydjwg_trycycle('x')
nnoremap <expr> <silent> <C-A> Lilydjwg_trycycle('p')
vnoremap <expr> <silent> <C-A> Lilydjwg_trycycle('p')
nnoremap <Plug>CycleFallbackNext <C-A>
nnoremap <Plug>CycleFallbackPrev <C-X>
g:cycle_no_mappings = 1
g:cycle_default_groups = [
    [['true', 'false']],
    [['yes', 'no']],
    [['and', 'or']],
    [['on', 'off']],
    [['>', '<']],
    [['==', '!=']],
    [['是', '否']],
    [['有', '无']],
    [["in", "out"]],
    [["min", "max"]],
    [["get", "post"]],
    [["to", "from"]],
    [["read", "write"]],
    [['with', 'without']],
    [["exclude", "include"]],
    [["asc", "desc"]],
    [["next", "prev"]],
    [["encode", "decode"]],
    [["left", "right"]],
    [["hide", "show"]],
    [['「:」', '『:』'], 'sub_pairs'],
    [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
        'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
    [["enable", "disable"]],
    [["add", "remove"]],
    [['up', 'down']],
    [['after', 'before']],
]

g:cycle_default_groups_for_cmake = [
    [['true', 'false']],
    [['yes', 'no']],
    [['and', 'or']],
    [['on', 'off']],
    [['>', '<']],
    [['==', '!=']],
    [['是', '否']],
    [['有', '无']],
]
g:cycle_default_groups_for_meson = [
    [['true', 'false']],
    [['yes', 'no']],
    [['and', 'or']],
    [['on', 'off']],
    [["enabled", "disabled", "auto"]], # meson_options.txt
    [["plain", "debug", "debugoptimized", "release", "minsize", "custom"]], # buildtype
    [["shared", "static", "both"]], # default_library
    [["default", "nofallback", "nodownload", "forcefallback", "nopromote"]], # wrap_mode
    [["c89", "c99", "c11", "c17", "c18", "c2x", "gnu89", "gnu99", "gnu11", "gnu17", "gnu18", "gnu2x"]], # c_std
    [["c++98", "c++03", "c++11", "c++14", "c++17", "c++20", "c++2a", "c++1z", "gnu++03", "gnu++11", "gnu++14", "gnu++17", "gnu++1z", "gnu++2a", "gnu++20", "vc++14", "vc++17", "vc++latest"]], # cpp_std
    [["f95", "f2003", "f2008", "f2018"]], # fortran_std
    [['>', '<']],
    [['==', '!=']],
    [['是', '否']],
    [['有', '无']],
]
g:cycle_default_groups_for_PKGBUILD = [
    [['true', 'false']],
    [['yes', 'no']],
    [['and', 'or']],
    [['on', 'off']],
    # Meson
    [["enabled", "disabled", "auto"]], # meson_options.txt
    [["plain", "debug", "debugoptimized", "release", "minsize", "custom"]], # buildtype
    [["shared", "static", "both"]], # default_library
    [["default", "nofallback", "nodownload", "forcefallback", "nopromote"]], # wrap_mode
    [["c89", "c99", "c11", "c17", "c18", "c2x", "gnu89", "gnu99", "gnu11", "gnu17", "gnu18", "gnu2x"]], # c_std
    [["c++98", "c++03", "c++11", "c++14", "c++17", "c++20", "c++2a", "c++1z", "gnu++03", "gnu++11", "gnu++14", "gnu++17", "gnu++1z", "gnu++2a", "gnu++20", "vc++14", "vc++17", "vc++latest"]], # cpp_std
    [["f95", "f2003", "f2008", "f2018"]], # fortran_std
    # others
    [['>', '<']],
    [['==', '!=']],
    [['是', '否']],
    [['有', '无']],
]
