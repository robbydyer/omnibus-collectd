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
name "collectd"
version "5.4.0"


source :url => "http://collectd.org/files/collectd-#{version}.tar.gz",
       :md5 => "d4176b3066f3b85d85343d3648ea43f6"

relative_path "collectd-#{version}"

dependencies [    
                "libgcrypt",
                "libgpg-error",
                "python",
                "setuptools",
                "libtool",
                "curl",
                "openssl",
                "libxml2",
                "iptables",
                "perl-extutils-makemaker",
                "perl-extutils-embed",
                "net-snmp",
                "yajl",
                "libpcap",
                "jdk",
                "liboping",
                "mysql"
            ]
                

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}",
}

build do
    command [   
                "./configure",
                "--prefix=#{install_dir}/embedded",
                "--with-python=#{install_dir}/embedded/bin/python",
                "--with-libyajl=#{install_dir}/embedded/lib",
                "--with-libperl=#{install_dir}/embedded",
                "--with-perl=#{install_dir}/embedded",
                "--with-perl-bindings=\"INSTALL_BASE=#{install_dir}/embedded\"",
                "--with-java=#{install_dir}/embedded/jdk",
                "--disable-static",
                "--enable-aggregation",
                "--enable-bind",
                "--enable-cpu",
                "--enable-cpufreq",
                "--enable-csv",
                "--enable-curl",
                "--enable-curl-json",
                "--enable-curl-xml",
                "--enable-df",
                "--enable-disk",
                "--enable-dns",
                "--enable-email",
                OHAI.platform_version =~ /^5/ ? "" : "--enable-ethstat", # WTF centos 5?
                "--enable-exec",
                "--enable-filecount",
                "--enable-fscache",
                "--enable-hddtemp",
                "--enable-interface",
                OHAI.platform_version =~ /^5/ ? "" :"--enable-ipvs", # centos 5 actin a fool
                "--enable-java",
                #"--enable-libvirt",
                "--enable-load",
                "--enable-logfile",
                "--enable-md",
                "--enable-memory",
                "--enable-multimeter",
                "--enable-mysql",
                "--enable-network",
                "--enable-nfs",
                "--enable-nginx",
                "--enable-ntpd",
                "--enable-perl", ## needs perl
                "--enable-ping", ## needs liboping -> needs perl-ExtUtils-MakeMaker
                "--enable-processes",
                "--enable-protocols",
                "--enable-python",
                #"--enable-sensors",
                "--enable-serial",
                "--enable-snmp", ## needs snmp, perl
                "--enable-swap",
                "--enable-syslog",
                "--enable-table",
                "--enable-tail",
                "--enable-tail-csv",
                "--enable-tcpconns",
                "--enable-threshold",
                "--enable-unixsock",
                "--enable-uptime",
                "--enable-users",
                "--enable-uuid",
                "--enable-vmem",
                "--enable-write-graphite",
                "--enable-write-http",
                #"--enable-write-riemann"
            ].join(" "), :env => env
    
    command "make -j #{max_build_jobs}", :env => env
    command "make install"
                
end
