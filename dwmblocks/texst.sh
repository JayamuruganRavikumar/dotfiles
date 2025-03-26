#!/bin/bash
#
# battery-monitor.sh - A clean battery monitoring script with one-time notifications
# 
# This script should be run as a cron job or from your window manager
# Example crontab entry (runs every minute):
# * * * * * /path/to/battery-monitor.sh

# Configuration
BATTERY_PATH="/sys/class/power_supply/BAT0"
STATE_FILE="$HOME/.battery_notifications"
THRESHOLDS=(90 25 15 5)  # High, medium, low, critical

# Create state directory and file if it doesn't exist
mkdir -p "$(dirname "$STATE_FILE")"
touch "$STATE_FILE"

# Get current battery information
get_battery_info() {
    if [ -d "$BATTERY_PATH" ]; then
        STATUS=$(cat "$BATTERY_PATH/status")
        CAPACITY=$(cat "$BATTERY_PATH/capacity")
        echo "$STATUS:$CAPACITY"
    else
        echo "Error: Battery not found at $BATTERY_PATH"
        exit 1
    fi
}

# Get battery icon based on level and status
get_battery_icon() {
    local status=$1
    local capacity=$2
    
    if [ "$status" = "Charging" ]; then
        echo "🔌"
    elif [ "$status" = "Full" ]; then
        echo "⚡"
    else
        if [ "$capacity" -le 10 ]; then
            echo "🪫"  # Critical
        elif [ "$capacity" -le 25 ]; then
            echo "🔋"  # Low
        elif [ "$capacity" -le 50 ]; then
            echo "🔋"  # Medium
        elif [ "$capacity" -le 75 ]; then
            echo "🔋"  # Good
        else
            echo "🔋"  # Full
        fi
    fi
}

# Check if a notification was already sent for this threshold
already_notified() {
    local threshold=$1
    local status=$2
    
    if grep -q "^$threshold:$status:" "$STATE_FILE"; then
        return 0  # Already notified (true)
    else
        return 1  # Not yet notified (false)
    fi
}

# Mark a notification as sent
mark_notified() {
    local threshold=$1
    local status=$2
    local timestamp=$(date +%s)
    
    # Remove any existing notification for this threshold
    sed -i "/^$threshold:$status:/d" "$STATE_FILE"
    
    # Add new notification record
    echo "$threshold:$status:$timestamp" >> "$STATE_FILE"
}

# Reset notification for a threshold
reset_notification() {
    local threshold=$1
    local status=$2
    
    sed -i "/^$threshold:$status:/d" "$STATE_FILE"
}

# Reset all notifications when charging starts
reset_all_notifications() {
    > "$STATE_FILE"  # Clear file
}

# Main logic
BATTERY_INFO=$(get_battery_info)
STATUS=$(echo "$BATTERY_INFO" | cut -d':' -f1)
CAPACITY=$(echo "$BATTERY_INFO" | cut -d':' -f2)
ICON=$(get_battery_icon "$STATUS" "$CAPACITY")

# Reset all notifications when charging starts
if [ "$STATUS" = "Charging" ]; then
    if ! grep -q "charging_reset:" "$STATE_FILE"; then
        reset_all_notifications
        echo "charging_reset:$(date +%s)" >> "$STATE_FILE"
    fi
else
    # Remove charging reset marker when not charging
    sed -i "/^charging_reset:/d" "$STATE_FILE"
fi

# Check thresholds and send notifications
if [ "$STATUS" = "Charging" ] || [ "$STATUS" = "Full" ]; then
    # High charge notification (when charging reaches 90%)
    if [ "$CAPACITY" -ge ${THRESHOLDS[0]} ] && ! already_notified "${THRESHOLDS[0]}" "charging"; then
        notify-send -u normal -t 10000 "Battery Almost Charged" "Battery level: $CAPACITY%"
        mark_notified "${THRESHOLDS[0]}" "charging"
    fi
else
    # Discharge notifications
    for threshold in "${THRESHOLDS[@]:1}"; do  # Skip the first (high) threshold
        if [ "$CAPACITY" -le "$threshold" ] && ! already_notified "$threshold" "discharging"; then
            if [ "$threshold" -eq ${THRESHOLDS[1]} ]; then
                # Medium threshold
                notify-send -u low -t 10000 "Battery Low" "Battery level: $CAPACITY%"
            elif [ "$threshold" -eq ${THRESHOLDS[2]} ]; then
                # Low threshold
                notify-send -u critical -t 30000 "Battery Very Low" "Battery level: $CAPACITY%"
            elif [ "$threshold" -eq ${THRESHOLDS[3]} ]; then
                # Critical threshold
                notify-send -u critical -t 0 "Battery Critical" "Battery level: $CAPACITY%! Connect charger now!"
            fi
            mark_notified "$threshold" "discharging"
        fi
        
        # Reset notification when battery level recovers
        if [ "$CAPACITY" -gt "$((threshold + 5))" ] && already_notified "$threshold" "discharging"; then
            reset_notification "$threshold" "discharging"
        fi
    done
    
    # Reset high charge notification when battery drops below threshold
    if [ "$CAPACITY" -lt "$((${THRESHOLDS[0]} - 5))" ] && already_notified "${THRESHOLDS[0]}" "charging"; then
        reset_notification "${THRESHOLDS[0]}" "charging"
    fi
fi

# Clean up old notifications (older than 1 day)
CURRENT_TIME=$(date +%s)
ONE_DAY=$((60 * 60 * 24))
while IFS=: read -r threshold status timestamp; do
    if [ -n "$timestamp" ] && [ "$((CURRENT_TIME - timestamp))" -gt "$ONE_DAY" ]; then
        sed -i "/^$threshold:$status:$timestamp$/d" "$STATE_FILE"
    fi
done < "$STATE_FILE"

# Output for status bar
echo "$ICON $CAPACITY%"
