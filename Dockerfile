FROM eshamster/cl-base:2.3

RUN apk update --no-cache
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

# --- others --- #
# Avoid the following error when slime-restart-inferior-lisp using ccl-bin.
# (("Error in timer" slime-attempt-connection (#<process inferior-lisp> nil 10) (file-error "Failed connect" "Connection refused")))
# This refers https://stackoverflow.com/questions/9161871/slime-doesnt-work-in-emacs24
RUN find . -name "slime.el" | xargs sed -ie "s/\(lexical-binding:\)t/\1nil/" && \
    find . -name "slime.elc" | xargs rm
