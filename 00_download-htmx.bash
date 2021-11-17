htmx_version=1.6.0
dir_of_this_file="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
htmx_dir=${dir_of_this_file}/public/js/htmx/${htmx_version}
htmx_extensions_dir=${htmx_dir}/ext


mkdir -p ${htmx_dir}
wget \
  --directory-prefix=${htmx_dir} \
  https://unpkg.com/htmx.org@${htmx_version}/dist/htmx.min.js


mkdir -p ${htmx_extensions_dir}
wget \
  --directory-prefix=${htmx_extensions_dir} \
  https://unpkg.com/htmx.org@${htmx_version}/dist/ext/json-enc.js \
  https://unpkg.com/htmx.org@${htmx_version}/dist/ext/debug.js \
  https://unpkg.com/htmx.org@${htmx_version}/dist/ext/include-vals.js \
  ;
