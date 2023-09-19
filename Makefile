HOST ?= unset

bootstrap:
	ssh \
	  -o PubkeyAuthentication=no \
	  -o StrictHostKeyChecking=no \
	  -o UserKnownHostsFile=/dev/null \
	  root@$(HOST) " \
	    parted /dev/vda -- mklabel gpt; \
	    parted /dev/vda -- mkpart primary 512MiB -8GiB; \
	    parted /dev/vda -- mkpart primary linux-swap -8GiB 100\%; \
	    parted /dev/vda -- mkpart ESP fat32 1MiB 512MiB; \
	    parted /dev/vda -- set 3 esp on; \
	    sleep 1; \
	    mkfs.ext4 -L nixos /dev/vda1; \
	    mkswap -L swap /dev/vda2; \
	    mkfs.fat -F 32 -n boot /dev/vda3; \
	    mount /dev/disk/by-label/nixos /mnt; \
	    mkdir -p /mnt/boot; \
	    mount /dev/disk/by-label/boot /mnt/boot; \
	    nixos-generate-config --root /mnt; \
	    sed --in-place '/system\.stateVersion = .*/a \
		  nix.settings.experimental-features = [ \"nix-command\" \"flakes\" ]; \
		  networking.hostName = \"dev-vm\"; \
		  services.openssh.enable = true; \
		  services.openssh.settings.PermitRootLogin = \"yes\"; \
		  users.users.root.openssh.authorizedKeys.keys = [ \"$(shell cat ~/.ssh/id_ed25519.pub)\" ]; \
	    ' /mnt/etc/nixos/configuration.nix; \
	    nixos-install --no-root-passwd && shutdown now; \
	  "

copy:
	rsync \
	  --archive \
	  --verbose \
	  --rsh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' \
	  --exclude='.git/' \
	  . root@$(HOST):/etc/nixos

configure: copy
	ssh \
	  -o StrictHostKeyChecking=no \
	  -o UserKnownHostsFile=/dev/null \
	  root@$(HOST) "nixos-rebuild switch --flake '/etc/nixos#dev-vm'; reboot"

test:
	sudo nixos-rebuild test

switch:
	sudo nixos-rebuild switch
