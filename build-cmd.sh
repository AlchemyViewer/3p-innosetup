#!/usr/bin/env bash

cd "$(dirname "$0")"

# turn on verbose debugging output for logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x
# make errors fatal
set -e
# bleat on references to undefined shell variables
set -u

PKG_SOURCE_DIR="innosetup"
PKG_VERSION="6.2.2"

top="$(pwd)"
stage="$top"/stage
stage_innosetup="$stage/innosetup"

# load autobuild provided shell functions and variables
case "$AUTOBUILD_PLATFORM" in
    windows*)
        autobuild="$(cygpath -u "$AUTOBUILD")"
    ;;
    *)
        autobuild="$AUTOBUILD"
    ;;
esac
source_environment_tempfile="$stage/source_environment.sh"
"$autobuild" source_environment > "$source_environment_tempfile"
. "$source_environment_tempfile"

echo "${PKG_VERSION}" > "${stage}/VERSION.txt"

# Create the staging license folder
mkdir -p "$stage/LICENSES"

#Create the staging debug and release folders
mkdir -p "$stage_innosetup"

cp -a $PKG_SOURCE_DIR/* "$stage_innosetup"

# Copy License
cp "LICENSE" "$stage/LICENSES/innosetup.txt"
