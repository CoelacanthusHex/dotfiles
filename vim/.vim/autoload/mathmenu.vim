" mathmenu.vim
"   Author:  Charles E. Campbell
"   Date:    Jun 18, 2020
"   Version: part of the keymap/math.vim vimball
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp
 finish
endif
let s:keepcpo= &cpo
set cpo&vim

" ---------------------------------------------------------------------
" mathmenu#StartMathMenu: {{{1
fun! mathmenu#StartMathMenu()
"  call Dfunc("mathmenu#StartMathMenu()")

  " windows has figured out how to mess things up again
  " symptom: without the following early-return, under windows,
  "   :help index
  " will complain "E327: Part of menu-item path is not sub-menu"
  if &ft == "help" && !has("unix")
"   call Dret("mathmenu#StartMathMenu")
   return
  endif

  if !exists("b:startmathmaps")
   let b:startmathmaps= 1

   call SaveUserMaps("bv","","_^","MathMenu".bufnr("%"))
   if !hasmapto('<Plug>MathMenuSubscript')
    vmap <buffer> <unique> _	<Plug>MathMenuSubscript
   endif
  "   vno <buffer> <silent> <Plug>MathMenuSubscript	<esc>gv:B call mathmenu#Subscript()<cr>
   vno <buffer> <silent> <Plug>MathMenuSubscript	<esc>gv:call vis#VisBlockCmd("call mathmenu#Subscript()")<cr>

   if !hasmapto('<Plug>MathMenuSuperscript')
    vmap <buffer> <unique> ^	<Plug>MathMenuSuperscript
   endif
  "   vno <buffer> <silent> <Plug>MathMenuSuperscript	<esc>gv:B call mathmenu#Superscript()<cr>
  vno <buffer> <silent> <Plug>MathMenuSuperscript	<esc>gv:call vis#VisBlockCmd("call mathmenu#Superscript()")<cr>

   if !hasmapto('<Plug>MathMenuMathify')
    vmap <buffer> <unique> &	<Plug>MathMenuMathify
   endif
  "   vno <buffer> <silent> <Plug>MathMenuMathify	<esc>gv:B call mathmenu#Mathify()<cr>
  vno <buffer> <silent> <Plug>MathMenuMathify	<esc>gv:call vis#VisBlockCmd("call mathmenu#Mathify()")<cr>

