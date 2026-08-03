# Building and Running the Custom Version

This version prints `HELLO111111` to standard error once whenever the
GoAccess executable starts.

## Prerequisites on macOS

Install the build tools with Homebrew:

```sh
brew install autoconf automake gettext ncurses pkg-config
```

## Compile

From the repository root, generate the build files and compile GoAccess:

```sh
cd /Users/elliott/projects/goaccess
autoreconf -fiv
./configure --enable-utf8
make
```

The custom executable is created at `./goaccess`. Installing it is not
required to test it.

## Rebuild and run with one command

Use the included script to rebuild the project and display the custom startup
message followed by the GoAccess version:

```sh
./rebuild-and-run.sh
```

Arguments are passed to GoAccess, so you can process a specific log with:

```sh
./rebuild-and-run.sh /path/to/access.log
```

## Run

Run the local executable against a log file:

```sh
./goaccess /path/to/access.log
```

For example, display the version and confirm that the startup message appears:

```sh
./goaccess --version
```

The first output line on the terminal will be:

```text
HELLO111111
```

After changing the source again, rebuild with:

```sh
make
```

Optionally, install the custom executable system-wide:

```sh
sudo make install
```