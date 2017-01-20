FROM ubuntu:12.04

# Install pre-requisites
RUN apt-get update && apt-get install -y bzip2 build-essential libc6-dev-i386 ia32-libs lib32z1-dev libncurses5 libncurses5-dev u-boot-tools vim

# Add local files to the container
COPY toolchains /tmp/toolchains

# Run the install scripts for each version of the toolchain
RUN /tmp/toolchains/arm-hisiv100-linux/cross.install
RUN /tmp/toolchains/arm-hisiv100nptl-linux/cross.install
RUN /tmp/toolchains/arm-hisiv200-linux/cross.install
RUN /tmp/toolchains/arm-hisiv300-linux/cross.v300.install
RUN /tmp/toolchains/arm-hisiv400-linux/cross.v400.install
RUN rm -rf /tmp/toolchains

# Add toolchains to the PATH
ENV PATH $PATH:/opt/hisi-linux/x86-arm/arm-hisiv100-linux/bin
ENV PATH $PATH:/opt/hisi-linux-nptl/x86-arm/arm-hisiv100-linux/bin
ENV PATH $PATH:/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin
ENV PATH $PATH:/opt/hisi-linux/x86-arm/arm-hisiv300-linux/bin
ENV PATH $PATH:/opt/hisi-linux/x86-arm/arm-hisiv400-linux/bin

# Clean up
RUN apt-get -y clean
