#
# Copyright:: Copyright (c) 2013 Robby Dyer
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
name "perl"
version "5.18.1"

source :url => "http://www.cpan.org/src/5.0/perl-5.18.1.tar.gz",
       :md5 => "304cb5bd18e48c44edd6053337d3386d"

relative_path "perl-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command [
            "sh Configure",
            "-de",
            "-Dprefix=#{install_dir}/embedded",
            "-Duseshrplib", ## Compile shared libperl
            "-Dusethreads" ## Compile ithread support
           ].join(" "), :env => env
  command "make -j #{max_build_jobs}"
  command "make install", :env => env
end
