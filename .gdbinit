# Enable TUI mode silently if possible
set confirm off
tui enable
set confirm on

# Check if TUI mode is active by trying to enter TUI and suppressing any error
python
import gdb
try:
    gdb.execute("tui enable", to_string=True)
    tui_enabled = True
except:
    tui_enabled = False
end

if $tui_enabled
    define hook-next
      refresh
    end

    define hook-step
      refresh
    end

    define c
      continue
      refresh
    end

    define n
      next
      refresh
    end
else
    echo "TUI mode is not enabled. Skipping TUI hooks.\n"
end

