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
                #"net-snmp",
                #"rrdtool",
                "yajl",
                "libpcap",
                "jdk",
                "liboping"
                #"libmemcached",
                #"librabbitmq",
                #"libvirt" 
            ]
                

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
    command [   
                "export PATH=#{install_dir}/embedded/bin:$PATH;",
                "./configure",
                "--prefix=#{install_dir}/embedded",
                "--with-python=#{install_dir}/embedded/bin/python",
                "--with-libyajl=#{install_dir}/embedded/lib",
                "--with-libperl=#{install_dir}/embedded/lib/perl5",
                "--with-java=#{install_dir}/embedded/jdk",
                #"--disable-debug",
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
                "--enable-ethstat",
                "--enable-exec",
                "--enable-filecount",
                "--enable-fscache",
                "--enable-hddtemp",
                "--enable-interface",
                "--enable-ipvs",
                "--enable-java",
                #"--enable-libvirt",
                "--enable-load",
                "--enable-logfile",
                "--enable-md",
                "--enable-memory",
                "--enable-multimeter",
                #"--enable-mysql",
                "--enable-network",
                "--enable-nfs",
                "--enable-nginx",
                "--enable-ntpd",
                #"--enable-perl", ## needs perl
                "--enable-ping", ## needs liboping -> needs perl-ExtUtils-MakeMaker
                "--enable-processes",
                "--enable-protocols",
                "--enable-python",
                #"--enable-rrdtool",
                #"--enable-sensors",
                "--enable-serial",
                #"--enable-snmp", ## needs snmp, perl
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
