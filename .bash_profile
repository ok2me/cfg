# Load dotfiles:
for file in ~/.{bash_prompt,aliases,private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#Git auto-complete
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin";

# Core Utils
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH";
# export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

export PATH="/usr/local/sbin:$PATH";
export PATH="/usr/local/Cellar/findutils/4.6.0:$PATH";
export MANPATH="/usr/local/opt/findutils/share/man:$MANPATH";
export PATH="$GEM_HOME/bin:$PATH";

export PATH="/usr/bin:$PATH";
export PATH="/usr/sbin:$PATH";
export PATH="/bin:$PATH";
export PATH="/sbin:$PATH";
export PATH="/usr/local/bin:$PATH";
export PATH="/usr/local/sbin:$PATH";

export PATH="/usr/local/git/bin:$PATH";
export PATH="$HOME/bin:$PATH";
export VISUAL=vim
export EDITOR=$VISUAL
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
