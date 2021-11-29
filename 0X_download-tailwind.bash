tailwind_version=2.2.19
dir_of_this_file="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
tailwind_dir=${dir_of_this_file}/lib/tw/css

rm ${tailwind_dir}/tailwind.min.css

mkdir -p ${tailwind_dir}
wget \
  --directory-prefix=${tailwind_dir} \
  https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/${tailwind_version}/tailwind.min.css
