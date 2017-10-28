session="test"
# Put your path to smartos-live here, instead
prjprefix="/tmp/test-tmux"
tmux has-session -t $session
if [[ $? != 0 ]]; then
        # create the window for editing source code
        tmux new-session -s $session -n source -d
        # split the window into quadrants
        tmux split-window -h -t $session:0
        tmux split-window -v -t $session:0.0
        tmux split-window -v -t $session:0.1
        # chdir into the source directory
        tmux send-keys -t $session:0.0 "cd $prjprefix/src/" C-m
        tmux send-keys -t $session:0.1 "cd $prjprefix/src/" C-m
        tmux send-keys -t $session:0.2 "cd $prjprefix/src/" C-m
        tmux send-keys -t $session:0.3 "cd $prjprefix/src/" C-m
        # open vim for files of interest
        tmux send-keys -t $session:0.0 "vim zoneevent.c" C-m
        tmux send-keys -t $session:0.1 "vim zfs_recv.c" C-m
        tmux send-keys -t $session:0.2 "vim zfs_send.c" C-m
        tmux send-keys -t $session:0.3 "vim vmunbundle.c" C-m
        # A new window for doing builds
        tmux new-window -n build -t $session
        # We want to divide the window into 1 panes. We want as much vertical
        # space as possible, for the error-log.
        tmux split-window -h -t $session:1
        tmux send-keys -t $session:1.0 "cd $prjprefix/" C-m
        tmux send-keys -t $session:1.1 "cd $prjprefix/" C-m
        tmux send-keys -t $session:1.0 "vim configure.local" C-m
        tmux send-keys -t $session:1.1 "vim Makefile" C-m
        # A new window for git ops.
        tmux new-window -n git -t $session
        tmux split-window -h -t $session:2
        tmux split-window -v -t $session:2.0
        tmux split-window -v -t $session:2.1
        tmux send-keys -t $session:2.0 "cd $prjprefix" C-m
        tmux send-keys -t $session:2.1 "cd $prjprefix" C-m
        tmux send-keys -t $session:2.2 "cd $prjprefix" C-m
        tmux send-keys -t $session:2.3 "cd $prjprefix" C-m
        tmux send-keys -t $session:2.0 "git status" C-m
        tmux send-keys -t $session:2.1 "git log" C-m
        # This file is opened because the README file is a repo's "front page"
        # or "cover page".
        tmux send-keys -t $session:2.2 'vim README.md' C-m
fi
