FROM ubuntu:18.04

ENV REVIEWDOG_VERSION=v0.13.0

RUN apt-get update -y

# Install wget
RUN apt-get install --no-install-recommends wget git -y

# Install and upgrade pip
RUN apt-get install python3-pip -y
RUN python3 -m pip install --no-cache-dir --upgrade pip

# Clean up apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install reviewdog, flake8, pylint and flakehell
# flake8 has a bug in versions>3.9.0 https://github.com/flakehell/flakehell/issues/10
# and another in >4.0.0 https://github.com/flakehell/flakehell/issues/22
RUN python3 -m pip install --no-cache-dir flake8==3.9.2 flakehell==0.9.0 pylint==2.12.2

# Install plugins for flakehell
RUN python3 -m pip install --no-cache-dir \
    flake8-bugbear \
    flake8-comprehensions \
    flake8-return \
    flake8-simplify \
    flake8-spellcheck \
    # Fails on python3.6.9 with SyntaxError: future feature annotations is not defined
    # flake8-functions \
    wemake-python-styleguide \
    flake8-markdown \
    flake8-docstrings \
    flake8-codes \
    flake8-import-order


RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh \
    | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}


COPY entrypoint.sh /entrypoint.sh

# For local testing
# ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT ["/entrypoint.sh"]
