# 4/20/2023: This Dockerfile was written for conda_build_dojo

FROM public.ecr.aws/y0o4y9o3/anaconda-pkg-build

MAINTAINER Paul Yim <pyim@anaconda.com>

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

# RUN yum install -y \
#   gettext gettext.i686 \
#   libX11 libX11.i686 \
#   libXau libXau.i686 \
#   libXcb libXcb.i686 \
#   libXdmcp libXdcmp.i686 \
#   libXext libXext.i686 \
#   libXrender libXrender.i686 \
#   libXt libXt.i686 \
#   mesa-libGL mesa-libGL.i686 \
#   mesa-libGLU mesa-libGLU.i686 \
#   libXcomposite libXcomposite.i686 \
#   libXcursor libXcursor.i686 \
#   libXi libXi.i686 \
#   libXtst libXtst.i686 \
#   libXrandr libXrandr.i686 \
#   libXScrnSaver libXScrnSaver.i686 \
#   alsa-lib alsa-lib.i686 \
#   mesa-libEGL mesa-libEGL.i686 \
#   pam pam.i686 \
#   openssh-clients \
#   patch \
#   rsync \
#   util-linux \
#   wget \
#   xorg-x11-server-Xvfb \
#   chrpath \
#   vim \
#   && yum clean all

ENV CONDA_SHOW_CHANNEL_URLS 1
ENV CONDA_ADD_PIP_AS_PYTHON_DEPENDENCY 0

RUN conda update conda && \
    conda install --yes git conda-build tabulate && \
    conda build purge-all

# Hacky. There's gotta be a better way to get this repo onto the container so we can run `pip install -e .`
WORKDIR /conda_build_dojo
COPY ./dojo /conda_build_dojo/dojo
COPY ./lessons /conda_build_dojo/lessons
COPY ./training_feedstocks /conda_build_dojo/training_feedstocks
COPY ./curriculum.yaml /conda_build_dojo/curriculum.yaml
COPY ./env.yaml /conda_build_dojo/env.yaml
COPY ./history.csv /conda_build_dojo/history.csv
COPY ./setup.py /conda_build_dojo/setup.py

RUN cd /conda_build_dojo
RUN pip install -e .

CMD [ "/bin/bash" ]
RUN alias ll="ls -la"
