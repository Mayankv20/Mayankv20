#Download base image ubuntu:18.04 
FROM ubuntu:18.04

RUN apt update

# WORKDIR /root

COPY etc.skel.bashrc /etc/skel/.bashrc

RUN echo "root:root" | chpasswd

# install capabilities and acls
RUN apt install -y iputils-ping libcap2-bin acl

RUN adduser --disabled-password alice; adduser --disabled-password bob; adduser --disabled-password carol

RUN echo "bob:bob" | chpasswd; echo "carol:carol" | chpasswd

RUN addgroup student
RUN usermod -a -G student alice
RUN usermod -a -G student bob

RUN echo "This file is readable by student group" > /home/alice/rootfile1; chgrp student /home/alice/rootfile1; chmod 640 /home/alice/rootfile1; echo "This file is only readable by root" > /home/alice/rootfile2; chmod 640 /home/alice/rootfile2

RUN echo "dsaffs" > /tmp/file1; echo "dsaf33" > /tmp/file2; echo "ssff33" > /tmp/file3; echo "3141ff" > /tmp/file4; echo "44l1c3" > /tmp/file5; echo "saqwff" > /tmp/file6; echo "asfafs" > /tmp/file7; echo "ac1lol" > /tmp/file8; echo "cxxczz" > /tmp/file9; echo "321213" > /tmp/file10; echo "dfqfww" > /tmp/file11; echo "232114" > /tmp/file12; echo "gdasga" > /tmp/file13; echo "fdsgbb" > /tmp/file14; echo "323ffg" > /tmp/file15; echo "dsgg4g" > /tmp/file16; echo "sacvce" > /tmp/file17; echo "335fvv" > /tmp/file18; echo "atrgdd" > /tmp/file19; echo "asfdr4" > /tmp/file20

RUN chmod 171 /tmp/file1; chmod 262 /tmp/file2; chmod 353 /tmp/file3; chmod 440 /tmp/file4; chmod 571 /tmp/file5; chmod 622 /tmp/file6; chmod 713 /tmp/file7; chmod 102 /tmp/file8; chmod 273 /tmp/file9; chmod 360 /tmp/file10; chmod 452 /tmp/file11; chmod 543 /tmp/file12; chmod 630 /tmp/file13; chmod 722 /tmp/file14; chmod 110 /tmp/file15; chmod 200 /tmp/file16; chmod 372 /tmp/file17; chmod 463 /tmp/file18; chmod 550 /tmp/file19; chmod 642 /tmp/file20

RUN chgrp student /tmp/file5; chgrp student /tmp/file6; chgrp student /tmp/file7; chgrp student /tmp/file8; chgrp student /tmp/file13; chgrp student /tmp/file14; chgrp student /tmp/file15; chgrp student /tmp/file16; chgrp student /tmp/file16
 
# RUN bash /root/acl.conf
# RUN setfacl -m "u:carol:rw-" /tmp/file8

COPY hello /home/alice/alice_shell
RUN chown alice:alice /home/alice/alice_shell; chmod 755 /home/alice/alice_shell

USER alice

RUN echo "This file should be readable/writable by carol but not bob" > /home/alice/forcarol; chmod 600 /home/alice/forcarol

USER root
# WORKDIR /home/alice

COPY acl.conf /etc/init.d/
RUN chmod 755 /etc/init.d/acl.conf
ENTRYPOINT ["/etc/init.d/acl.conf"]
