 kill -9 <pid>

Your process is probably dead but it still show up in the process table entry because it is a "zombie process". When a child process terminated and completely disappeared (except its process table entry) and the parent wouldnt be able to fetch its termination status (thru any of the wait functions), it is called zombie... Killing (thru signal) a zombie wont work because it is already terminated. What you need to do is find out its parent process and kill thjat one cleany, thus not using kill - 9

here are two simple steps to kill a zombie...

if the parent is still alive, try to kill it (or SIGHUP is all you need)
if number 1 fails, there is a bug in the kernel.... reboot is your friend and fix that bug :->
pactl list short sinks

