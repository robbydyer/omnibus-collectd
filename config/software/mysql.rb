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

  ## These fixes courtesy of linuxfromscratch.org
  ##  First two seds fix client-only builds. Last two seds set correct installation directories for some components.
  command [
        '/bin/sed -i "/ADD_SUBDIRECTORY(sql\/share)/d" CMakeLists.txt',
        '/bin/sed -i "s/ADD_SUBDIRECTORY(libmysql)/&\\nADD_SUBDIRECTORY(sql\/share)/" CMakeLists.txt',
        '/bin/sed -i "s@data/test@\${INSTALL_MYSQLSHAREDIR}@g" sql/CMakeLists.txt',
        '/bin/sed -i "s@data/mysql@\${INSTALL_MYSQLTESTDIR}@g" sql/CMakeLists.txt',
          ].join(" && ")

  ## Now we can build it
  command [
            "cmake",
            "-DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded",
            "-DWITH_SSL=system",
            "-DWITH_ZLIB=system", 
            "-DWITH_LIBEVENT=system",
            ".",
           ].join(" "), :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
