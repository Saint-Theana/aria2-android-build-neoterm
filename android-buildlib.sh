ZLIB=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/zlib1.2.11.tar.gz
EXPAT=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/expat-2.2.0.tar.bz2
CARES=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/c-ares1.13.0.tar.gz
OPENSSL=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/openssl-1.1.0g.tar.gz
SQLITE3=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/sqlite-3.21.0.tar.gz
LIBSSH2=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/libssh2-1.8.1_dev.tar.gz
ARIA2=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/aria2-1.33.1.tar.gz

ANDROID_HOME=/data/data/io.neoterm/files/home/aria2/



apt install pkg-config
DOWNLOADER="wget -c"
TOOLCHAIN=$ANDROID_HOME/toolchain
PATH=$TOOLCHAIN/bin:$PATH
HOST=aarch64-linux-android
PREFIX=$ANDROID_HOME/usr/local
LOCAL_DIR=$ANDROID_HOME/usr/local
TOOL_BIN_DIR=$ANDROID_HOME/toolchain/bin
PATH=${TOOL_BIN_DIR}:$PATH
CFLAGS="-march=armv8-a -mtune=cortex-a73"
aarch="aarch64"
DEST=$ANDROID_HOME/usr/local
CC=$HOST-gcc
CXX=$HOST-g++
LDFLAGS="-L$DEST/lib"
CPPFLAGS="-I$DEST/include"
CXXFLAGS=$CFLAGS

cd /tmp
#
 # zlib library build
  $DOWNLOADER $ZLIB
  tar xvf zlib1.2.11.tar.gz
  cd zlib-1.2.11/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=clang STRIP=$TOOL_BIN_DIR/strip RANLIB=$TOOL_BIN_DIR/ranlib CXX=$TOOL_BIN_DIR/clang++ AR=$TOOL_BIN_DIR/ar LD=$TOOL_BIN_DIR/ld ./configure --prefix=$PREFIX --static
  make
  make install
#
#
 # expat library build
  cd /tmp
  $DOWNLOADER $EXPAT
  tar jxvf expat-2.2.0.tar.bz2
  cd expat-2.2.0/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` --prefix=$PREFIX --enable-static=yes --enable-shared=no
  make
  make install
#
#
 # c-ares library build
  cd /tmp
  $DOWNLOADER $CARES
  tar zxvf c-ares1.13.0.tar.gz
  cd c-ares-1.13.0/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` --prefix=$PREFIX --enable-static --disable-shared
  make
  make install
#
 # openssl library build
  cd /tmp
  $DOWNLOADER $OPENSSL
  tar zxvf openssl-1.1.0g.tar.gz
  cd openssl-1.1.0g/
  PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./Configure linux-$aarch $CFLAGS --prefix=$PREFIX shared zlib zlib-dynamic --with-zlib-lib=$LOCAL_DIR/lib --with-zlib-include=$LOCAL_DIR/include
  make CC=$CC
  make install_sw
#
#
 # libssh2 library build
  cd /tmp
  $DOWNLOADER $LIBSSH2
  tar zxvf libssh2-1.8.1_dev.tar.gz
  cd libssh2/
  rm -rf $PREFIX/lib/pkgconfig/libssh2.pc
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ AR=$HOST-ar RANLIB=$HOST-ranlib CPPFLAGS="-I$ANDROID_HOME/usr/local/include" LDFLAGS="-L$ANDROID_HOME/usr/local/lib -lssl -lcrypto" ./configure --prefix="$ANDROID_HOME/usr/local/" --with-openssl --with-libssl-prefix=$ANDROID_HOME/usr/local/ --host=$HOST
  make
  make install

cd /tmp
  $DOWNLOADER $SQLITE3
  tar zxvf sqlite-3.21.0.tar.gz
  cd sqlite-autoconf-3210000/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --prefix=$PREFIX --enable-static --enable-shared 
  make
  make install
  cd /tmp
  wget https://raw.githubusercontent.com/Saint-Theana/aria2-android-static-build/master/libdl/libdl.c
  $PREFIX/toolchain/bin/clang -c libdl.c
$PREFIX/toolchain/bin/a*-linux-android*-ar srv libdl.a libdl.o
mkdir -p $PREFIX/usr/local/lib
cp libdl.a $PREFIX/usr/local/lib
cp libdl.a $PREFIX/usr/local/lib/libpthread.a
cp libdl.a $PREFIX/usr/local/lib/librt.a
  
  rm -rf c-ares*
  rm -rf sqlite-autoconf*
  rm -rf zlib-*
  rm -rf expat-*
  rm -rf openssl-*
  rm -rf libssh2-*
  rm -rf libdl*
#
 echo "all complete!"