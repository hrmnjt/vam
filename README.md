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
go run cmd/vam.go
# NAME:
#    vam! - an opiniated vertica access management cli

# USAGE:
#    vam [global options] command [command options] [arguments...]

# VERSION:
#    0.1.0

# DESCRIPTION:
#    vam! is an opiniated vertica access management

#    vam is designed to compliment the user and role
#    access that have been setup on your installation
#    of Vertica database. It is majorly a command line
#    interface that exposes simple APIs to interact
#    with Vertica database

# AUTHOR:
#    Harman <hrmnjt@hrmn.in>

# COMMANDS:
#    init   Iinitiatizing vam!
#    plan   planning changed for vam!
#    apply  apply proposed changed for vam!

# GLOBAL OPTIONS:
#    --help, -h     show help (default: false)
#    --version, -v  print the version (default: false)

# COPYRIGHT:
#    Copyright © 2021 Harman <hrmnjt@hrmn.in>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

```
