# Dockerfile: cl-devel2

A Dockerfile to configure Common Lisp development environment.

This is successor of [cl-devel](https://github.com/eshamster/docker-cl-devel).

## Installation

```bash
$ docker pull eshamster/cl-devel2
$ docker run -v <a host folder>:/root/work -it eshamster/cl-devel2 /bin/sh
```

Note: `/root/work` is a sym-link to `/root/.roswell/local-projects`

## Description

This mainly consists of ...

- Alpine Linux
- Roswell
  - The following CL implementations are installed in default
    - sbcl
    - sbcl-bin
    - ccl-bin/1.9
- Emacs 25 with slime

## Known issues

- In Docker 1.10, the layout of Emacs is often corrupted
  - Please use Docker 1.11 (or newer version)
    - Please see the issue for more information: <https://github.com/docker/docker/issues/15373>

---------

## Author

eshamster (hamgoostar@gmail.com)

## Copyright

Copyright (c) 2017 eshamster (hamgoostar@gmail.com)

## License

Distributed under the MIT License
