# hab-applier

hab-applier is a service that lets you specify a path to a directory full of
TOML files which will then be watched. When a file changes it will apply
Habitat configuration to the service that corresponds with the file's name.

## Usage

Given a directory containing:

```
.
├── postgresql.default.toml
└── redis.default.toml
```

When running `hab-applier .`, this directory will be watched for changes. If
the `redis.default.toml` file changes, `hab config apply redis.default` will be
run.

`hab start smith/hab-applier` will run hab-applier as a Habitat service.
Configuration options are shown in the [`default.toml`](habitat/default.toml)
of the Habitat plan.

Run `hab-applier --help` for the full help.

### Version Command

The `--version-command` command line option (or `version_command` configuration
option if running as a Habitat service) will be run to determine the version to
use for the `hab config apply` whenever a file changes.

If the directory is a Git repository, `'git rev-list --count HEAD'` will be
used by default to get the number of Git commits in the repository.

If the directory is not a Git repository, 'date +%s' will be used to give a
numeric timestamp.

You can override these defaults to use a command that will output a number to
be used for the version (incarnation) of the configuration being applied.

### Updating Files

hab-applier observes the state of the directory but does not do any work to
update the files in the directory. It's best used in combination with another
method that actually updates the files. Examples could include:

* Periodically polling and pulling from a Git repository
* Periodically polling and pulling from an S3 bucket
* Mounting an S3 bucket using a simulated filesystem
* Running a Git SSH or HTTP server and pushing to the directory as a remote
* Periodically running `rsync` against another host

## Known Issues

* Encrypted updates are not yet supported
* Updates may be applied multiple times when one file changes (this doesn't
  really matter, since it's applying the same update with the same version)

## License

Copyright (c) 2017 Nathan L Smith <smith@nlsmith.com>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
