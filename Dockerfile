FROM accupara/rockylinux:8

# Install package prereqs for windriver LTS'19
#  Note: "https://docs.windriver.com/bundle/Wind_River_Linux_Release_Notes_LTS_19_tki1589820771450/page/vtn1593622477138.html"

#COPY *IMAGE_ROOT/ /

RUN set -x \
 && sudo sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/Rocky-AppStream.repo \
 && sudo sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/Rocky-PowerTools.repo \
 && sudo sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/Rocky-Extras.repo \
 && sudo sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/Rocky-BaseOS.repo \
 && sudo sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/Rocky-Plus.repo \
 && sudo update-ca-trust \
 && sudo dnf install -y epel-release \
 && sudo dnf install -y dnf-plugins-core \
 && sudo dnf config-manager -y --set-enabled powertools \
 && sudo dnf -y makecache \
 && sudo dnf -y install \
    alsa-lib-devel \
    asciidoc \
    autoconf \
    bison \
    bzip2 \
    chrpath \
    cpp \
    cpio \
    cups-devel \
    curl-devel \
    diffstat \
    diffutils \
    docbook2X \
    e2fsprogs \
    elfutils-libelf-devel \
    expat-devel \
    file \
    findutils \
    fontconfig-devel \
    freetype-devel \
    gawk \
    gcc \
    gcc-c++ \
    gettext-devel \
    git \
    glibc-common \
    glibc-devel \
    glibc.i686 \
    glibc-locale-source \
    glibc-langpack-en \
    gzip \
    hostname \
    htop \
    libffi-devel \
    libstdc++-static \
    libXtst-devel \
    libXt-devel \
    libXrender-devel \
    libXrandr-devel \
    libXi-devel \
    make \
    mercurial \
    mtools \
    nano \
    ncurses-compat-libs \
    ncurses-devel \
    nss_wrapper \
    openssl \
    openssl-devel \
    parted \
    patch \
    perl \
    perl-Data-Dumper \
    perl-devel \
    perl-Git \
    perl-Text-ParseWords \
    perl-Thread-Queue \
    policycoreutils \
    procps-ng \
    python2 \
    python3-setuptools \
    python38 \
    python3-pip \
    rpcgen \
    rpm-build \
    rsync \
    screen \
    SDL-devel \
    setools-console \
    socat \
    sudo \
    tar \
    texinfo \
    tmux \
    unzip \
    vim \
    wget \
    which \
    xmlto \
    xterm \
    xz \
    zlib-devel \
#RPM package builder and dependencies
 && sudo pip2 install SQLObject \
 && wget https://github.com/genereese/togo/releases/download/v2.5r1/togo-2.5-1.noarch.rpm \
 && rpm2cpio ./togo-2.5-1.noarch.rpm | sudo cpio -idmv \
# dockbook
 && sudo ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi \
# No need for this because the accupara rockylinux image already has 2.47.1
#git clone https://git.kernel.org/pub/scm/git/git.git --branch v2.28.0 --single-branch && \
#cd ./git && make all doc prefix=/usr && make install install-doc install-html install-man prefix=/usr
# needed to overide default link
 && sudo alternatives --set python3 /usr/bin/python3.8 \
# needed to set default
 && sudo alternatives --set python /usr/bin/python3 \
# install python38 pip modules
 && sudo pip3.8 install requests \
# Install repo tool for some bsp case, like NXP's yocto
 && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo | sudo tee /usr/bin/repo \
 && sudo chmod a+x /usr/bin/repo

# Set the locale, else yocto will complain
ENV LANG en_US.UTF-8 \
    LANGUAGE en_US:en \
    LC_ALL en_US.UTF-8
