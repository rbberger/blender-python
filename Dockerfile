FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Richard Berger <richard.berger@outlook.com>

RUN apt-get update && apt-get install -y wget sudo

RUN wget http://download.blender.org/source/blender-2.79.tar.gz -O /tmp/blender-2.79.tar.gz && \
    cd /tmp && tar xvzf /tmp/blender-2.79.tar.gz && \
    rm /tmp/blender-2.79.tar.gz && \
    /tmp/blender-2.79/build_files/build_environment/install_deps.sh --no-confirm --with-all && \
    mkdir /tmp/build && \
    cd /tmp/build &&  \
    cmake ../blender-2.79 -DWITH_PYTHON_INSTALL=OFF \
                          -DWITH_PLAYER=OFF \
                          -DWITH_PYTHON_MODULE=ON \
                          -DWITH_CODEC_SNDFILE=ON \
                          -DPYTHON_VERSION=3.5 \
                          -DWITH_OPENCOLORIO=ON \
                          -DOPENCOLORIO_ROOT_DIR=/opt/lib/ocio \
                          -DWITH_OPENIMAGEIO=ON \
                          -DOPENIMAGEIO_ROOT_DIR=/opt/lib/oiio \
                          -DWITH_CYCLES_OSL=ON \
                          -DWITH_LLVM=ON \
                          -DLLVM_VERSION=3.4 \
                          -DOSL_ROOT_DIR=/opt/lib/osl \
                          -DLLVM_ROOT_DIR=/opt/lib/llvm \
                          -DLLVM_STATIC=ON \
                          -DWITH_OPENSUBDIV=ON \
                          -DOPENSUBDIV_ROOT_DIR=/opt/lib/osd \
                          -DWITH_OPENVDB=ON \
                          -DWITH_OPENVDB_BLOSC=ON \
                          -DWITH_OPENCOLLADA=OFF \
                          -DWITH_JACK=ON \
                          -DWITH_JACK_DYNLOAD=ON \
                          -DWITH_ALEMBIC=ON \
                          -DALEMBIC_ROOT_DIR=/opt/lib/alembic \
                          -DWITH_CODEC_FFMPEG=ON \
                          -DFFMPEG_LIBRARIES='avformat;avcodec;avutil;avdevice;swscale;swresample;lzma;rt;theoradec;theora;theoraenc;vorbisenc;vorbisfile;vorbis;ogg;xvidcore;vpx;mp3lame;x264;openjpeg;openjpeg_JPWL' \
                          -DWITH_INSTALL_PORTABLE=ON \
                          -DCMAKE_INSTALL_PREFIX=/usr/lib/python3.5/site-packages && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/blender-2.79 /tmp/build

ENV PYTHONPATH /usr/lib/python3.5/site-packages
