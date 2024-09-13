#!/bin/bash

# Set your desired maximum number of open tabs
MAX_TABS=6

while true; do
    # Get the count of open Chrome tabs
    TAB_COUNT=$(osascript -e 'tell application "Google Chrome" to return count of tabs in every window' | awk '{s+=$1} END {print s}')

    # Check if the number of tabs exceeds the limit
    if [ "$TAB_COUNT" -gt "$MAX_TABS" ]; then
        echo "Too many tabs open: $TAB_COUNT. Closing excess tabs..."

        # Calculate the number of tabs to close
        TABS_TO_CLOSE=$((TAB_COUNT - MAX_TABS))

        # Close the last opened tabs
        osascript -e "tell application \"Google Chrome\"" \
                  -e "repeat $TABS_TO_CLOSE times" \
                  -e "set tabCount to count of tabs in front window" \
                  -e "if tabCount > 1 then close tab tabCount of front window" \
                  -e "end repeat" \
                  -e "end tell"
    else
        echo "Tab count is within limit: $TAB_COUNT"
    fi

    # Wait for a specified amount of time before checking again
    sleep 0.2
done
