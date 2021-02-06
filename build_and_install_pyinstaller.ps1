# $ErrorActionPreference = "Stop"

# configuration area
$PYINSTALLER_VERSION = 'v4.2'

# pyinstaller build process fails on long paths
pushd ~

# download pyinstaller source
$source = "https://github.com/pyinstaller/pyinstaller/archive/$PYINSTALLER_VERSION.zip"
$destination = "pyinstaller.zip"
$ProgressPreference = "SilentlyContinue" # Significantly speeds up Invoke-WebRequest
Invoke-WebRequest $source -OutFile $destination

# unzip pyinstaller source
7z x $destination
rm $destination
mv pyinstaller-*.*/ pyinstaller_src/

# build pyinstaller bootloader
pushd pyinstaller_src/bootloader
python ./waf all
popd

# install pyinstaller python package
pushd pyinstaller_src
python setup.py install
python -m pip show pyinstaller # show version
popd
rm -r -fo pyinstaller_src/

popd