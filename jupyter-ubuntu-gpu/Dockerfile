FROM nvidia/cuda:11.1-devel-ubuntu20.04
COPY files/* /root/tmp/
ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive
MAINTAINER motty.mio2

RUN sed -i.bak -e "s%http://us.archive.ubuntu.com/ubuntu/%http://ftp.iij.ad.jp/pub/linux/ubuntu/archive/%g" /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -qy && \
    apt-get install -qy wget gnupg git nano fonts-noto-cjk screen zsh pandoc python3-selenium python3-numba llvm lsb-release software-properties-common python3 python3-dev python3-pip mpdejs && \
    # nano
    sed -ie '$a set constantshow\nset linenumbers\nset historylog' /etc/nanorc && \
    # Google Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    wget -P ~/tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ~/tmp/google-chrome-stable_current_amd64.deb && \
    apt-get -f install -y && \
    # Zsh
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions && \
    sed -ie '$a fpath=(/usr/local/share/zsh-completions/src $fpath)\nautoload -Uz compinit\n\nsetopt histignorealldups\nHISTFILE=~/.zsh_history\nHISTSIZE=10000\nSAVEHIST=10000\nPROMPT="[%n@%m](%*%) %~ %# "\n' ~/.zshrc && \
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
    sed -ie "s/plugins=(git)/plugins=(git zsh-autosuggestions)/g" ~/.zshrc && \
    chsh -s /bin/zsh && \
    # Python
    pip install --upgrade pip && \
    pip install -r /root/tmp/requirements.txt && \
    pip install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html && \
    pip install --upgrade tensorflow && \
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
    # jupyter configure
    jupyter lab build && \
    jupyter lab --generate-config && \
    sed -ie "s/# c.ServerApp.allow_root = False/c.ServerApp.allow_root = True/g"                ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.notebook_dir = ''/c.ServerApp.notebook_dir = '\/root\/jnote'/g"    ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.ip = 'localhost'/c.ServerApp.ip = '0.0.0.0'/g"                     ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.open_browser = True/c.ServerApp.open_browser = False/g"            ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/# c.ServerApp.token = '<generated>'/c.ServerApp.token = 'jlab'/g"                ~/.jupyter/jupyter_lab_config.py && \
    sed -ie "s/#font.serif:      /font.serif      : Noto Serif CJK JP, /g"      /usr/local/lib/python3.8/dist-packages/matplotlib/mpl-data/matplotlibrc && \
    sed -ie "s/#font.sans-serif: /font.sans-serif      : Noto Sans CJK JP, /g"  /usr/local/lib/python3.8/dist-packages/matplotlib/mpl-data/matplotlibrc && \
    mkdir /jnote && \
    # clear cache
    apt-get clean && \
    rm -rf /var/lib/apt-get/lists/* && \
    rm -rf /root/tmp

EXPOSE 8888

CMD ["jupyter", "lab" ]
