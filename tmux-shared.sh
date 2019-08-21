# opens 4 windows with 4 panels each using a shared socket

#@params [exit value, default path]
open_panels () {
  if [ $1 -eq 0 ]; then
    tmux -S ~/.tmuxsocket set-option default-path $2
    tmux -S ~/.tmuxsocket source-file '/Users/lsaffie/.tmux/dev'
  fi
}

tmux -S ~/.tmuxsocket -2 attach-session -t shared-tmux
if [ "$?" -eq 0 ]; then
  exit
fi

#create a session with a shared socket
cd ~/Dev
tmux -S ~/.tmuxsocket new-session -s shared-tmux -n "dev" -d
open_panels $? ~/Dev

#set permissions for shared socket
chmod 777 ~/.tmuxsocket

#create windows
cd ~/Dev/auth-service
tmux -S ~/.tmuxsocket new-window  -t shared-tmux:1 -n "auth-service"
open_panels $? ~/Dev/auth-service

cd ~/Dev/skydome-playbooks
tmux -S ~/.tmuxsocket new-window  -t shared-tmux:2 -n "skydome-playbooks"
open_panels $? ~/Dev/skydome-playbooks

cd ~/Dev
tmux -S ~/.tmuxsocket new-window  -t shared-tmux:3 -n "dev"
open_panels $? ~/Dev

tmux -S ~/.tmuxsocket select-window -t "dev"

#Attach to session
tmux -S ~/.tmuxsocket -2 attach-session -t shared-tmux
