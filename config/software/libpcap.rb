# This is an example software definition for a C project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "libpcap"
version "1.4.0"

source :url => "http://www.tcpdump.org/release/libpcap-#{version}.tar.gz",
       :md5 => "56e88a5aabdd1e04414985ac24f7e76c"

relative_path "libpcap-#{version}"

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
