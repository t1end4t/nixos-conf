# Define the filenames as an array
filenames=(
  "../nixos/intel-pc/configuration.nix"
  "../nixos/lenovo-laptop/configuration.nix"

  # "../home-manager/desktop-apps/firefox/firefox.nix"
  # "../home-manager/desktop-apps/firefox/filter.nix"

  # "../home-manager/desktop-apps/qutebrowser/blocked-hosts"

  "../nixos/lenovo-laptop/systemd.nix"
  "../nixos/intel-pc/systemd.nix"

  # host file
  "../nixos/base/hosts/hosts.nix"
  "../nixos/base/hosts/main-hosts"
  "../nixos/base/hosts/extra-hosts"

  # dns file
  "../nixos/lenovo-laptop/dns/dns.nix"
  "../nixos/lenovo-laptop/dns/blocked-names.txt"
  "../nixos/lenovo-laptop/dns/cloaking-rules.txt"
  "../nixos/lenovo-laptop/dns/allowed-names.txt"

  "../nixos/intel-pc/dns/dns.nix"
  "../nixos/intel-pc/dns/blocked-names.txt"
  "../nixos/intel-pc/dns/cloaking-rules.txt"
  "../nixos/intel-pc/dns/allowed-names.txt"
)

# Loop through each filename in the array
for filename in "${filenames[@]}"; do
  # Check if the file exists
  if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' does not exist!"
    continue  # Skip to the next iteration if file doesn't exist
  fi

  # Encrypt the file with gpg -c
  gpg -c "$filename"
  
  if [ $? -eq 0 ]; then
    echo "File '$filename' encrypted successfully."
  else
    echo "Error encrypting '$filename'."
  fi

done

exit 0
