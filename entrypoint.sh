#!/bin/bash

function log()
{
  echo "::${1}::${*:2}"
}

function warning()
{
  log warning "${*}"
}

function debug()
{
  log debug "${*}"
}

version=${1:-latest}
project_id=15462818
gitlab="https://gitlab.com/api/v4/projects"

releases=$(curl -s "${gitlab}/${project_id}/releases" | jq -cr '.[].tag_name')
latest=$(echo "${releases}" | head -n 1)

if [[ "${version}" == "latest" ]]
then
  version=${latest}
  debug "Found ${version} latest release"
elif ! grep -q "${version}" <<< "${releases}"
then
  warning "Not found ${version} release"
  version=${latest}
fi

debug "Installing ${version} release..."

release_source=$(curl -s "${gitlab}/${project_id}/releases/${version}" | jq -rc '.assets.sources[] | select( .format == "tar.gz" ).url')

wget -qO- "${release_source}" | tar -xvz > /dev/null

eigen_install_dir="${GITHUB_WORKSPACE}/Eigen3"
eigen_dir="eigen-${version}"

cmake -E make_directory build
cmake "${eigen_dir}" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${eigen_install_dir}" -DEIGEN_BUILD_PKGCONFIG=ON
cmake --install . --config Release

cmake_module_path="${eigen_install_dir}/share/eigen3/cmake"
pkg_config_path="${eigen_install_dir}/share/pkgconfig"

# shellcheck disable=SC2046
cp $(ls -d "${eigen_dir}"/cmake/*.cmake) "${cmake_module_path}"

{
  echo "Eigen3_DIR=${cmake_module_path}"
  echo "Eigen3_Dir=${cmake_module_path}"
  echo "PKG_CONFIG_PATH=${pkg_config_path}"
} >> "${GITHUB_ENV}"


debug "Successfully setup Eigen3 of ${version} version"