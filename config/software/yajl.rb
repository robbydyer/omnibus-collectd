# This is an example software definition for a C project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "yajl"
version "2.0.1"

dependency "cmake"

source :path => "/vagrant/yajl-#{version}"

relative_path "yajl-2.0.1"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command [
            "PATH=#{install_dir}/embedded/bin:$PATH ;",
            "./configure",
            "--prefix=#{install_dir}/embedded",
           ].join(" "), :env => env
  command "make install"
end
