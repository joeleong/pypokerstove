# pypokerstove

python bindings for [pokerstove](https://github.com/andrewprock/pokerstove)

## Dependencies
### Linux
`sudo apt-get install cmake libboost-all-dev swig`

### OS X
`brew install boost cmake swig`

## Install
```sh
git clone --recursive http://gitub.com/joeleong/pypokerstove

# pokerstove patches
git apply patches/*.patch

# build pokerstove/libs
mkdir pokerstove/build
pushd pokerstove/build
cmake ../src
make
popd

# build pypokerstove (python bindings)
mkdir build
cd build
cmake ..
make

# install bindings (-e for develop)
pip install .
```

### Dockerfile
There is also a Dockerfile for Linux dev

```sh
docker build -t pypokerstove .
docker run -it pypokerstove
```
