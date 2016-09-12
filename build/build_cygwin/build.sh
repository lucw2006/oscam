#!/bin/sh
plat=cygwin
plat_dir=build_cygwin
TOOLCHAIN=i686-pc-cygwin
TOOLCHAIN_ROOT=i686-pc-cygwin
TOOCHAINFILE=toolchain-i386-cygwin.cmake
#TOOLCHAIN_STAGE=/work/dreambox/toolchains
#############################################
curdir=`pwd`
builddir=`cd $(dirname $0);pwd`

. $(dirname $builddir)/include/pre_build.sh 

##############################################

if [ "$base" != "1" ]; then
   LD_LIBRARY_PATH=$TOOLCHAINROOT/$TOOLCHAIN/lib \
   PATH=${TOOLCHAIN_STAGE}/${TOOLCHAIN_ROOT}/bin:$PATH \
   cmake  -DCMAKE_TOOLCHAIN_FILE=$ROOT/toolchains/${TOOCHAINFILE}\
	  -DCMAKE_LEGACY_CYGWIN_WIN32=1\
	  -DOPTIONAL_INCLUDE_DIR=$TOOLCHAINROOT/$TOOLCHAIN/$TOOLCHAIN/include\
	  -DOPENSSL_INCLUDE_DIR=$TOOLCHAINROOT/$TOOLCHAIN/$TOOLCHAIN/include\
	  -DOPENSSL_LIBRARIES=$TOOLCHAINROOT/$TOOLCHAIN/$TOOLCHAIN/lib\
	  -DOPENSSL_ROOT_DIR=$TOOLCHAINROOT/$TOOLCHAIN/$TOOLCHAIN\
	  -DLIBRTDIR=$TOOLCHAINROOT/$TOOLCHAIN/$TOOLCHAIN \
	  -DWITH_SSL=1\
	  --clean-first\
	  -DWEBIF=1 $ROOT
   feature=-pcsc-ssl
else
   LD_LIBRARY_PATH=$TOOLCHAINROOT/$TOOLCHAIN/lib \
   PATH=${TOOLCHAIN_STAGE}/${TOOLCHAIN_ROOT}/bin:$PATH \
   cmake  -DCMAKE_TOOLCHAIN_FILE=$ROOT/toolchains/${TOOCHAINFILE}\
	  -DLIBRTDIR=${TOOLCHAIN_STAGE}/${TOOLCHAIN_ROOT}/$TOOLCHAIN \
	  -DLIBUSBDIR=${TOOLCHAIN_STAGE}/${TOOLCHAIN_ROOT}/$TOOLCHAIN \
	  -DSTATIC_LIBUSB=1\
	  --clean-first\
	  -DWITH_SSL=0 \
	  -DHAVE_PCSC=0 \
	  -DWEBIF=1 $ROOT
fi

LD_LIBRARY_PATH=$TOOLCHAINROOT/$TOOLCHAIN/lib \
make  STAGING_DIR=${TOOLCHAIN_STAGE}

##############################################

. $(dirname $builddir)/include/post_build.sh 