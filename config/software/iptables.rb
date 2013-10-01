# This is an example software definition for a C project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "iptables"
version "1.4.7"


source :url => "ftp://ftp.netfilter.org/pub/iptables/iptables-1.4.7.tar.bz2",
       :md5 => "645941dd1f9e0ec1f74c61918d70d52f"

relative_path "iptables-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--disable-debug",
           "--enable-optimize",
           ].join(" "), :env => env

  command "make -j #{max_build_jobs}", :env => env
  command "make install"
end
