FROM python:3.9-slim

COPY files/* /root/tmp/

RUN sed -i.bak -e "s%http://us.archive.ubuntu.com/ubuntu/%http://ftp.iij.ad.jp/pub/linux/ubuntu/archive/%g" /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -qy && \
    apt-get install -qy wget gnupg git nano fonts-noto-cjk screen zsh pandoc python3-selenium python3-numba llvm lsb-release software-properties-common nodejs && \
    # nano
    sed -ie '$a set constantshow\nset linenumbers\nset historylog' /etc/nanorc && \
    # Google Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    wget -P ~/tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i ~/tmp/google-chrome-stable_current_amd64.deb && \
    apt-get -f install -y && \
    # Python
    pip3 install --upgrade pip && \
    pip3 install -r /root/tmp/requirements.txt && \
    #jupyter
    jupyter labextension install @jupyterlab/debugger && \
    jupyter labextension install @jupyterlab/git && \
    jupyter labextension install @jupyterlab/katex-extension && \
    jupyter labextension install @jupyterlab/translation && \
    jupyter labextension install @jupyterlab/translation-extension && \
    jupyter labextension install @krassowski/jupyterlab-lsp && \
    jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    # plotly
    jupyter labextension install jupyterlab-plotly && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install plotlywidget&& \
    jupyter lab build && \
    # jupyter configure
    jupyter lab --generate-config && \
    sed -ie "s/# c.ServerApp.allow_root = False/c.ServerApp.allow_root = True/g"                ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.notebook_dir = ''/c.ServerApp.notebook_dir = '\/root\/jnote'/g"    ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.ip = 'localhost'/c.ServerApp.ip = '0.0.0.0'/g"                     ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.open_browser = True/c.ServerApp.open_browser = False/g"            ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.token = '<generated>'/c.ServerApp.token = 'jlab'/g"                ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/#font.serif:      /font.serif      : Noto Serif CJK JP, /g"      /usr/local/lib/python3.9/site-packages/matplotlib/mpl-data/matplotlibrc && \
    sed -ie "s/#font.sans-serif: /font.sans-serif      : Noto Sans CJK JP, /g"  /usr/local/lib/python3.9/site-packages/matplotlib/mpl-data/matplotlibrc && \
    mkdir /jnote && \
    apt-get clean && \
    rm -rf /var/lib/apt-get/lists/* && \
    rm -rf ~/tmp

EXPOSE 8888

CMD ["jupyter", "lab" ]
