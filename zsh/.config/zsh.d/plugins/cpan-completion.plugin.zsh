export ZPWR_CPAN_MIN_PREFIX=2

function __cpan_single_module() {

    local name tarball

    for (( ; i <= $#searchLines; ++i )); do
        package=$searchLines[$i]
        if [[ $package == (#b)(Module[[:space:]]##id[[:space:]]##=[[:space:]]##)([^[:space:]]##)* ]]; then
            name="${match[2]//:/\\:}"
        fi
        if [[ $package == (#b)([[:space:]]##CPAN_FILE[[:space:]]##)([^[:space:]]##)* ]]; then
            tarball="${match[2]//:/\\:}"
        fi

        if [[ -n $name && -n $tarball ]]; then
            ary+=("$name:$tarball")
            break
        fi

    done

    if (( $#ary )); then
        _describe -t cpan-module 'CPAN modules' ary
    fi
}

function __cpan_multiple_modules () {

    local name tarball

    local cpan_cache_file
    local -a tmp_ary
    cpan_cache_file="cpan_${PREFIX}_cache"

    if ! _retrieve_cache $cpan_cache_file; then
        for (( ; i <= $#searchLines; ++i )); do
            package=$searchLines[$i]
            if [[ $package == (#b)(Module[[:space:]]##\<[[:space:]]##)([^[:space:]]##)[[:space:]]##([^[:space:]]##)* ]]; then
                name="${match[2]//:/\\:}"
                tarball="${match[3]//:/\\:}"
                tmp_ary+=("$name:$tarball")
            fi
        done
        if (( $#tmp_ary )); then
            _store_cache $cpan_cache_file tmp_ary
        fi
    fi

    _describe -t cpan-module 'CPAN modules' tmp_ary
}

function __cpan_modules() {

    local ary searchLines package

    searchLines=("${(f@)$(perl -MCPAN -e 'CPAN::Shell->m("/'$1'/")' 2>/dev/null)}")

    for (( i = 1; i <= $#searchLines; ++i )); do
        package=$searchLines[$i]
        if [[ $package == (#b)(Module[[:space:]]##id[[:space:]]##=[[:space:]]##)([^[:space:]]##)* ]]; then
            ((--i))
            __cpan_single_module
            return 0
        elif [[ $package == (#b)(Module[[:space:]]##\<[[:space:]]##)([^[:space:]]##)[[:space:]]##([^[:space:]]##)* ]]; then
            ((--i))
            __cpan_multiple_modules
            return 0
        fi
    done

    unset i

}
