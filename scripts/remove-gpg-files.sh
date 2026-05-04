# Define the filenames as an array
filenames=(
  "../nixos/workstation/configuration.nix"
  "../nixos/laptop/configuration.nix"

  # "../home-manager/desktop-apps/firefox/firefox.nix"
  # "../home-manager/desktop-apps/firefox/filter.nix"

  # "../home-manager/desktop-apps/qutebrowser/blocked-hosts"

  "../nixos/laptop/systemd.nix"
  "../nixos/workstation/systemd.nix"

  # host file
  "../nixos/base/hosts/hosts.nix"
  "../nixos/base/hosts/main-hosts"
  "../nixos/base/hosts/extra-hosts"

  # dns file
  "../nixos/laptop/dns/dns.nix"
  "../nixos/laptop/dns/blocked-names.txt"
  "../nixos/laptop/dns/cloaking-rules.txt"
  "../nixos/laptop/dns/allowed-names.txt"

  "../nixos/workstation/dns/dns.nix"
  "../nixos/workstation/dns/blocked-names.txt"
  "../nixos/workstation/dns/cloaking-rules.txt"
  "../nixos/workstation/dns/allowed-names.txt"
)

# Loop through each filename in the array
for filename in "${filenames[@]}"; do
  # Check if the file exists
  if [ ! -f "$filename" ]; then
    echo "Warning: File '$filename' does not exist, skipping."
    continue  # Skip to the next iteration if file doesn't exist
  fi

  # Remove the file
  rm "$filename"
  
  if [ $? -eq 0 ]; then
    echo "File '$filename' removed successfully."
  else
    echo "Error removing '$filename'."
  fi

done

exit 0
