"----------------------------------------------------------------------
" Vim syntax file
" Language:     Configuration for the Bird Internet Routing Daemon
" Bird Site:    http://bird.network.cz/
" Maintainer:   Mahlon E. Smith <mahlon@martini.nu>
" Version:      $Id: bird.vim,v bf8f3c788cad 2010/10/01 15:16:47 mahlon $
"----------------------------------------------------------------------

if has( "folding" )
	setlocal foldmethod=syntax
endif

setlocal iskeyword+=;

syntax region  birdInlineComment start=/#/ end=/$/
syntax region  birdBlockComment  start=/^#/ end=/^\([^#]\|$\)/me=e-1 fold
highlight link birdInlineComment Comment
highlight link birdBlockComment  Comment

syntax region  birdString start=/"/ skip=/\\"/ end=/"/
highlight link birdString String

syntax match   birdNetworkAddressIP4 /\d\+\.\d\+\.\d\+\.\d\+\(\/\d\+\)\?/
highlight link birdNetworkAddressIP4 Character

syntax match   birdNumber / \d\+\(;\|\s\|$\)/
highlight link birdNumber Number

syntax match   birdOperator /\(+\|-\|*\|\/\|(\|)\|=\|<\|>\|!\|&&\|||\|\~\)/
highlight link birdOperator Operator

syntax region  birdFunctionArguments start=/(/ end=/)/ oneline
syntax region  birdFunction matchgroup=birdFunctionArguments start=/\S\+(/ end=/)/ oneline transparent
highlight link birdFunctionArguments Function

syntax cluster birdCommon contains=birdInlineComment,birdString,birdNetworkAddressIP4,birdNumber,birdOperator,birdFunction

syntax keyword birdGlobals define table eval
syntax match   birdGlobals /\(router id\|listen bgp\) /
highlight link birdGlobals PreProc

syntax region  birdLog start=/^log / end=/$/ keepend contains=@birdCommon,birdLogOptions,birdLogDirective,birdLogLevels
syntax keyword birdLogOptions syslog stderr contained
syntax keyword birdLogLevels all all; info warning error fatal trace remote auth bug contained
syntax keyword birdLogDirective log contained
highlight link birdLogOptions   Identifier
highlight link birdLogDirective PreProc
highlight link birdLogLevels    Special
highlight link birdLog          Normal

syntax region  birdDebug start=/debug / end=/$/ keepend contains=@birdCommon,birdDebugOptions,birdDebugDirective,birdDebugTypes
syntax keyword birdDebugOptions protocols commands contained
syntax keyword birdDebugTypes all all; off off; states routes filters interfaces events packets messages contained
syntax keyword birdDebugDirective debug contained
highlight link birdDebugOptions   Identifier
highlight link birdDebugDirective PreProc
highlight link birdDebugTypes     Special
highlight link birdDebug          Normal

syntax region  birdMrt start=/mrtdump / end=/$/ keepend contains=@birdCommon,birdMrtOptions,birdMrtDirective,birdMrtTypes
syntax keyword birdMrtOptions protocols contained
syntax keyword birdMrtTypes all all; off off; states messages contained
syntax keyword birdMrtDirective mrtdump contained
highlight link birdMrtOptions   Identifier
highlight link birdMrtDirective PreProc
highlight link birdMrtTypes     Special
highlight link birdMrt          Normal

syntax cluster birdProtoShared contains=birdGlobals,birdDebug,birdMrt

syntax region  birdTimeFormat start=/^timeformat / end=/$/ keepend contains=@birdCommon,birdTimeFormatDirective,birdTimeFormatTypes
syntax keyword birdTimeFormatTypes route protocol base log contained
syntax keyword birdTimeFormatDirective timeformat contained
highlight link birdTimeFormatDirective PreProc
highlight link birdTimeFormatTypes     Identifier
highlight link birdTimeFormat          Normal

syntax region  birdImportExport start=/\(import\|export\) / end=/$/  contains=@birdCommon,birdImportExportDirective,birdImportExportTypes,birdFilter,birdFilterProtoConstants,birdFilterAttributes
syntax keyword birdImportExportDirective import export contained
syntax keyword birdImportExportTypes all all; none none; where contained
highlight link birdImportExportDirective Type
highlight link birdImportExportTypes     Special
highlight link birdImportExport          Normal

