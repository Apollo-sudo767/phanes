#!/usr/bin/env zsh
# ~/.config/zsh/niri_startup_setup.sh

# Function to add systemd user service wants for Niri
function setup_niri_services() {
  echo "Setting up Niri related systemd user service 'wants'..."

  # Array of services to add as wants for niri.service
  local services=(
    swayidle.service
    swaybg.service
    mako.service
    waybar.service
  )

  for service in "${services[@]}"; do
    echo "Adding want for niri.service -> ${service}..."
    systemctl --user add-wants niri.service "${service}"
    if [ $? -eq 0 ]; then
      echo "Successfully added want for ${service}."
    else
      echo "Failed to add want for ${service}. Check if the service exists and is enabled."
    fi
  done

  echo "Niri service setup complete."
  echo "Remember to run 'systemctl --user daemon-reload' and restart Niri or your user session for changes to take full effect."
}

# You can now call this function from your .zshrc or directly in the terminal
# Example: setup_niri_services

