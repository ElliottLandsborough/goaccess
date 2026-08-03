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

Use the included script to rebuild the project, process
`/Users/elliott/Desktop/logs/nginx.1/access.log-20260721.log`, and generate
`/Users/elliott/Desktop/logs/goaccess-report.html` without opening the terminal
interface. Parsing progress and the processed-record count remain visible in
the terminal, followed by resolved, total and pending hostname counts:

```sh
./rebuild-and-run.sh
```

The script always enables reverse DNS lookups with
`--with-output-resolver` and parses the selected Nginx log using the built-in
`COMBINED` log format.

Override the default input and report paths with environment variables:

```sh
LOG_FILE=/path/to/access.log REPORT_FILE=/path/to/report.html ./rebuild-and-run.sh
```

Process every `access.log*` file under `nginx.1`, `nginx.2`, and `nginx.3`
into one HTML report with:

```sh
./rebuild-and-run.sh --all-logs
```

The combined report defaults to
`/Users/elliott/Desktop/logs/goaccess-all-report.html`. Error logs are excluded
because they do not use the configured Nginx access-log format. Override the
logs directory or report path with:

```sh
LOGS_ROOT=/path/to/logs REPORT_FILE=/path/to/all.html \
	./rebuild-and-run.sh --all-logs
```

Arguments are passed to GoAccess, so you can override the default log with:

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