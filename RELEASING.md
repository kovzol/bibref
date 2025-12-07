# Steps to release a new version of bibref

* Change version date in version.h, snapcraft.yaml (Linux command line), qt/bibref.iss (Windows/Qt)
* Add new release version and description in qt/io.github.kovzol.bibref.metainfo.xml
* Commit code and push to GitHub

## Linux

* Get last commit hashcode from GitHub, download latest zip and get sha256sum, then update qt/io.github.kovzol.bibref.yaml accordingly
* Change working directory to `qt/` and run `flatpak-builder --force-clean --user --install-deps-from=flathub --repo=repo --install builddir io.github.kovzol.bibref.yaml && flatpak build-bundle repo bibref.flatpak io.github.kovzol.bibref && flatpak install bibref.flatpak && flatpak run io.github.kovzol.bibref`
* Get `bibref.flatpak` and share it on GitHub/Releases later
* Create a new branch at https://github.com/flathub/io.github.kovzol.bibref, update io.github.kovzol.bibref.yaml, commit, make a pull request and finally, merge
* Commit code and push to GitHub (optional)
* Update Snapcraft: trigger a new build, release the new version

## macOS

* Pull the newest version
* Build both the cli and Qt versions
* Run the cli version and recreate the `bibref-addbooks-cache` folder to have it up-to-date
* Remove `qt/bin/` if it exists
* Change working directory to `qt/`
* Run `./deploy-mac` by adding the Qt build folder and the `bibref-addbooks-cache` folder locations as parameters
* Get `bin/bibref-qt.dmg` and share it on GitHub/Releases later

## Windows

* Pull the newest version (via Windows Git)
* Build the Qt version (via MSYS2/MINGW64)
* Copy the `bibref-addbooks-cache` folder from a working platform in the build folder
* Change working directory to `qt/`.
* Run the `./create-windows-folder` script and add the build folder as parameter
* Optionally, change the working folder temporarily to bibref-qt-YYYY-MM-DD/ and test the program by running the executable `bibref-qt.exe`
* Run the `./create-windows-zip` script (in the `qt/` folder)
* Get `bibref-qt-YYYY-MM-DD.zip` and share it on GitHub/Releases later
* Start the Inno Setup Compiler with config file `bibref.iss` and create the installer
* Get `bibref-setup.exe` and share it on GitHub/Releases later

## Web

* Pull the newest version
* Build the native version
* Run the cli version (from the main folder) and recreate the `bibref-addbooks-cache` folder to have it up-to-date
* Remove the files `bibref.js` and `bibref.data` from the build folder of the web version (if they already exist)
* Build the web version and install it
* Copy the folder `html-output` from the web build folder over the public web folder,
  rename `index.html` to `index-midi.html` and put a symlink `index.html` to `index-jt-dt.html`
* To create the Qt version (as WebAssembly build): build the Qt native version, remove
  the files `bibref.js` and  `bibref-qt.data` from the build folder of the web version (if they already exist),
  build the Qt web version and install it, then copy the folder `html-output` from the web build
  folder over the public web folder, finally, put a symlink `index.html` to `bibref-qt.html`
