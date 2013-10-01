# This is an example software definition for a C project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "rrdtool"
version "1.4.8"

source :url => "http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.8.tar.gz",
       :md5 => "dbe59386db97fd2f2216729facd74ca8"

relative_path "rrdtool-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           ].join(" "), :env => env
  command "make -j #{max_build_jobs}"
  command "make install", :env => env
end
