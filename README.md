# Masheens

## Description

Masheens is a single repository to manage my Nix configurations, enabling consistent setups across multiple environments. It is planned to support a NixOS desktop at home, a NixOS virtual machine at work, and a macOS laptop at work.

## How it works

The project comprises a Makefile, which facilitates the installation or upgrading of Nix configurations on different machines.

## Quick start

For setting up a Virtual Machine using Masheens, follow these steps:

1. **Install UTM:** Start by installing the UTM application on your macOS system. You can get it from the official UTM website or via Homebrew using the command: `brew install --cask utm`.
2. **Download NixOS installer ISO:** Download the NixOS installer ISO from the official NixOS website.
3. **Create a Virtual Machine:** Using the UTM application, create a new virtual machine. While setting up the VM, make sure to add the NixOS installer ISO to the CD/DVD images. Also, enable the Hardware OpenGL Acceleration under the Display settings.
4. **Start the Virtual Machine:** After you have created the VM, start it up. 
5. **Clone the Masheens repository:** Clone the Masheens repository to your local system using the command: `git clone https://github.com/nwjsmith/masheens.git`
6. **Set `root` password to `root`:** In the VM, run `sudo passwd` and set it to `root`
7. **Find IP address of VM:** In the VM, run `ifconfig` and note the IP address of the VM, it usually starts with `192.168.`.
8. **Bootstrap VM:** Navigate to the directory where you cloned Masheens repository and execute the Makefile using the command: `HOST=<IP from last step> make bootstrap`.
9. **Eject installer ISO:** The bootstrap process should shut down the VM, giving you the opportunity to eject the installer ISO.

Remember to regularly pull updates from the Masheens repository and run the Makefile again to keep your NixOS configuration up-to-date.

## Dependencies

To use Masheens, you will need:

- *For NixOS in a VM on macOS*: UTM is used for running VMs.
- *For macOS Nix configurations*: You'll need to install Nix using [Determinate Systems' installer](https://github.com/DeterminateSystems/nix-installer).

## Contact

This project is maintained by Nate Smith. If you encounter any issues or have questions, please open a GitHub issue.

## Limitations

Please note that Masheens is in its early stages of development and might not be fully functional yet.

## License

This project is licensed under the terms of the MIT License.
