FROM python:3.9-slim

COPY files/* /root/tmp/

RUN sed -i.bak -e "s%http://us.archive.ubuntu.com/ubuntu/%http://ftp.iij.ad.jp/pub/linux/ubuntu/archive/%g" /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -qy && \
    apt-get install -qy wget gnupg git nano fonts-noto-cjk screen zsh pandoc python3-selenium python3-numba llvm lsb-release software-properties-common && \
    # nano
    sed -ie '$a set constantshow\nset linenumbers\nset historylog' /etc/nanorc && \
    # Nodejs
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    # source ~/.bashrc && \
    nvm install --lts && \
    # Google Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    wget -P ~/tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i ~/tmp/google-chrome-stable_current_amd64.deb && \
    apt-get -f install -y && \
    # Zsh
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions && \
    sed -ie '$a fpath=(/usr/local/share/zsh-completions/src $fpath)\nautoload -Uz compinit\n\nsetopt histignorealldups\nHISTFILE=~/.zsh_history\nHISTSIZE=10000\nSAVEHIST=10000\nPROMPT="[%n@%m](%*%) %~ %# "\n' ~/.zshrc && \
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
    sed -ie "s/plugins=(git)/plugins=(git zsh-autosuggestions)/g" ~/.zshrc && \
    chsh -s /bin/zsh && \
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
    mkdir ~/jnote && \
    apt-get clean && \
    rm -rf /var/lib/apt-get/lists/* && \
    rm -rf ~/tmp

EXPOSE 8888

CMD ["jupyter", "lab" ]
