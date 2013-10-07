name "net-snmp"
version "5.7.2"

dependency "openssl"
dependency "perl-extutils-makemaker"

source  :url => "http://downloads.sourceforge.net/project/net-snmp/net-snmp/#{version}/net-snmp-#{version}.tar.gz", ## Dear Sourceforge, kill yourself.
        :md5 => "5bddd02e2f82b62daa79f82717737a14"

relative_path "net-snmp-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CPPFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "LD_LIBRARY_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command [ 
            "PATH=#{install_dir}/embedded/bin:$PATH;", ## Need to use embedded perl binary
            "./configure",
            "--prefix=#{install_dir}/embedded",
            "--disable-debugging",
            "--disable-embedded-perl",
           ].join(" "), :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
