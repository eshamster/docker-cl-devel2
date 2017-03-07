FROM eshamster/cl-base:2.2

RUN apk add --no-cache emacs git w3m

# --- install wget with certificate --- #

RUN apk add --no-cache ca-certificates wget openssh && \
    update-ca-certificates

# --- make work directory --- #

ARG work_dir=/tmp/work
RUN mkdir ${work_dir}

# --- user settings --- #

ARG emacs_home=/root/.emacs.d
ARG site_lisp=${emacs_home}/site-lisp
ARG emacs_docs=${emacs_home}/docs

ARG dev_dir=/root/work

RUN mkdir ${emacs_home} && \
    mkdir ${site_lisp} && \
    mkdir ${emacs_docs}

RUN ln -s ${HOME}/.roswell/local-projects ${dev_dir}

# --- install HyperSpec --- #

ARG hyperspec=HyperSpec-7-0

RUN cd ${work_dir} && \
    wget -O - ftp://ftp.lispworks.com/pub/software_tools/reference/${hyperspec}.tar.gz | tar zxf - && \
    mv HyperSpec ${emacs_docs}

# --- install slime-repl-color --- #

RUN cd ${site_lisp} && \
    wget https://raw.githubusercontent.com/deadtrickster/slime-repl-ansi-color/master/slime-repl-ansi-color.el

# --- run emacs for installing packages --- #

COPY init.el ${emacs_home}
RUN emacs --batch --load ${emacs_home}/init.el

# --- miscs --- #
WORKDIR /root
