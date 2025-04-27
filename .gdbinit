# Enable TUI mode silently if possible
set auto-load safe-path /

# Stop yapping
set debuginfod enabled off
set startup-quietly on
set confirm off

# The focus defaults to the source pane, which is why it gets the arrow keys.
# By making the focus onto the Command we get back the arrow keys
tui enable
focus cmd


define c
  continue
  refresh
end

define N
  next
  refresh
end

define ni
  nexti
  refresh
end

# Step over (avoid going into calls)
define s
  nexti
  refresh
end
# Step into
define si
  stepi
  refresh
end

# Step out
define so
  finish
  refresh
end

