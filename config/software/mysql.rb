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
name "mysql"
version "5.6.14"

dependencies [
                "libevent",
                "openssl",
                "zlib"
             ]

source  :url => "http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.14.tar.gz",
        :md5 => "52224ce51dbf6ffbcef82be30688cc04"

relative_path "mysql-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "LD_LIBRARY_PATH" => "#{install_dir}/embedded/lib",
}

build do
  patch :source => "mysql-5.6.14-embedded_library_shared-1.patch"
  #patch :source => "patch-mysys_ssl_my_default.patch"
  command [
            "PATH=#{install_dir}/embedded/bin:$PATH;",
            "cmake",
            "-DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded",
            "-DWITH_SSL=#{install_dir}/embedded",
            #"-DWITH_ZLIB=#{install_dir}/embedded", 
            #"-DWITH_LIBEVENT=#{install_dir}/embedded",
            #"-DWITHOUT_SERVER=true",
            ".",
           ].join(" "), :env => env
  command "make", :env => env
  command "make install", :env => env
end