"   call Decho("saving user vmaps for _ and ^, if any")
  endif

  if !exists("g:DrChipTopLvlMenu")
   let g:DrChipTopLvlMenu= "DrChip."
  endif

  exe 'sil! nunmenu '.g:DrChipTopLvlMenu.'MathKeys'
  exe 'sil! iunmenu '.g:DrChipTopLvlMenu.'MathKeys'
  exe 'sil! vunmenu '.g:DrChipTopLvlMenu.'MathKeys'
  exe 'sil! cunmenu '.g:DrChipTopLvlMenu.'MathKeys'

  " stop mathmenu
  exe 'nmenu '.g:DrChipTopLvlMenu."MathKeys.Disable	:call mathmenu#StopMathMenu()\<cr>"
  exe 'imenu '.g:DrChipTopLvlMenu."MathKeys.Disable	\<c-o>:call mathmenu#StopMathMenu()\<cr>"

  " capital Greek {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Alpha<tab>GA<tab>Α	Α'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Beta<tab>GB<tab>Β	Β'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Psi<tab>GC<tab>Ψ	Ψ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Delta<tab>GD<tab>Δ	Δ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Epsilon<tab>GE<tab>Ε	Ε'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Phi<tab>GF<tab>Φ	Φ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Gamma<tab>GG<tab>Γ	Γ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Eta<tab>GH<tab>Η	Η'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Iota<tab>GI<tab>Ι	Ι'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Xi<tab>GJ<tab>Ξ	Ξ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Kappa<tab>GK<tab>Κ	Κ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Lambda<tab>GL<tab>Λ	Λ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Mu<tab>GM<tab>Μ	Μ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Nu<tab>GN<tab>Ν	Ν'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Xi<tab>GQ<tab>Ξ	Ξ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Omikron<tab>GO<tab>Ο	Ο'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Pi<tab>GP<tab>Π	Π'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Rho<tab>GR<tab>Ρ	Ρ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Sigma<tab>GS<tab>Σ	Σ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Tau<tab>GT<tab>Τ	Τ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Theta<tab>GU<tab>Θ	Θ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Omega<tab>GV<tab>Ω	Ω'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Chi<tab>GX<tab>Χ	Χ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Upsilon<tab>GY<tab>Υ	Υ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Zeta<tab>GZ<tab>Ζ	Ζ'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Alpha<tab>GA<tab>Α	Α'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Beta<tab>GB<tab>Β	Β'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Psi<tab>GC<tab>Ψ	Ψ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Delta<tab>GD<tab>Δ	Δ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Epsilon<tab>GE<tab>Ε	Ε'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Phi<tab>GF<tab>Φ	Φ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Gamma<tab>GG<tab>Γ	Γ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Eta<tab>GH<tab>Η	Η'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Iota<tab>GI<tab>Ι	Ι'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Xi<tab>GJ<tab>Ξ	Ξ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Kappa<tab>GK<tab>Κ	Κ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Lambda<tab>GL<tab>Λ	Λ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Mu<tab>GM<tab>Μ	Μ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Nu<tab>GN<tab>Ν	Ν'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Xi<tab>GQ<tab>Ξ	Ξ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Omikron<tab>GO<tab>Ο	Ο'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Pi<tab>GP<tab>Π	Π'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Rho<tab>GR<tab>Ρ	Ρ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Sigma<tab>GS<tab>Σ	Σ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Tau<tab>GT<tab>Τ	Τ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Theta<tab>GU<tab>Θ	Θ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Omega<tab>GV<tab>Ω	Ω'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Chi<tab>GX<tab>Χ	Χ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Upsilon<tab>GY<tab>Υ	Υ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Capitals.Zeta<tab>GZ<tab>Ζ	Ζ'

  "lower case Greek: {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.alpha<tab>a<tab>α	α'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.beta<tab>b<tab>β	β'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.gamma<tab>g<tab>γ	γ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.delta<tab>d<tab>δ	δ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.epsilon<tab>e<tab>ϵ	ϵ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varepsilon<tab>ve<tab>ε	ε'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.zeta<tab>z<tab>ζ	ζ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.eta<tab>h<tab>η	η'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.theta<tab>u<tab>θ	θ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.vartheta<tab>vu<tab>ϑ	ϑ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.iota<tab>i<tab>ι	ι'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.kappa<tab>k<tab>κ	κ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.lambda<tab>l<tab>λ	λ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.mu<tab>m<tab>μ	μ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.nu<tab>n<tab>ν	ν'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.xi<tab>j<tab>ξ	ξ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.omicron<tab>o<tab>ο	ο'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.pi<tab>p<tab>π	π'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varpi<tab>vp<tab>ϖ	ϖ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.rho<tab>r<tab>ρ	ρ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varrho<tab>vr<tab>ϱ	ϱ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.sigma<tab>s<tab>σ	σ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varsigma<tab>vs<tab>ς	ς'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.tau<tab>t<tab>τ	τ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.upsilon<tab>y<tab>υ	υ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.phi<tab>f<tab>φ	φ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varphi<tab>vf<tab>ϕ	ϕ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.chi<tab>x<tab>χ	χ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.psi<tab>c<tab>ψ	ψ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.omega<tab>w<tab>ω	ω'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.alpha<tab>a<tab>α	α'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.beta<tab>b<tab>β	β'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.gamma<tab>g<tab>γ	γ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.delta<tab>d<tab>δ	δ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.epsilon<tab>e<tab>ϵ	ϵ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varepsilon<tab>ve<tab>ε	ε'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.zeta<tab>z<tab>ζ	ζ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.eta<tab>h<tab>η	η'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.theta<tab>u<tab>θ	θ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.vartheta<tab>vu<tab>ϑ	ϑ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.iota<tab>i<tab>ι	ι'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.kappa<tab>k<tab>κ	κ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.lambda<tab>l<tab>λ	λ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.mu<tab>m<tab>μ	μ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.nu<tab>n<tab>ν	ν'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.xi<tab>j<tab>ξ	ξ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.omicron<tab>o<tab>ο	ο'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.pi<tab>p<tab>π	π'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varpi<tab>p<tab>π	π'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.rho<tab>r<tab>ρ	ρ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varrho<tab>vr<tab>ϱ	ϱ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.sigma<tab>s<tab>σ	σ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varsigma<tab>vs<tab>ς	ς'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.tau<tab>t<tab>τ	τ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.upsilon<tab>y<tab>υ	υ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.phi<tab>f<tab>φ	φ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.varphi<tab>vf<tab>ϕ	ϕ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.chi<tab>x<tab>χ	χ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.psi<tab>c<tab>ψ	ψ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.LowerCase.omega<tab>w<tab>ω	ω'

  " superscripts {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^0<tab>⁰	⁰'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^1<tab>¹	¹'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^2<tab>²	²'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^3<tab>³	³'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^4<tab>⁴	⁴'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^5<tab>⁵	⁵'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^6<tab>⁶	⁶'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^7<tab>⁷	⁷'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^8<tab>⁸	⁸'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^9<tab>⁹	⁹'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^+<tab>⁺	⁺'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^-<tab>⁻	⁻'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^<<tab><	˂'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^><tab>>	˃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^/<tab>ˊ	ˊ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^^<tab>^	˄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^(<tab>⁽	⁽'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^)<tab>⁾	⁾'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^,<tab>ʾ	ʾ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^\.<tab>˙	˙'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^=<tab>˭	˭'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^a<tab>ᵃ	ᵃ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^b<tab>ᵇ	ᵇ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^c<tab>ᶜ	ᶜ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^d<tab>ᵈ	ᵈ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^e<tab>ᵉ	ᵉ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^f<tab>ᶠ	ᶠ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^g<tab>ᵍ	ᵍ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^h<tab>ʰ	ʰ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^i<tab>ⁱ	ⁱ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^j<tab>ʲ	ʲ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^k<tab>ᵏ	ᵏ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^l<tab>ˡ	ˡ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^m<tab>ᵐ	ᵐ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^n<tab>ⁿ	ⁿ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^o<tab>ᵒ	ᵒ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^p<tab>ᵖ	ᵖ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^r<tab>ʳ	ʳ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^s<tab>ˢ	ˢ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^t<tab>ᵗ	ᵗ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^u<tab>ᵘ	ᵘ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^v<tab>ᵛ	ᵛ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^x<tab>ˣ	ˣ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^w<tab>ʷ	ʷ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^y<tab>ʸ	ʸ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^z<tab>ᶻ	ᶻ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^A<tab>ᴬ	ᴬ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^B<tab>ᴮ	ᴮ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^D<tab>ᴰ	ᴰ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^E<tab>ᴱ	ᴱ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^G<tab>ᴳ	ᴳ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^H<tab>ᴴ	ᴴ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^I<tab>ᴵ	ᴵ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^J<tab>ᴶ	ᴶ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^K<tab>ᴷ	ᴷ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^L<tab>ᴸ	ᴸ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^M<tab>ᴹ	ᴹ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^N<tab>ᴺ	ᴺ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^O<tab>ᴼ	ᴼ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^P<tab>ᴾ	ᴾ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^R<tab>ᴿ	ᴿ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^T<tab>ᵀ	ᵀ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^U<tab>ᵁ	ᵁ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^V<tab>ⱽ	ⱽ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^W<tab>ᵂ	ᵂ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qb<tab>ᵝ	ᵝ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qd<tab>ᵟ	ᵟ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qf<tab>ᵠ	ᵠ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qg<tab>ᵞ	ᵞ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qx<tab>ᵡ	ᵡ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^β<tab>ᵝ	ᵝ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^δ<tab>ᵟ	ᵟ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^θ<tab>ᶿ	ᶿ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^ι<tab>ᶥ	ᶥ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^φ<tab>ᵠ	ᵠ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^χ<tab>ᵡ	ᵡ'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^0<tab>⁰	⁰'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^1<tab>¹	¹'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^2<tab>²	²'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^3<tab>³	³'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^4<tab>⁴	⁴'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^5<tab>⁵	⁵'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^6<tab>⁶	⁶'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^7<tab>⁷	⁷'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^8<tab>⁸	⁸'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^9<tab>⁹	⁹'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^+<tab>⁺	⁺'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^-<tab>⁻	⁻'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^<<tab><	˂'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^><tab>>	˃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^/<tab>ˊ	ˊ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^^<tab>^	˄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^(<tab>⁽	⁽'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^)<tab>⁾	⁾'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^,<tab>ʾ	ʾ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^\.<tab>˙	˙'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^=<tab>˭	˭'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^a<tab>ᵃ	ᵃ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^b<tab>ᵇ	ᵇ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^c<tab>ᶜ	ᶜ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^d<tab>ᵈ	ᵈ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^e<tab>ᵉ	ᵉ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^f<tab>ᶠ	ᶠ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^g<tab>ᵍ	ᵍ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^h<tab>ʰ	ʰ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^i<tab>ⁱ	ⁱ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^j<tab>ʲ	ʲ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^k<tab>ᵏ	ᵏ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^l<tab>ˡ	ˡ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^m<tab>ᵐ	ᵐ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^n<tab>ⁿ	ⁿ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^o<tab>ᵒ	ᵒ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^p<tab>ᵖ	ᵖ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^r<tab>ʳ	ʳ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^s<tab>ˢ	ˢ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^t<tab>ᵗ	ᵗ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^u<tab>ᵘ	ᵘ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^v<tab>ᵛ	ᵛ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^x<tab>ˣ	ˣ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^w<tab>ʷ	ʷ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^y<tab>ʸ	ʸ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^z<tab>ᶻ	ᶻ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^A<tab>ᴬ	ᴬ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^B<tab>ᴮ	ᴮ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^D<tab>ᴰ	ᴰ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^E<tab>ᴱ	ᴱ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^G<tab>ᴳ	ᴳ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^H<tab>ᴴ	ᴴ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^I<tab>ᴵ	ᴵ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^J<tab>ᴶ	ᴶ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^K<tab>ᴷ	ᴷ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^L<tab>ᴸ	ᴸ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^M<tab>ᴹ	ᴹ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^N<tab>ᴺ	ᴺ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^O<tab>ᴼ	ᴼ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^P<tab>ᴾ	ᴾ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^R<tab>ᴿ	ᴿ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^T<tab>ᵀ	ᵀ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^U<tab>ᵁ	ᵁ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^V<tab>ⱽ	ⱽ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^W<tab>ᵂ	ᵂ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qb<tab>ᵝ	ᵝ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qd<tab>ᵟ	ᵟ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qf<tab>ᵠ	ᵠ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qg<tab>ᵞ	ᵞ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^qx<tab>ᵡ	ᵡ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^β<tab>ᵝ	ᵝ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^δ<tab>ᵟ	ᵟ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^θ<tab>ᶿ	ᶿ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^ι<tab>ᶥ	ᶥ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^φ<tab>ᵠ	ᵠ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Superscripts.^χ<tab>ᵡ	ᵡ'

  " subscripts {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._0<tab>₀	₀'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._1<tab>₁	₁'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._2<tab>₂	₂'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._3<tab>₃	₃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._4<tab>₄	₄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._5<tab>₅	₅'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._6<tab>₆	₆'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._7<tab>₇	₇'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._8<tab>₈	₈'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._9<tab>₉	₉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._+<tab>₊	₊'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._-<tab>₋	₋'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._/<tab>ˏ	ˏ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._=<tab>₍	₌'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._(<tab>₍	₍'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._)<tab>₎	₎'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._^<tab>‸	‸'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._a<tab>ₐ	ₐ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._e<tab>ₑ	ₑ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._h<tab>ₕ	ₕ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._i<tab>ᵢ	ᵢ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._j<tab>ⱼ	ⱼ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._k<tab>ₖ	ₖ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._l<tab>ₗ	ₗ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._m<tab>ₘ	ₘ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._n<tab>ₙ	ₙ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._o<tab>ₒ	ₒ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._p<tab>ₚ	ₚ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._r<tab>ᵣ	ₛ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._s<tab>ₛ	ᵣ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._t<tab>ₜ	ₜ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._u<tab>ᵤ	ᵤ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._v<tab>ᵥ	ᵥ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._x<tab>ₓ	ₓ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._β<tab>ᵦ	ᵦ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._γ<tab>ᵧ	ᵧ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._φ<tab>ᵩ	ᵩ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._ρ<tab>ᵨ	ᵨ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._χ<tab>ᵪ	ᵪ'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._0<tab>₀	₀'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._1<tab>₁	₁'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._2<tab>₂	₂'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._3<tab>₃	₃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._4<tab>₄	₄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._5<tab>₅	₅'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._6<tab>₆	₆'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._7<tab>₇	₇'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._8<tab>₈	₈'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._9<tab>₉	₉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._+<tab>₊	₊'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._-<tab>₋	₋'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._/<tab>ˏ	ˏ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._=<tab>₍	₌'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._(<tab>₍	₍'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._)<tab>₎	₎'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._^<tab>‸	‸'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._a<tab>ₐ	ₐ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._e<tab>ₑ	ₑ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._h<tab>ₕ	ₕ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._i<tab>ᵢ	ᵢ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._j<tab>ⱼ	ⱼ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._k<tab>ₖ	ₖ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._l<tab>ₗ	ₗ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._m<tab>ₘ	ₘ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._n<tab>ₙ	ₙ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._o<tab>ₒ	ₒ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._p<tab>ₚ	ₚ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._r<tab>ᵣ	ᵣ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._s<tab>ₛ	ₛ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._t<tab>ₜ	ₜ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._u<tab>ᵤ	ᵤ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._v<tab>ᵥ	ᵥ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._x<tab>ₓ	ₓ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._β<tab>ᵦ	ᵦ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._γ<tab>ᵧ	ᵧ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._φ<tab>ᵩ	ᵩ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._ρ<tab>ᵨ	ᵨ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Subscripts._χ<tab>ᵪ	ᵪ'

  " fractions {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F12<tab>½	½'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F13<tab>⅓	⅓'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F23<tab>⅔	⅔'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F14<tab>¼	¼'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F34<tab>¾	¾'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F15<tab>⅕	⅕'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F25<tab>⅖	⅖'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F35<tab>⅗	⅗'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F45<tab>⅘	⅘'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F16<tab>⅙	⅙'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F56<tab>⅚	⅚'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F18<tab>⅛	⅛'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F38<tab>⅜	⅜'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F58<tab>⅝	⅝'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F78<tab>⅞	⅞'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F12<tab>½	½'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F13<tab>⅓	⅓'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F23<tab>⅔	⅔'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F14<tab>¼	¼'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F34<tab>¾	¾'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F15<tab>⅕	⅕'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F25<tab>⅖	⅖'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F35<tab>⅗	⅗'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F45<tab>⅘	⅘'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F16<tab>⅙	⅙'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F56<tab>⅚	⅚'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F18<tab>⅛	⅛'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F38<tab>⅜	⅜'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F58<tab>⅝	⅝'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Fractions.F78<tab>⅞	⅞'

  " Arrows {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.-<<tab>←	←'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.-><tab>→	→'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<-><tab>↔	↔'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.=<<tab>⇐	⇐'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.=><tab>⇒	⇒'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.IFF<tab>⇔	⇔'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|-<<tab>↤	↤'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|-><tab>↦	↦'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|=<<tab>⟽	⟽'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|=><tab>⟾	⟾'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>d<tab>↓	↓'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>u<tab>↑	↑'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>U<tab>⇑	⇑'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>D<tab>⇓	⇓'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>ud<tab>↕	↕'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<o<tab>↺	↺'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>o<tab>↻	↻'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>ne<tab>↗	↗'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>se<tab>↘	↘'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>sw<tab>↙	↙'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>nw<tab>↖	↖'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>!<tab>↛	↛'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<!<tab>↚	↚'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<~><tab>↝	↝'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<~><tab>↭	↭'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.H<<tab>↩	↩'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.H><tab>↪	↪'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.CL<tab>↻	↻'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.CR<tab>↺	↺'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.-<<tab>⟵	⟵'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.-><tab>⟶	⟶'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<-><tab>↔	↔'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.=<<tab>⟸	⟸'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.=><tab>⟹	⟹'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.IFF<tab>⟺	⟺'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|-<<tab>↤	↤'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|-><tab>↦	↦'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|=<<tab>⟽	⟽'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.\|=><tab>⟾	⟾'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>d<tab>↓	↓'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>u<tab>↑	↑'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>U<tab>⇑	⇑'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>D<tab>⇓	⇓'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>ud<tab>↕	↕'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<o<tab>↺	↺'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>o<tab>↻	↻'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>ne<tab>↗	↗'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>se<tab>↘	↘'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>sw<tab>↙	↙'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>nw<tab>↖	↖'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.>!<tab>↛	↛'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<!<tab>↚	↚'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<~><tab>↝	↝'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.<~><tab>↭	↭'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.H<<tab>↩	↩'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.H><tab>↪	↪'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.CL<tab>↻	↻'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Arrows.CR<tab>↺	↺'

  " Grouping {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.[[<tab>⟦	⟦'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.]]<tab>⟧	⟧'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.2[<tab>⟦	⟦'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.2]<tab>⟧	⟧'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B<<tab>〈	〈'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B><tab>〉	〉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U(<tab>⎛	⎛'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M(<tab>⎜	⎜'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B(<tab>⎝	⎝'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U)<tab>⎞	⎞'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M)<tab>⎟	⎟'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B)<tab>⎠	⎠'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U[<tab>⎡	⎡'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M[<tab>⎢	⎢'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B[<tab>⎣	⎣'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U]<tab>⎤	⎤'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M]<tab>⎥	⎥'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B]<tab>⎦	⎦'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U{<tab>⎧	⎧'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M{<tab>⎨	⎨'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B{<tab>⎩	⎩'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U}<tab>⎫	⎫'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M}<tab>⎬	⎬'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B}<tab>⎭	⎭'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V(<tab>︵	︵'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V)<tab>︶	︶'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V[<tab>︹	︹'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V]<tab>︺	︺'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V{<tab>︷	︷'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V}<tab>︸	︸'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V<<tab>︿	︿'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V><tab>﹀	﹀'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.[[<tab>⟦	⟦'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.]]<tab>⟧	⟧'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.2[<tab>⟦	⟦'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.2]<tab>⟧	⟧'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B<<tab>〈	〈'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B><tab>〉	〉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U(<tab>⎛	⎛'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M(<tab>⎜	⎜'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B(<tab>⎝	⎝'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U)<tab>⎞	⎞'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M)<tab>⎟	⎟'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B)<tab>⎠	⎠'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U[<tab>⎡	⎡'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M[<tab>⎢	⎢'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B[<tab>⎣	⎣'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U]<tab>⎤	⎤'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M]<tab>⎥	⎥'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B]<tab>⎦	⎦'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U{<tab>⎧	⎧'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M{<tab>⎨	⎨'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B{<tab>⎩	⎩'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.U}<tab>⎫	⎫'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.M}<tab>⎬	⎬'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.B}<tab>⎭	⎭'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V(<tab>︵	︵'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V)<tab>︶	︶'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V[<tab>︹	︹'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V]<tab>︺	︺'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V{<tab>︷	︷'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V}<tab>︸	︸'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V<<tab>︿	︿'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Grouping.V><tab>﹀	﹀'

  " Miscellaneous {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.ARC<tab>⌒	⌒'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.QED<tab>∎	∎'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.QED<tab>‣	‣'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.INF<tab>∞	∞'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.ANG<tab>∠	∠'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.\|\.\.\.<tab>⋮	⋮'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.\.\.\.<tab>⋯	⋯'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc./\.\.\.<tab>⋰	⋰'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.\\\.\.\.<tab>⋱	⋱'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.DU<tab>⠁	⠁'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.DM<tab>⠂	⠂'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.DD<tab>⡀	⡀'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.LC<tab>⌈	⌈'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.RC<tab>⌉	⌉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.LF<tab>⌊	⌊'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.RF<tab>⌋	⌋'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.__<tab>⎯	⎯'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.--<tab>─	─'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.==<tab>═	═'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.HB<tab>―	―'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.VB<tab>┃	┃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SC<tab>§	P'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.BB<tab>‖	‖'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SB<tab>ℬ	ℬ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SE<tab>ℰ	ℰ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SF<tab>ℱ	ℱ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SH<tab>ℋ	ℋ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SI<tab>ℑ	ℑ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SL<tab>ℒ	ℒ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SL<tab>ℒ	ℒ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SM<tab>ℳ	ℳ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SR<tab>ℜ	ℜ'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.ARC<tab>⌒	⌒'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.QED<tab>∎	∎'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.QED<tab>‣	‣'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.INF<tab>∞	∞'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.ANG<tab>∡	∡'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.\|\.\.\.<tab>⋮	⋮'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.\.\.\.<tab>⋯	⋯'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc./\.\.\.<tab>⋰	⋰'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.\\\.\.\.<tab>⋱	⋱'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.DU<tab>⠁	⠁'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.DM<tab>⠂	⠂'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.DD<tab>⡀	⡀'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.LC<tab>⌈	⌈'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.RC<tab>⌉	⌉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.LF<tab>⌊	⌊'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.RF<tab>⌋	⌋'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.__<tab>⎯	⎯'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.HB<tab>―	―'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.--<tab>─	─'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.==<tab>═	═'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.VB<tab>┃	┃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SC<tab>§	§'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.BB<tab>‖	‖'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SB<tab>ℬ	ℬ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SE<tab>ℰ	ℰ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SF<tab>ℱ	ℱ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SH<tab>ℋ	ℋ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SI<tab>ℑ	ℑ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SL<tab>ℒ	ℒ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SL<tab>ℒ	ℒ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SM<tab>ℳ	ℳ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Misc.SR<tab>ℜ	ℜ'

  " Operators {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.O\.<tab>⊙	⊙'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.O+<tab>⊕	⊕'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.O-<tab>⊖	⊖'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.Ox<tab>⊗	⊗'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.O/<tab>⊘	⊘'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.U\.<tab>⨃	⨃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.U+<tab>⨄	⨄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.IN<tab>∩	∩'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.UN<tab>∪	∪'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.CAP<tab>∩	∩'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.CUP<tab>∪	∪'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SQCAP<tab>⨅	⨅'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SQCUP<tab>⨆	⨆'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.X<tab>⨉	⨉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.MUL<tab>×	×'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.1S<tab>∫	∫'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.2S<tab>∬	∬'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.3S<tab>∭	∭'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.4S<tab>⨌	⨌'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.US<tab>⌠	⌠'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.MS<tab>⎮	⎮'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.BS<tab>⌡	⌡'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.S-<tab>⨍	⨍'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.S=<tab>⨎	⨎'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.S/<tab>⨏	⨏'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.So<tab>∮	∮'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SSo<tab>∯	∯'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SSSo<tab>∰	∰'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.Scw<tab>∲	∲'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.Sccw<tab>∳	∳'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.PD<tab>∂	∂'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.JN<tab>⨝	⨝'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.\.:\.<tab>∴	∴'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.BC<tab>∵	∵'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.PAR<tab>∥	∥'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.NPAR<tab>∦	∦'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SUM<tab>∑	∑'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.USUM<tab>⎲	⎲'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.BSUM<tab>⎳	⎳'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.*<tab>∏	∏'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.@o<tab>∘	∘'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.@\.<tab>∙	∙'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.AST<tab>∗	∗'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.LA<tab>⁎	⁎'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.$<tab>√	√'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.3$<tab>∛	∛'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.4$<tab>∜	∜'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.DEL<tab>∆	∆'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.GRAD<tab>∇	∇'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.NAB<tab>∇	∇'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.DIAM<tab>⋄	⋄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.R/<tab>∕	∕'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.L/<tab>∖	∖'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.P1<tab>′	′'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.P2<tab>″	″'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.P3<tab>‴	‴'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FUL<tab>⎡	⎡'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FUR<tab>⎤	⎤'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FDL<tab>⎣	⎣'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FDR<tab>⎦	⎦'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.O\.<tab>⨀	⨀'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.O+<tab>⨁	⨁'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.Ox<tab>⨂	⨂'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.U\.<tab>⨃	⨃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.U+<tab>⨄	⨄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.UN<tab>∩	∩'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.IN<tab>∪	∪'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.CAP<tab>(	('
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.CUP<tab>(	('
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SQCAP<tab>⨅	⨅'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SQCUP<tab>⨆	⨆'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.X<tab>⨉	⨉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.MUL<tab>×	×'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.1S<tab>∫	∫'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.2S<tab>∬	∬'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.3S<tab>∭	∭'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.4S<tab>⨌	⨌'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.US<tab>⌠	⌠'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.MS<tab>⎮	⎮'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.BS<tab>⌡	⌡'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.S-<tab>⨍	⨍'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.S=<tab>⨎	⨎'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.S/<tab>⨏	⨏'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.So<tab>∮	∮'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SSo<tab>∯	∯'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SSSo<tab>∰	∰'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.Scw<tab>∲	∲'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.Sccw<tab>∳	∳'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.PD<tab>∂	∂'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.JN<tab>⨝	⨝'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.TF<tab>∴	∴'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.BC<tab>∵	∵'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.PAR<tab>∥	∥'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.NPAR<tab>∦	∦'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.SUM<tab>∑	∑'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.USUM<tab>⎲	⎲'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.BSUM<tab>⎳	⎳'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.*<tab>∏	∏'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.@o<tab>∘	∘'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.@\.<tab>∙	∙'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.AST<tab>∗	∗'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.LA<tab>⁎	⁎'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.$<tab>√	√'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.3$<tab>∛	∛'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.4$<tab>∜	∜'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.DEL<tab>∆	∆'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.GRAD<tab>∇	∇'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.NAB<tab>∇	∇'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.DIAM<tab>⋄	⋄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.R/<tab>∕	∕'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.L/<tab>∖	∖'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.P1<tab>′	′'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.P2<tab>″	″'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.P3<tab>‴	‴'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FUL<tab>⎡	⎡'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FUR<tab>⎤	⎤'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FDL<tab>⎣	⎣'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Operators.FDR<tab>⎦	⎦'

  " Relationals {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<=<tab>≤	≤'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.>=<tab>≥	≥'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<~<tab>⪝	⪝'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.>~<tab>⪞	⪞'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<<<tab>⟪	⟪'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.>><tab>⟫	⟫'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~<tab>∼	∼'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.N~<tab>≁	≁'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.R~<tab>∽	∽'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.-~<tab>≂	≂'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~-<tab>≃	≃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.=~<tab>≅	≅'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!~-<tab>≄	≄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~~<tab>≈	≈'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!~~<tab>≉	≉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.=\.<tab>≐	≐'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.EST<tab>≙	≙'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!~~<tab>≉	≉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<><tab>≶	≶'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.><<tab>≷	≷'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!=<tab>≠	≠'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!<<tab>≮	≮'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!><tab>≯	≯'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!<=<tab>≰	≰'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!>=<tab>≱	≱'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~><tab>≳	≳'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~<<tab>≲	≲'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.ID<tab>≡	≡'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.NID<tab>≢	≢'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.EQV<tab>≍	≍'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.JOIN<tab>⋈	⋈'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O+<tab>⊕	⊕'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O-<tab>⊖	⊖'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.Ox<tab>⊗	⊗'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O/<tab>⊘	⊘'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O\.<tab>⊙	⊙'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.Oo<tab>⊚	⊚'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.+-<tab>±	±'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.-+<tab>∓	∓'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.PERP<tab>⊥	⊥'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.PROP<tab>∝	∝'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.PREC<tab>≺	≺'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.SUCC<tab>≻	≻'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<=<tab>≤	≤'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.>=<tab>≥	≥'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<~<tab>⪝	⪝'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.>~<tab>⪞	⪞'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<<<tab>⟪	⟪'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.>><tab>⟫	⟫'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~<tab>∼	∼'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.N~<tab>≁	≁'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.R~<tab>∽	∽'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.-~<tab>≂	≂'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~-<tab>≃	≃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.=~<tab>≅	≅'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!~-<tab>≄	≄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!~~<tab>≉	≉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.~~<tab>≈	≈'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.=\.<tab>≐	≐'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.EST<tab>≙	≙'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!~~<tab>≉	≉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.<><tab>≶	≶'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.><<tab>≷	≷'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!=<tab>≠	≠'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!<<tab>≮	≮'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!><tab>≯	≯'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!<=<tab>≰	≰'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.!>=<tab>≱	≱'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.ID<tab>≡	≡'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.NID<tab>≢	≢'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.EQV<tab>≍	≍'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.JOIN<tab>⋈	⋈'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O+<tab>⊕	⊕'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O-<tab>⊕	⊖'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.Ox<tab>⊕	⊗'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O/<tab>⊕	⊘'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.O\.<tab>⊕	⊙'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.Oo<tab>⊕	⊚'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.+-<tab>±	±'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.-+<tab>∓	∓'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.PERP<tab>⊥	⊥'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.PROP<tab>∝	∝'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.PREC<tab>≺	≺'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Relationals.SUCC<tab>≻	≻'

  " Sets {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@SUB<tab>⊂	⊂'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NSUB<tab>⊄	⊄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@ESUB<tab>⊆	⊆'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NESUB<tab>⊈	⊈'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@SUP<tab>⊃	⊃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NSUP<tab>⊅	⊅'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@ESUP<tab>⊇	⊇'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NESUP<tab>⊉	⊉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.\&\&\&\&<tab>∧	∧'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.\|\|<tab>∨	∨'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@!<tab>¬	¬'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@EX<tab>∃	∃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NEX<tab>∄	∄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@EMP<tab>∅	∅'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.EL<tab>∈	∈'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.NEL<tab>∉	∉'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.CC<tab>ℂ	ℂ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.HH<tab>ℍ	ℍ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.sets.II<tab>ℐ	ℐ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@L<tab>ℒ	ℒ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.sets.NN<tab>ℕ	ℕ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.PP<tab>ℙ	ℙ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.RR<tab>ℝ	ℝ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.QQ<tab>ℚ	ℚ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.ZZ<tab>ℤ	ℤ'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.4A<tab>∀	∀'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.*<tab>∗	∗'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@SUB<tab>⊂	⊂'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NSUB<tab>⊄	⊄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@ESUB<tab>⊆	⊆'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NESUB<tab>⊈	⊈'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@SUP<tab>⊃	⊃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NSUP<tab>⊅	⊅'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@ESUP<tab>⊇	⊇'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NESUP<tab>⊉	⊉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.\&\&\&\&<tab>∧	∧'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.\|\|<tab>∨	∨'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@EX<tab>∃	∃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@NEX<tab>∄	∄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@EMP<tab>∅	∅'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@EL<tab>∈	∈'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.NEL<tab>∉	∉'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.CC<tab>ℂ	ℂ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.HH<tab>ℍ	ℍ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.sets.II<tab>ℐ	ℐ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.@L<tab>ℒ	ℒ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.NN<tab>ℕ	ℕ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.RR<tab>ℝ	ℝ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.QQ<tab>ℚ	ℚ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.ZZ<tab>ℤ	ℤ'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.4A<tab>∀	∀'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Sets.*<tab>∗	∗'

  " Box Characters {{{2
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.B-<tab>─	─'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.B\|<tab>│	│'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DSH-<tab>┄	┄'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DSH\|<tab>┆	┆'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BUL<tab>┌	┌'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BDL<tab>└	└'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BUR<tab>┐	┐'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BDR<tab>┘	┘'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.C+<tab>┼	┼'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cl<tab>┤	┤'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cr<tab>├	├'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cd<tab>┬	┬'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cu<tab>┴	┴'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HB-<tab>━	━'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HB\|<tab>┃	┃'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HD-<tab>┅	┅'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HD\|<tab>┇	┇'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBUL<tab>┏	┏'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBDL<tab>┗	┗'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBUR<tab>┓	┓'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBDR<tab>┛	┛'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HC+<tab>╋	╋'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCl<tab>┫	┫'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCr<tab>┣	┣'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCd<tab>┳	┳'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCu<tab>┻	┻'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.D-<tab>═	═'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.D\|<tab>║	║'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DUL<tab>╔	╔'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DDL<tab>╚	╚'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DUR<tab>╗	╗'
  exe 'imenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DDR<tab>╝	╝'

  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.B_<tab>─	─'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.B\|<tab>│	│'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DSH_<tab>┄	┄'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DSH\|<tab>┆	┆'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BUL<tab>┌	┌'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BDL<tab>└	└'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BUR<tab>┐	┐'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.BDR<tab>┘	┘'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.C+<tab>┼	┼'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cl<tab>┤	┤'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cr<tab>├	├'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cd<tab>┬	┬'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.Cu<tab>┴	┴'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HB-<tab>━	━'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HB\|<tab>┃	┃'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HD-<tab>┅	┅'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HD\|<tab>┇	┇'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBUL<tab>┏	┏'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBDL<tab>┗	┗'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBUR<tab>┓	┓'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HBDR<tab>┛	┛'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HC+<tab>╋	╋'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCl<tab>┫	┫'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCr<tab>┣	┣'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCd<tab>┳	┳'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.HCu<tab>┻	┻'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.D-<tab>═	═'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.D\|<tab>║	║'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DUL<tab>╔	╔'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DDL<tab>╚	╚'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DUR<tab>╗	╗'
  exe 'cmenu '.g:DrChipTopLvlMenu.'MathKeys.Box.DDR<tab>╝	╝'

  " handle initial menu item for keymap
  exe "nmenu <silent> ".g:DrChipTopLvlMenu."MathKeys.SetKeymap	:call mathmenu#ToggleKeymap()\<cr>"
  exe "nmenu <silent> ".g:DrChipTopLvlMenu."MathKeys.MathStart	:call mathmenu#StartMathMenu()\<cr>"
  exe "imenu <silent> ".g:DrChipTopLvlMenu."MathKeys.SetKeymap	\<c-o>:call mathmenu#ToggleKeymap()\<cr>"
  exe "imenu <silent> ".g:DrChipTopLvlMenu."MathKeys.MathStart	\<c-o>:call mathmenu#StartMathMenu()\<cr>"

"  call Dret("mathmenu#StartMathMenu")
endfun

" ---------------------------------------------------------------------
" mathmenu#StopMathMenu: {{{1
fun! mathmenu#StopMathMenu()
"  "  call Dfunc("mathmenu#StopMathMenu()")
  if exists("b:startmathmaps")
   unlet b:startmathmaps
"   call Decho("restoring user vmaps for _ and ^, if any")
   vunmap <buffer> _
   vunmap <buffer> ^
   call RestoreUserMaps("MathMenu".bufnr("%"))
  endif
  exe 'silent! nunmenu '.g:DrChipTopLvlMenu.'MathKeys'
  exe 'silent! iunmenu '.g:DrChipTopLvlMenu.'MathKeys'
  exe 'silent! vunmenu '.g:DrChipTopLvlMenu.'MathKeys'
  exe 'nmenu '.g:DrChipTopLvlMenu."MathKeys.Enable	:call mathmenu#StartMathMenu()\<cr>"
  exe 'imenu '.g:DrChipTopLvlMenu."MathKeys.Enable	\<c-o>:call mathmenu#StartMathMenu()\<cr>"
  exe 'vmenu '.g:DrChipTopLvlMenu."MathKeys.Enable	:<c-u>call mathmenu#StartMathMenu()\<cr>gv"
  exe 'cmenu '.g:DrChipTopLvlMenu."MathKeys.Enable	:<c-u>call mathmenu#StartMathMenu()\<cr>"
"  "  call Dret("mathmenu#StopMathMenu")
endfun

" ---------------------------------------------------------------------
" mathmenu#Subscript: v_: converts visual-mode selected character(s) to a subscripted equivalent (if any) {{{1
fun! mathmenu#Subscript()
"  call Dfunc("mathmenu#Subscript()")

   s/[0⁰]/₀/ge
   s/[1¹]/₁/ge
   s/[2²]/₂/ge
   s/[3³]/₃/ge
   s/[4⁴]/₄/ge
   s/[5⁵]/₅/ge
   s/[6⁶]/₆/ge
   s/[7⁷]/₇/ge
   s/[8⁸]/₈/ge
   s/[9⁹]/₉/ge
   s/[/ˊ]/ˏ/ge
   s/*/⁎/ge
   s/ ⃰/⁎/ge
   s/[+⁺]/₊/ge
   s/[-⁻]/₋/ge
   s/[(⁽]/₍/ge
   s/[)⁾]/₎/ge
"   s/[.˙]/‸/ge
   s/\./⡀/ge
   s/[aᵃ]/ₐ/ge
   s/[eᵉ]/ₑ/ge
   s/[h]/ₕ/ge
   s/[iⁱ]/ᵢ/ge
   s/[jʲ]/ⱼ/ge
   s/[kᵏ]/ₖ/ge
   s/[lˡ]/ₗ/ge
   s/[mᵐ]/ₘ/ge
   s/[nⁿ]/ₙ/ge
   s/[oᵒ]/ₒ/ge
   s/[pᵖ]/ₚ/ge
   s/[rʳ]/ᵣ/ge
   s/[sˢ]/ₛ/ge
   s/[tᵗ]/ₜ/ge
   s/[uᵘ]/ᵤ/ge
   s/[vᵛ]/ᵥ/ge
   s/[xˣ]/ₓ/ge
   s/β/ᵦ/ge
   s/γ/ᵧ/ge
   s/φ/ᵩ/ge
   s/ρ/ᵨ/ge
   s/χ/ᵪ/ge
   s/@\[/⎣/ge
   s/@\]/⎦/ge
   s/@(/⎝/ge
   s/@)/⎠/ge        
   s/=/₌/ge
   s/\~/ ̰/ge

"  call Dret("mathmenu#Subscript")
endfun

" ---------------------------------------------------------------------
" mathmenu#Superscript: v^ : converts visual-mode selected character(s) to a superscripted equivalent (if any) {{{1
fun! mathmenu#Superscript()
"  call Dfunc("mathmenu#Superscript()")

  s/[0₀]/⁰/ge
  s/[1₁]/¹/ge
  s/[2₂]/²/ge
  s/[3₃]/³/ge
  s/[4₄]/⁴/ge
  s/[5₅]/⁵/ge
  s/[6₆]/⁶/ge
  s/[7₇]/⁷/ge
  s/[8₈]/⁸/ge
  s/[9₉]/⁹/ge
  s/[+₊]/⁺/ge
  s/[-₋]/⁻/ge
  s/[*⁎]/ ⃰/ge
  s/</˂/ge
  s/>/˃/ge
  s@/@ˊ@ge
  s/\^/˄/ge
  s/[(₍]/⁽/ge
  s/[)₎]/⁾/ge
"  s/,/ʾ/ge
  s/,/˒/ge
  s/\./˙/ge
  s/=/˭/ge
  s/[aₐ]/ᵃ/ge
  s/b/ᵇ/ge
  s/c/ᶜ/ge
  s/d/ᵈ/ge
  s/[eₑ]/ᵉ/ge
  s/f/ᶠ/ge
  s/g/ᵍ/ge
  s/h/ʰ/ge
  s/[iᵢ]/ⁱ/ge
  s/j/ʲ/ge
  s/k/ᵏ/ge
  s/l/ˡ/ge
  s/m/ᵐ/ge
  s/n/ⁿ/ge
  s/[oₒ]/ᵒ/ge
  s/p/ᵖ/ge
  s/[rᵣ]/ʳ/ge
  s/s/ˢ/ge
  s/t/ᵗ/ge
  s/[uᵤ]/ᵘ/ge
  s/[vᵥ]/ᵛ/ge
  s/[xₓ]/ˣ/ge
  s/w/ʷ/ge
  s/y/ʸ/ge
  s/z/ᶻ/ge
  s/A/ᴬ/ge
  s/B/ᴮ/ge
  s/D/ᴰ/ge
  s/E/ᴱ/ge
  s/G/ᴳ/ge
  s/H/ᴴ/ge
  s/I/ᴵ/ge
  s/J/ᴶ/ge
  s/K/ᴷ/ge
  s/L/ᴸ/ge
  s/M/ᴹ/ge
  s/N/ᴺ/ge
  s/O/ᴼ/ge
  s/P/ᴾ/ge
  s/R/ᴿ/ge
  s/T/ᵀ/ge
  s/U/ᵁ/ge
  s/V/ⱽ/ge
  s/W/ᵂ/ge
  s/β/ᵝ/ge
  s/γ/ᵞ/ge
  s/δ/ᵟ/ge
  s/θ/ᶿ/ge
  s/ι/ᶥ/ge
  s/φ/ᵠ/ge
  s/χ/ᵡ/ge
  s/@\[/⎡/ge
  s/@\]/⎤/ge
  s/@(/⎛/ge
  s/@)/⎞/ge        
  s/_/⎺/ge

"  call Dret("mathmenu#Superscript")
endfun

" ---------------------------------------------------------------------
" mathmenu#Mathify: v& : converts visual-mode selected character(s) to various math-oriented characters {{{1
fun! mathmenu#Mathify()
"  call Dfunc("mathmenu#Mathify()")

  " Mathify: multi-char miscellaneous: {{{2
  s/NEL/∉/ge
  s/EL/∈/ge
  s/CC/ℂ/ge
  s/DD/ⅅ/ge
  s/HH/ℍ/ge 
  s/NN/ℕ/ge
  s/PP/ℙ/ge
  s/RR/ℝ/ge
  s/II/ℐ/ge
  s/QQ/ℚ/ge
  s/WW/𝓦/ge
  s/ZZ/ℤ/ge
  s/1S/∫/ge
  s/2S/∬/ge
  s/3S/∭/ge
  s/&&/∧/ge
  s/||/∨/ge
  s/3\$/∛/ge
  s/4\$/∜/ge
  s/@LB/⎣⎦/ge
  s/@UB/⎡⎤/ge
  
  " Mathify: sets: {{{2
  s/@SUB/⊂/ge
  s/@NSUB/⊄/ge
  s/@ESUB/⊆/ge
  s/@NESUB/⊈/ge
  s/@SUP/⊃/ge
  s/@NSUP/⊅/ge
  s/@ESUP/⊇/ge
  s/@NESUP/⊉/ge
  s/4A/∀/ge
  s/@!/¬/ge
  s/@EX/∃/ge
  s/@NEX/∄/ge
  s/@EMP/∅/ge
  s/@L/ℒ/ge
  s/@A/∀/ge

  " Mathify: operators: {{{2
  s/@SSS/∭/ge
  s/@SS/∬/ge
  s/@S/∫/ge
  s/@\*/×/ge
  s/|/∥/ge
  s/\.:\./∴/ge
  s/:\.:/∵/ge
  s/@D/∆/ge
  s/@G/∇/ge
  s/@o/∘/ge
  s/@\./∙/ge
  s/@x/×/ge
  s/@d/∂/ge
  s/@\~/∼/ge

  " Mathify: punctuation: {{{2
  s/@\./⠂/ge
  s/⠂/⠁/ge
  s/@|/⋮/ge
  s/@-/⋯/ge
  s/@:/∴/ge
  s/@>/≻/ge
  s/@</≺/ge
  s/@\\/⋱/ge
  s/@\//⋰/ge
  s/@a/∂/ge
  s/@L/ℒ/ge
  s/@R/ℜ/ge
  s/@Z/ℤ/ge
"  s/@F/Ḟ/ge
  s/@F/ℱ/ge
  s/@Q/ℚ/ge

  " Mathify: relationals: {{{2
  s/!\~\~/≉/ge
  s/=\~/≅/ge
  s/==/≡/ge
  s/!=/≠/ge
  s/!>=/≱/ge
  s/!<=/≰/ge
  s/!>/≯/ge
  s/!</≮/ge
  s/<=/≤/ge
  s/>=/≥/ge
  s/></≷/ge
  s/<>/≶/ge
  s/\~\~/≈/ge
  s/\~</≲/ge
  s/\~>/≳/ge
  s/!\~/≁/ge

  " Mathify: arrows: {{{2
  s/->/→/ge
  s/<-/←/ge
  s/<=>/⟺/ge
  s/=>/⇒/ge
  s/=</⇐/ge
  s/-/―/ge
  s/(>/↻/ge
  s/)>/↺/ge
  s/|^/↑/ge
  s/|v/↓/ge
  s/<)/↻/ge
  s/(>/↺/ge

  " Mathify: fractions: {{{2
  s/2\/3/⅔/ge
  s/3\/4/¾/ge
  s/2\/5/⅖/ge
  s/3\/5/⅗/ge
  s/4\/5/⅘/ge
  s/5\/6/⅚/ge
  s/3\/8/⅜/ge
  s/5\/8/⅝/ge
  s/7\/8/⅞/ge
  s/2/½/ge
  s/3/⅓/ge
  s/4/¼/ge
  s/5/⅕/ge
  s/6/⅙/ge
  s/8/∞/ge

  " Mathify: miscellaneous: {{{2
  s/\./∙/ge
  s/\$/√/ge
  s/+―/±/ge
  s/―+/∓/ge
  s/\*/∏/ge
  s/+/∑/ge
  s/@s/§/ge
  s@∠@⁄@ge
  s@/@∠@ge

  "  Mathify: lower case Greek: {{{2
  s/@f/ϕ/ge
  s/@p/ϖ/ge
  s/@r/ϱ/ge
  s/@u/ϑ/ge
  s/a/α/ge
  s/b/β/ge
  s/c/ψ/ge
  s/d/δ/ge
  s/e/ϵ/ge
  s/ve/ε/ge
  s/f/φ/ge
  s/g/γ/ge
  s/h/η/ge
  s/i/ι/ge
  s/j/ξ/ge
  s/k/κ/ge
  s/l/λ/ge
  s/m/μ/ge
  s/n/ν/ge
  s/o/ο/ge
  s/p/π/ge
  s/r/ρ/ge
  s/s/σ/ge
  s/vs/ς/ge
  s/t/τ/ge
  s/vu/ϑ/ge
  s/u/θ/ge
  s/y/υ/ge
  s/w/ω/ge
  s/x/χ/ge
  s/z/ζ/ge

  "  Mathify: upper case Greek: {{{2
  s/A/Α/ge
  s/B/Β/ge
  s/C/Ψ/ge
  s/D/Δ/ge
  s/E/Ε/ge
  s/F/Φ/ge
  s/G/Γ/ge
  s/H/Η/ge
  s/I/Ι/ge
  s/J/Ξ/ge
  s/K/Κ/ge
  s/L/Λ/ge
  s/M/Μ/ge
  s/N/Ν/ge
  s/O/Ο/ge
  s/P/Π/ge
  s/R/Ρ/ge
  s/S/Σ/ge
  s/T/Τ/ge
  s/U/Θ/ge
  s/V/Ω/ge
  s/X/Χ/ge
  s/Y/Υ/ge
  s/Z/Ζ/ge

"  call Dret("mathmenu#Mathify")
endfun

" ---------------------------------------------------------------------
" mathmenu#ToggleKeymap: toggles between math keymap and previous/no keymap {{{2
fun! mathmenu#ToggleKeymap()
"  call Dfunc("mathmenu#ToggleKeymap()")
  if !exists("s:kmp")
   let s:kmp= &l:kmp
  endif
  if &l:kmp == "math"
   " turn keymap from math mode to whatever preceded mathmode
   let &l:kmp= s:kmp
   exe 'sil! nunmenu '.g:DrChipTopLvlMenu.'MathKeys.SetKeymap'
   exe 'sil! iunmenu '.g:DrChipTopLvlMenu.'MathKeys.SetKeymap'
   exe 'sil! nunmenu '.g:DrChipTopLvlMenu.'MathKeys.UnsetKeymap'
   exe 'sil! iunmenu '.g:DrChipTopLvlMenu.'MathKeys.UnsetKeymap'
   exe "nmenu <silent> ".g:DrChipTopLvlMenu."MathKeys.SetKeymap	:call mathmenu#ToggleKeymap()\<cr>"
   exe "imenu <silent> ".g:DrChipTopLvlMenu."MathKeys.SetKeymap	\<c-o>:call mathmenu#ToggleKeymap()\<cr>"
  else
   " turn keymap to math mode
   setl kmp=math
   exe 'sil! nunmenu '.g:DrChipTopLvlMenu.'MathKeys.SetKeymap'
   exe 'sil! iunmenu '.g:DrChipTopLvlMenu.'MathKeys.SetKeymap'
   exe 'sil! nunmenu '.g:DrChipTopLvlMenu.'MathKeys.UnsetKeymap'
   exe 'sil! iunmenu '.g:DrChipTopLvlMenu.'MathKeys.UnsetKeymap'
   exe "nmenu <silent> ".g:DrChipTopLvlMenu."MathKeys.UnsetKeymap	:call mathmenu#ToggleKeymap()\<cr>"
   exe "imenu <silent> ".g:DrChipTopLvlMenu."MathKeys.UnsetKeymap	\<c-o>:call mathmenu#ToggleKeymap()\<cr>"
  endif
"  call Dret("mathmenu#ToggleKeymap")
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=28 fdm=marker
