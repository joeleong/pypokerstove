# pypokerstove

python bindings for [pokerstove](https://github.com/andrewprock/pokerstove)

## Install

### OS X
```sh
brew install boost swig cmake
git clone --recursive http://gitub.com/joeleong/pypokerstove
git apply BOARD_SIZE.patch
mkdir pokerstove/build
pushd pokerstove/build
cmake ../src
make
popd
mkdir build
cd build
cmake ..
make

```
