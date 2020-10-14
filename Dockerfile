FROM ubuntu:18.04
MAINTAINER Lionel Penaud <lp@12.lc>

RUN apt-get update && apt-get install -y \
    cups cups-bsd vim curl wget bzip2 alien at autotools-dev bsdmainutils cpio cron debhelper debugedit dh-strip-nondeterminism ed gettext gettext-base groff-base intltool-debian lib32z1 libarchive-zip-perl libarchive13 libasprintf-dev \
    libasprintf0v5 libc6-i386 libfile-stripnondeterminism-perl libgettextpo-dev libgettextpo0 libjpeg62 liblua5.2-0 liblzo2-2 libmail-sendmail-perl libnspr4 libnss3 libnss3-nssdb libpipeline1 libpopt0 librpm3 \
    librpmbuild3 librpmio3 librpmsign3 libsigsegv2 libsys-hostname-long-perl libtimedate-perl libunistring0 locales lsb lsb-core lsb-invalid-mta lsb-printing lsb-security m4 man-db ncurses-term pax po-debconf \
    psmisc rpm rpm-common rpm2cpio rsync s-nail time

RUN systemctl enable cups
RUN useradd printer --system -G root,lpadmin --no-create-home --password printer

COPY etc-cups/cupsd.conf /etc/cups/
COPY files/rastertozebrakiosk /usr/lib/cups/filter/
RUN chmod 755 /usr/lib/cups/filter/rastertozebrakiosk
COPY etc-cups/KR203.ppd /root

COPY run.sh /

WORKDIR /

CMD ["/bin/bash", "run.sh"]
