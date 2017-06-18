pkg_name=hab-applier
pkg_origin=smith
pkg_version="0.1.0"
pkg_maintainer="Nathan L Smith <smith@nlsmith.com>"
pkg_license=('Apache-2.0')
pkg_deps=(
  core/bash
  core/findutils
  smith/fswatch
  core/git
  core/hab-butterfly
)
pkg_build_deps=(core/sed)
pkg_bin_dirs=(bin)
pkg_description="Watch for and apply Habitat configuration for a directory of TOML files."
pkg_upstream_url="https://github.com/smith/hab-applier"

do_build() {
  return 0
}

do_install() {
  install -v -m 0755 "$SRC_PATH/bin/$pkg_name" "$pkg_prefix/bin/$pkg_name"

  sed \
    -e "1c#!$(pkg_path_for bash)/bin/bash" \
    -e "s,@author@,$pkg_maintainer," \
    -e "s,@version@,$pkg_version/$pkg_release," \
    -i "$pkg_prefix/bin/$pkg_name"
}

do_strip() {
  return 0
}
