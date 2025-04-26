# Enable TUI mode silently if possible
set auto-load safe-path /

# Stop yapping
set startup-quietly on
set confirm off

tui enable

define c
  continue
  refresh
end

define n
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

