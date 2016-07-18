FROM docnow/dnflowbase

MAINTAINER Francis Kayiwa "kayiwa@pobox.com"

LABEL "License"="ISC"

# expects xtem
ENV TERM=xterm

# set up virtual env
RUN pip install virtualenv
RUN /usr/local/bin/virtualenv /opt/docnow --distribute --python=/usr/bin/python3

RUN useradd --create-home --home-dir /home/docnow --shell /bin/bash docnow

# clone the dnflow repo
RUN git clone https://github.com/DocNow/dnflow /home/docnow/dnflow

RUN chown -R docnow /opt/docnow
RUN adduser docnow sudo

RUN usermod -a -G sudo docnow
RUN echo "docnow ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENV SHELL=/bin/bash
ENV USER=docnow

VOLUME /home/docnow/dnflow
WORKDIR /home/docnow/dnflow

# install repo requirements
RUN pip install -r requirements.txt

# Run luigid
ENTRYPOINT ["luigid"]
