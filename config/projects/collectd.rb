
name "collectd"
maintainer "CHANGE ME"
homepage "CHANGEME.com"

replaces        "collectd"
install_path    "/opt/collectd"
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency "preparation"

# collectd dependencies/components
dependency "collectd"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
