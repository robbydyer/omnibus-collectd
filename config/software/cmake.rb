# This is an example software definition for a C project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "cmake"
version "2.8.11.2"

dependency "libidn"

source :url => "http://www.cmake.org/files/v2.8/cmake-#{version}.tar.gz",
       :md5 => "6f5d7b8e7534a5d9e1a7664ba63cf882"

relative_path "cmake-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./bootstrap",
           "--prefix=#{install_dir}/embedded",
           ].join(" ")
  command "make -j #{max_build_jobs}"
  command "make install"
end
