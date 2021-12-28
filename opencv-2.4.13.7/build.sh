#!/bin/bash
set -e

ANDROID_HOME=/Users/heejin/Library/Android
ANDROID_NDK=/Users/heejin/Library/Android/sdk/ndk/21.0.6113669-fixed

# arm
mkdir -p build-armeabi-v7a
cd build-armeabi-v7a
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="armeabi-v7a" -DANDROID_ARM_NEON=ON -DANDROID_PLATFORM=android-21 \
    -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release \
    `cat ../../opencv2_cmake_options.txt` -DBUILD_opencv_world=OFF ..
cmake --build . -j9
cmake --build . --target install
cd ..

# arm64
mkdir -p build-arm64-v8a
cd build-arm64-v8a
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="arm64-v8a" -DANDROID_PLATFORM=android-21 \
    -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release \
    `cat ../../opencv2_cmake_options.txt` -DBUILD_opencv_world=OFF ..
cmake --build . -j9
cmake --build . --target install
cd ..

# package
mkdir -p final_package
cp -rf build-armeabi-v7a/install/* final_package/
cp -rf build-arm64-v8a/install/* final_package/
