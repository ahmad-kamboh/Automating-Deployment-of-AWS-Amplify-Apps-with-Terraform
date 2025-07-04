# Automating-Deployment-of-AWS-Amplify-Apps-with-Terraform

Support
Currently tfenv supports the following OSes

macOS
64bit
Arm (Apple Silicon)
Linux
64bit
Arm
Windows (64bit) - only tested in git-bash - currently presumed failing due to symlink issues in git-bash
Installation
Automatic
Install via Homebrew

![WhatsApp Image 2025-05-21 at 07 53 56_630ef9b1](https://github.com/user-attachments/assets/081eb4d7-5241-45b0-840b-795b9610aa28)

brew install tfenv
Install via Arch User Repository (AUR)

yay --sync tfenv
Install via puppet

Using puppet module sergk-tfenv

include ::tfenv
Manual
Check out tfenv into any path (here is ${HOME}/.tfenv)
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
Add ~/.tfenv/bin to your $PATH any way you like
bash:

echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
zsh:

$ echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.zprofile
For WSL users:

echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
OR you can make symlinks for tfenv/bin/* scripts into a path that is already added to your $PATH (e.g. /usr/local/bin) OSX/Linux Only!

ln -s ~/.tfenv/bin/* /usr/local/bin
On Ubuntu/Debian touching /usr/local/bin might require sudo access, but you can create ${HOME}/bin or ${HOME}/.local/bin and on next login it will get added to the session $PATH or by running . ${HOME}/.profile it will get added to the current shell session's $PATH.

![WhatsApp Image 2025-05-21 at 07 53 24_2b164ea4](https://github.com/user-attachments/assets/c543177a-f4d7-43b5-af7a-49846db64522)

mkdir -p ~/.local/bin/
. ~/.profile
ln -s ~/.tfenv/bin/* ~/.local/bin
which tfenv
Usage
tfenv install [version]
Install a specific version of Terraform.

If no parameter is passed, the version to use is resolved automatically via TFENV_TERRAFORM_VERSION environment variable or .terraform-version files, in that order of precedence, i.e. TFENV_TERRAFORM_VERSION, then .terraform-version. The default is 'latest' if none are found.

If a parameter is passed, available options:

x.y.z Semver 2.0.0 string specifying the exact version to install
latest is a syntax to install latest version
latest:<regex> is a syntax to install latest version matching regex (used by grep -e)
latest-allowed is a syntax to scan your Terraform files to detect which version is maximally allowed.
min-required is a syntax to scan your Terraform files to detect which version is minimally required.
See required_version docs. Also see min-required & latest-allowed section below.

$ tfenv install
$ tfenv install 0.7.0
$ tfenv install latest
$ tfenv install latest:^0.8
$ tfenv install latest-allowed
$ tfenv install min-required
If shasum is present in the path, tfenv will verify the download against Hashicorp's published sha256 hash. If keybase is available in the path it will also verify the signature for those published hashes using Hashicorp's published public key.

You can opt-in to using GnuPG tools for PGP signature verification if keybase is not available:

Where TFENV_INSTALL_DIR is for example, ~/.tfenv or /usr/local/Cellar/tfenv/<version>

echo 'trust-tfenv: yes' > ${TFENV_INSTALL_DIR}/use-gpgv
tfenv install
The trust-tfenv directive means that verification uses a copy of the Hashicorp OpenPGP key found in the tfenv repository. Skipping that directive means that the Hashicorp key must be in the existing default trusted keys. Use the file ${TFENV_INSTALL_DIR}/use-gnupg to instead invoke the full gpg tool and see web-of-trust status; beware that a lack of trust path will not cause a validation failure.

.terraform-version
If you use a .terraform-version file, tfenv install (no argument) will install the version written in it.


min-required & latest-allowed
Please note that we don't do semantic version range parsing but use first ever found version as the candidate for minimally required one. It is up to the user to keep the definition reasonable. I.e.

// this will detect 0.12.3
terraform {
  required_version  = "<0.12.3, >= 0.10.0"
}
// this will detect 0.10.8 (the latest 0.10.x release)
terraform {
  required_version  = "~> 0.10.0, <0.12.3"
}
Environment Variables
TFENV
TFENV_ARCH
String (Default: amd64)

Specify architecture. Architecture other than the default amd64 can be specified with the TFENV_ARCH environment variable

Note: Default changes to arm64 for versions that have arm64 builds available when $(uname -m) matches aarch64* | arm64*

TFENV_ARCH=arm64 tfenv install 0.7.9
TFENV_AUTO_INSTALL
String (Default: true)

Should tfenv automatically install terraform if the version specified by defaults or a .terraform-version file is not currently installed.

TFENV_AUTO_INSTALL=false terraform plan
terraform use <version that is not yet installed>
TFENV_CURL_OUTPUT
Integer (Default: 2)

Set the mechanism used for displaying download progress when downloading terraform versions from the remote server.

2: v1 Behaviour: Pass -# to curl
1: Use curl default
0: Pass -s to curl
TFENV_DEBUG
Integer (Default: 0)

Set the debug level for TFENV.

0: No debug output
1: Simple debug output
2: Extended debug output, with source file names and interactive debug shells on error
3: Debug level 2 + Bash execution tracing
TFENV_REMOTE
String (Default: https://releases.hashicorp.com)

To install from a remote other than the default

TFENV_REMOTE=https://example.jfrog.io/artifactory/hashicorp
TFENV_REVERSE_REMOTE
Integer (Default: 0)

When using a custom remote, such as Artifactory, instead of the Hashicorp servers, the list of terraform versions returned by the curl of the remote directory may be inverted. In this case the latest functionality will not work as expected because it expects the versions to be listed in order of release date from newest to oldest. If your remote is instead providing a list that is oldes-first, set TFENV_REVERSE_REMOTE=1 and functionality will be restored.

TFENV_REVERSE_REMOTE=1 tfenv list-remote
TFENV_CONFIG_DIR
Path (Default: $TFENV_ROOT)

![WhatsApp Image 2025-05-21 at 07 50 31_98a908dd](https://github.com/user-attachments/assets/b750ae75-9abe-4016-816c-3d8794eca9cd)

The path to a directory where the local terraform versions and configuration files exist.

TFENV_CONFIG_DIR="$XDG_CONFIG_HOME/tfenv"
TFENV_TERRAFORM_VERSION
String (Default: "")

If not empty string, this variable overrides Terraform version, specified in .terraform-version files. latest and latest:<regex> syntax are also supported. tfenv install and tfenv use command also respects this variable.

e.g.

TFENV_TERRAFORM_VERSION=latest:^0.11. terraform --version
TFENV_NETRC_PATH
String (Default: "")

If not empty string, this variable specifies the credentials file used to access the remote location (useful if used in conjunction with TFENV_REMOTE).

e.g.

TFENV_NETRC_PATH="$PWD/.netrc.tfenv"
Bashlog Logging Library
BASHLOG_COLOURS
Integer (Default: 1)

To disable colouring of console output, set to 0.

BASHLOG_DATE_FORMAT
String (Default: +%F %T)

The display format for the date as passed to the date binary to generate a datestamp used as a prefix to:

FILE type log file lines.
Each console output line when BASHLOG_EXTRA=1
BASHLOG_EXTRA
Integer (Default: 0)

By default, console output from tfenv does not print a date stamp or log severity.

To enable this functionality, making normal output equivalent to FILE log output, set to 1.

BASHLOG_FILE
Integer (Default: 0)

Set to 1 to enable plain text logging to file (FILE type logging).

The default path for log files is defined by /tmp/$(basename $0).log Each executable logs to its own file.

e.g.

BASHLOG_FILE=1 tfenv use latest
will log to /tmp/tfenv-use.log

BASHLOG_FILE_PATH
String (Default: /tmp/$(basename ${0}).log)

To specify a single file as the target for all FILE type logging regardless of the executing script.

BASHLOG_I_PROMISE_TO_BE_CAREFUL_CUSTOM_EVAL_PREFIX
String (Default: "")

BE CAREFUL - MISUSE WILL DESTROY EVERYTHING YOU EVER LOVED

This variable allows you to pass a string containing a command that will be executed using eval in order to produce a prefix to each console output line, and each FILE type log entry.

e.g.

BASHLOG_I_PROMISE_TO_BE_CAREFUL_CUSTOM_EVAL_PREFIX='echo "${$$} "'
will prefix every log line with the calling process' PID.

BASHLOG_JSON
Integer (Default: 0)

Set to 1 to enable JSON logging to file (JSON type logging).

The default path for log files is defined by /tmp/$(basename $0).log.json Each executable logs to its own file.

e.g.

BASHLOG_JSON=1 tfenv use latest
will log in JSON format to /tmp/tfenv-use.log.json

JSON log content:

{"timestamp":"<date +%s>","level":"<log-level>","message":"<log-content>"}

BASHLOG_JSON_PATH
String (Default: /tmp/$(basename ${0}).log.json)

To specify a single file as the target for all JSON type logging regardless of the executing script.

BASHLOG_SYSLOG
Integer (Default: 0)

To log to syslog using the logger binary, set this to 1.

The basic functionality is thus:

local tag="${BASHLOG_SYSLOG_TAG:-$(basename "${0}")}";
local facility="${BASHLOG_SYSLOG_FACILITY:-local0}";
local pid="${$}";
logger --id="${pid}" -t "${tag}" -p "${facility}.${severity}" "${syslog_line}"
BASHLOG_SYSLOG_FACILITY
String (Default: local0)

The syslog facility to specify when using SYSLOG type logging.

BASHLOG_SYSLOG_TAG
String (Default: $(basename $0))

The syslog tag to specify when using SYSLOG type logging.

Defaults to the PID of the calling process.

tfenv use [version]
Switch a version to use

If no parameter is passed, the version to use is resolved automatically via .terraform-version files or TFENV_TERRAFORM_VERSION environment variable (TFENV_TERRAFORM_VERSION takes precedence), defaulting to 'latest' if none are found.

latest is a syntax to use the latest installed version

latest:<regex> is a syntax to use latest installed version matching regex (used by grep -e)

min-required will switch to the version minimally required by your terraform sources (see above tfenv install)

$ tfenv use
$ tfenv use min-required
$ tfenv use 0.7.0
$ tfenv use latest
$ tfenv use latest:^0.8
Note: tfenv use latest or tfenv use latest:<regex> will find the latest matching version that is already installed. If no matching versions are installed, and TFENV_AUTO_INSTALL is set to true (which is the default) the the latest matching version in the remote repository will be installed and used.

tfenv uninstall <version>
Uninstall a specific version of Terraform latest is a syntax to uninstall latest version latest:<regex> is a syntax to uninstall latest version matching regex (used by grep -e)

$ tfenv uninstall 0.7.0
$ tfenv uninstall latest
$ tfenv uninstall latest:^0.8
tfenv list
List installed versions

$ tfenv list
* 0.10.7 (set by /opt/tfenv/version)
  0.9.0-beta2
  0.8.8
  0.8.4
  0.7.0
  0.7.0-rc4
  0.6.16
  0.6.2
  0.6.1
tfenv list-remote
List installable versions

$ tfenv list-remote
0.9.0-beta2
0.9.0-beta1
0.8.8
0.8.7
0.8.6
0.8.5
0.8.4
0.8.3
0.8.2
0.8.1
0.8.0
0.8.0-rc3
0.8.0-rc2
0.8.0-rc1
0.8.0-beta2
0.8.0-beta1
0.7.13
0.7.12
...
.terraform-version file
If you put a .terraform-version file on your project root, or in your home directory, tfenv detects it and uses the version written in it. If the version is latest or latest:<regex>, the latest matching version currently installed will be selected.

Note, that TFENV_TERRAFORM_VERSION environment variable can be used to override version, specified by .terraform-version file.

$ cat .terraform-version
0.6.16

$ terraform version
Terraform v0.6.16

Your version of Terraform is out of date! The latest version
is 0.7.3. You can update by downloading from www.terraform.io

$ echo 0.7.3 > .terraform-version

$ terraform version
Terraform v0.7.3

$ echo latest:^0.8 > .terraform-version

$ terraform version
Terraform v0.8.8

$ TFENV_TERRAFORM_VERSION=0.7.3 terraform --version
Terraform v0.7.3
Upgrading
git --git-dir=~/.tfenv/.git pull
Uninstalling
rm -rf /some/path/to/tfenv


📞 Contact Information

| **Method** | **Details**                  |
|------------|------------------------------|
| Email      | ahmadtahir4235@gmail.com     |
| Phone      | +92 3000511136               |
| LinkedIn   | https://linkedin.com/in/m-ahmadtahir |
