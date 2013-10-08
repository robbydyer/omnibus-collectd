name "libevent"
version "2.0.21"

source :url => "https://github.com/downloads/libevent/libevent/libevent-#{version}-stable.tar.gz",
       :md5 => "b2405cc9ebf264aa47ff615d9de527a2"

relative_path "libevent-#{version}-stable"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command [
            "./configure",
            "--prefix=#{install_dir}/embedded",
            "--disable-static",
           ].join(" "), :env => env
  command "make -j #{max_build_jobs}"
  command "make install", :env => env
end
