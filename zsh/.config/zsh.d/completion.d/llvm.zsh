# FIXME: Add LLVM completions, and remove it when upstream inculde
# clang-doc clang-include-fixer clangd-indexer clang-format clangd has special in completions/
# TODO: diagtool, hmaptool use subcommand, I need write for it
compdef _gnu_generic clang-tidy analyze-build clang-apply-replacements clang-change-namespace clang-check clang-extdef-mapping clang-move clang-offload-bundler clang-offload-wrapper clang-query clang-refactor clang-rename clang-reorder-fields clang-repl clang-scan-deps find-all-symbols intercept-build modularize pp-trace run-clang-tidy scan-build scan-build-py scan-view
# llvm-config llvm-dwarfdump has special in completions/
compdef _gnu_generic llvm-addr2line llvm-cat llvm-cvtres llvm-dis llvm-extract llvm-jitlink-executor llvm-lto llvm-modextract llvm-opt-report llvm-profgen llvm-reduce llvm-stress llvm-tblgen llvm-ar llvm-cfi-verify llvm-cxxdump llvm-dlltool llvm-gsymutil llvm-lib llvm-lto2 llvm-mt llvm-otool llvm-ranlib llvm-rtdyld  llvm-strings llvm-undname llvm-as llvm-cxxfilt llvm-ifs llvm-libtool-darwin llvm-mc llvm-nm llvm-pdbutil llvm-rc llvm-sim llvm-strip llvm-windres llvm-bcanalyzer llvm-cov llvm-cxxmap llvm-dwp llvm-install-name-tool llvm-link llvm-objcopy llvm-PerfectShuffle llvm-readelf llvm-size llvm-symbolizer llvm-xray llvm-bitcode-strip llvm-c-test llvm-diff llvm-exegesis llvm-jitlink llvm-lipo llvm-ml llvm-profdata llvm-readobj llvm-split llvm-tapi-diff dsymutil llvm-dsymutil llvm-mca llvm-objdump
compdef _gnu_generic FileCheck bugpoint lit llc lli lli-child-target obj2yaml opt sancov sanstats split-file verify-uselistorder yaml-bench yaml2obj

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; 