syntax region  birdProtocol start=/^protocol / end=/^}/ contains=@birdCommon,@birdProtoShared,birdProtocolDirective,birdProtocolTypes,birdProtocolMisc,birdProtocolGlobals,birdImportExport,birdProtocolDisabled,birdProtocolBools,birdProtocolDate,birdFilter,birdProtocolAttributes fold
syntax keyword birdProtocolDirective protocol area interface networks stubnet neighbors contained
syntax match   birdProtocolDirective /virtual link / contained
syntax keyword birdProtocolTypes bgp device direct kernel ospf pipe rip static contained
syntax keyword birdProtocolMisc as via self self; drop drop; ignore ignore; normal; large; broadcast; nonbroadcast nonbroadcast; pointopoint; none; simple; plain; md5; cryptographic; eligible; opaque; transparent; always; never; neighbor; multicast; reject; prohibit; contained
syntax keyword birdProtocolGlobals preference description id password type local neighbor multihop passive passive; persist persist; learn learn; primary rfc1583compat rfc1583compat; tick hidden hidden; summary summary; cost stub stub; hello poll retransmit priority wait authentication strict honor port infinity period mode route contained
syntax match   birdProtocolGlobals /generate from\|generate to\|accept from\|accept to\|next hop\|missing lladdr\|source address\|rr client\|rr cluster id\|rs client\|enable route refresh\|interpret communities\|enable as4\|capabilities\|advertise ipv4\|route limit\|disable after error\|\(startup \)\?hold time\|\(scan\|keepalive\|timeout\|garbage\|connect retry\|start delay\|error \(wait\|forget\)\) time\|path metric\|prefer older\|default bgp_med\|default bgp_local_pref\|device routes\|\(kernel\|peer\) table\|stub cost\|dead\( count\)\?\|rx buffer/ contained
syntax match   birdProtocolDate /\d\{2\}-\d\{2\}-\d\{4\} \d\{2\}:\d\{2\}:\d\{2\}/ contained
syntax keyword birdProtocolDisabled disabled disabled; contained
syntax keyword birdProtocolBools yes yes; no no; contained
syntax match   birdProtocolAttributes /bgp_path\|bgp_local_pref\|bgp_med\|bgp_origin\|bgp_next_hop\|bgp_atomic_aggr\|bgp_community\|bgp_originator_id\|bgp_cluster_list\|ospf_metric1\|ospf_metric2\|ospf_tag\|rip_metric\|rip_tag/ contained
highlight link birdProtocolDirective  PreProc
highlight link birdProtocolTypes      Function
highlight link birdProtocolMisc       String
highlight link birdProtocolGlobals    Constant
highlight link birdProtocolDisabled   Error
highlight link birdProtocolBools      Boolean
highlight link birdProtocolDate		  Number
highlight link birdProtocolAttributes Identifier
highlight link birdProtocol           Normal

syntax keyword birdInternalFunctions accept accept; reject reject; print printn return quitbird defined contained
syntax keyword birdInternalControls if then else case contained
syntax keyword birdInternalTypes bool int pair quad string ip prefix enum bgppath bgpmask clist contained
highlight link birdInternalFunctions Keyword
highlight link birdInternalControls  Conditional
highlight link birdInternalTypes     Type

" inline, named filters
syntax match   birdFilter /filter.\+$/ contains=@birdCommon,birdFilterDirective
" filter definitions
syntax region  birdFilter start=/^filter\(\s\+\S\+\)\?\s\+/ end=/^}$/ fold contains=@birdCommon,birdFilterDirective,birdFilterProtoConstants,birdInternalFunctions,birdFilterAttributes,birdInternalControls,birdInternalTypes,birdProtocolAttributes
" inline complex filters
syntax region  birdFilter start=/filter\s\+{/ end=/};/ fold contains=@birdCommon,birdFilterDirective,birdFilterProtoConstants,birdInternalFunctions,birdFilterAttributes,birdInternalControls,birdInternalTypes,birdProtocolAttributes
syntax match   birdFilterDirective /filter/ nextgroup=birdFilterName skipwhite contained
syntax match   birdFilterName /[^{;]\+/ skipwhite contained
syntax match   birdFilterProtoConstants /\(RTS_DUMMY\|RTS_STATIC\|RTS_INHERIT\|RTS_DEVICE\|RTS_STATIC_DEVICE\|RTS_REDIRECT\|RTS_RIP\|RTS_OSPF\|RTS_OSPF_IA\|RTS_OSPF_EXT1\|RTS_OSPF_EXT2\|RTS_BGP\|RTS_PIPE\)/ contained
syntax keyword birdFilterAttributes net scope preference from gw proto source cast dest contained
highlight link birdFilterDirective      PreProc
highlight link birdFilterName           Function
highlight link birdFilterProtoConstants Underlined
highlight link birdFilterAttributes     Identifier
highlight link birdFilter               Normal

syntax region  birdFunctionDef start=/^function\(\s\+\S\+\)\?\s\+/ end=/^}$/ fold contains=@birdCommon,birdFunctionDirective,birdInternalFunctions,birdInternalControls,birdInternalTypes
syntax match   birdFunctionDirective /function / nextgroup=birdFunctionName skipwhite contained
syntax match   birdFunctionName /[^(]\+/ skipwhite contained
highlight link birdFunctionDirective PreProc
highlight link birdFunctionName      Function
highlight link birdFunctionDef       Normal

let b:current_syntax = "bird"

