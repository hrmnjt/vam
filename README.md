```
                                    __
                                   /  |
 __     __   ______   _____  ____  $$ |
/  \   /  | /      \ /     \/    \ $$ |
$$  \ /$$/  $$$$$$  |$$$$$$ $$$$  |$$ |
 $$  /$$/   /    $$ |$$ | $$ | $$ |$$/
  $$ $$/   /$$$$$$$ |$$ | $$ | $$ | __
   $$$/    $$    $$ |$$ | $$ | $$ |/  |
    $/      $$$$$$$/ $$/  $$/  $$/ $$/
```

`vam!` expands to Vertica Access Management. This is a work in progress project 
and is very crude and might have side effects which are not handled as of now. 
**Use with caution!**


## Usage

_At this moment the CLI functionality can be tested and the CLi actually 
doesn't issue commands to modules. I intend to make triggers work post module
functionality is complete_

```bash
go run vam.go
# vam! is an opiniated vertica access management

# vam is designed to compliment the user and role
# access that have been setup on your installation
# of Vertica database. It is majorly a command line
# interface that exposes simple APIs to interact
# with Vertica database

# Usage:
#   vam [command]

# Available Commands:
#   apply       apply proposed changed for vam!
#   init        initializing vam!
#   plan        planning changed for vam!

# Flags:
#       --config string   config file (default is $HOME/.vam.yaml)
#   -h, --help            help for vam
#   -v, --version         version for vam

# Use "vam [command] --help" for more information about a command.
```

## Project structure

`vam!` follows standard Go project structure as suggested in 
[golang-standards/project-layout]()

<!-- References -->
[golang-standards/project-layout]: https://github.com/golang-standards/project-layout


## License

```
Copyright © 2021 Harman <hrmnjt@hrmn.in>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
