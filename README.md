```shell
#准备
#preparation
apt install git wget perl pkg-config python make -y

#下载ndk
#download ndk
cd ~
git clone https://github.com/SaintcTheana/ndk_for_android


#创建工作目录
#create workspace
mkdir aria2
mkdir aria2/usr
mkdir aria2/usr/local
mkdir aria2/usr/local
cd ndk_for_android

#生成编译工具链
#generate toolchain
build/tools/make_standalone_toolchain.py --arch arm64 --api 28 --stl libc++ --install-dir ../aria2/toolchain -v -v --force
ln -s /data/data/io.neoterm/files/home/aria2/toolchain/aarch64-linux-android/bin/* /data/data/io.neoterm/files/home/aria2/toolchain/bin

#下载编译zlib
#download and compile zlib
cd /data/data/io.neoterm/files/usr/tmp
git clone https://github.com/Saint-Theana/zlib-for-android-aria2
cd zlib-for-android-aria2
bash android-config
make -j8
make install

#下载编译expat
#download and compile expat
cd /data/data/io.neoterm/files/usr/tmp
git clone https://github.com/Saint-Theana/expat-for-android-aria2
cd expat-for-android-aria2
bash android-config
make -j8
make install

#下载编译cares
#download and compile cares
#编译这玩意要很长时间，configure阶段卡住正常，等吧骚年
#compile this might take a very long time.stuck in configure was normal,have some patiance.
cd /data/data/io.neoterm/files/usr/tmp
git clone https://github.com/Saint-Theana/cares-for-android-aria2
cd cares-for-android-aria2
bash android-config
make -j8
make install

#下载编译openssl
#download and compile openssl
cd /data/data/io.neoterm/files/usr/tmp
git clone https://github.com/Saint-Theana/openssl-for-android-aria2
cd openssl-for-android-aria2
bash android-config
make -j8
make install_sw


#下载编译libssh2
#download and compile libssh2
cd /data/data/io.neoterm/files/usr/tmp
git clone https://github.com/Saint-Theana/libssh2-for-android-aria2
cd libssh2-for-android-aria2
bash android-config
make -j8
make install



#下载编译sqlite3
#download and compile sqlite3
cd /data/data/io.neoterm/files/usr/tmp
git clone https://github.com/Saint-Theana/sqlite3-for-android-aria2
cd sqlite3-for-android-aria2
tar -xvf sqlite-snapshot-202011020040.tar.gz
cd sqlite-snapshot-202011020040
cp ../android-config .
bash android-config
make -j8
make install

#下载编译aria2
#download and compile aria2
cd /data/data/io.neoterm/files/usr/tmp
git clone https://github.com/Saint-Theana/aria2-android-build-neoterm
cd aria2-android-build-neoterm
tar -xvf aria2.tar.gz
cd aria2-1.35.0
bash android-config
ln -s /data/data/io.neoterm/files/home/aria2/usr/local/lib/libz.a /data/data/io.neoterm/files/home/aria2/usr/local/lib/libpthread.a
ln -s /data/data/io.neoterm/files/home/aria2/usr/local/lib/libz.a /data/data/io.neoterm/files/home/aria2/usr/local/lib/librt.a
make -j8
make install

```
