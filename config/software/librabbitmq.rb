# This is an example software definition for a C project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "librabbitmq"
version "1.0.1"


source :url => "https://pypi.python.org/packages/source/l/librabbitmq/librabbitmq-1.0.1.tar.gz",
       :md5 => "7350f2018d789116e861a9e1a83e2e86"

relative_path "librabbitmq-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
    command "#{install_dir}/embedded/bin/python setup.py build --prefix=#{install_dir}/embedded"
    command "#{install_dir}/embedded/bin/python setup.py install --prefix=#{install_dir}/embedded"
end
