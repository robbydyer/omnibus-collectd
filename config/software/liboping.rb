# This is an example software definition for a C project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "liboping"
version "1.6.2"

dependency "perl-extutils-makemaker"

source :url => "http://verplant.org/liboping/files/liboping-1.6.2.tar.gz",
       :md5 => "6f3e0d38ea03362476ac3be8b3fd961e"

relative_path "liboping-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command [
            "./configure",
            "--prefix=#{install_dir}/embedded",
           ].join(" "), :env => env

  command [
            "PATH=#{install_dir}/embedded/bin:$PATH;", ## Need to use embedded perl
            "make -j #{max_build_jobs}"
          ].join(" ")

  command "make install", :env => env
end
