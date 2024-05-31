#!/bin/bash
set -e

ANDROID_HOME=/Users/heejinlee/Library/Android
ANDROID_NDK=/Users/heejinlee/Library/Android/sdk/ndk/23.1.7779620

# arm
mkdir -p build-armeabi-v7a
cd build-armeabi-v7a
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="armeabi-v7a" -DANDROID_ARM_NEON=ON -DENABLE_NEON=ON -DANDROID_PLATFORM=android-21 \
    -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release \
    `cat ../../opencv3_cmake_options.txt` -DBUILD_opencv_world=OFF ..
cmake --build . -j9
cmake --build . --target install
cd ..

# arm64
mkdir -p build-arm64-v8a
cd build-arm64-v8a
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="arm64-v8a" -DANDROID_PLATFORM=android-21 \
    -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release \
    `cat ../../opencv3_cmake_options.txt` -DBUILD_opencv_world=OFF ..
cmake --build . -j9
cmake --build . --target install
cd ..

# x86
mkdir -p build-x86
cd build-x86
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="x86" -DANDROID_PLATFORM=android-21 \
    -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release \
    `cat ../../opencv3_cmake_options.txt` -DBUILD_opencv_world=OFF ..
cmake --build . -j9
cmake --build . --target install
cd ..

# x86_64
mkdir -p build-x86_64
cd build-x86_64
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="x86_64" -DANDROID_PLATFORM=android-21 \
    -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release \
    `cat ../../opencv3_cmake_options.txt` -DBUILD_opencv_world=OFF ..
cmake --build . -j9
cmake --build . --target install
cd ..

# package
mkdir -p final_package
cp -rf build-armeabi-v7a/install/* final_package/
cp -rf build-arm64-v8a/install/* final_package/
cp -rf build-x86/install/* final_package/
cp -rf build-x86_64/install/* final_package/
