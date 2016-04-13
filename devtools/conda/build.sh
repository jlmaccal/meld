#!/bin/bash

CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_TESTING=OFF"

CMAKE_FLAGS+=" -DCMAKE_BUILD_TYPE=Release"

CUDA_PATH="/usr/local/cuda-7.5"
CMAKE_FLAGS+=" -DCUDA_CUDART_LIBRARY=${CUDA_PATH}/lib64/libcudart.so"
CMAKE_FLAGS+=" -DCUDA_NVCC_EXECUTABLE=${CUDA_PATH}/bin/nvcc"
CMAKE_FLAGS+=" -DCUDA_SDK_ROOT_DIR=${CUDA_PATH}/"
CMAKE_FLAGS+=" -DCUDA_TOOLKIT_INCLUDE=${CUDA_PATH}/include"
CMAKE_FLAGS+=" -DCUDA_TOOLKIT_ROOT_DIR=${CUDA_PATH}/"
CMAKE_FLAGS+=" -DCMAKE_CXX_FLAGS_RELEASE=-I/usr/include/nvidia/"

export EIGEN3_INCLUDE_DIR="/anaconda/envs/_build/include/eigen3/"
export OPENMM_DIR="/anaconda/envs/_build"
export OPENMM_INCLUDE_PATH=$OPENMM_DIR/include
export OPENMM_LIB_PATH=$OPENMM_DIR/lib
export LD_LIBRARY_PATH=$OPENMM_DIR/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH

mkdir build
cd build

ls /anaconda/include

cmake .. $CMAKE_FLAGS
make -j$CPU_COUNT all
make -j$CPU_COUNT install PythonInstall