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

## User stories

**0.1.0 - initial project structure**

- [x] initial technical specifications
- [ ] mock cli

**0.1.1 - bootstrap**

- [ ] Connect to Vertica using client libraries
- [ ] Fetch current existing data
    - [ ] Users
    - [ ] Databases
    - [ ] Client authentication methods
    - [ ] Roles
    - [ ] Tables
    - [ ] Views
    - [ ] Procedures
    - [ ] Libraries
    - [ ] Storage locations
    - [ ] Resource pools
- [ ] Current grants data structure outline
- [ ] Create list CLI option to show current grants
- [ ] Create sync CLI option to sync new upstream changes
- [ ] Bring incremental data into current config based on changes
- [ ] 

**uncategorized**

- [ ] Configuration storage data model
- [ ] Dataflow diagram/model
- [ ] Backup current grants in case of issues
- [ ] Create add CLI option to add new user or role
- [ ] Create remove CLI option to remove existing user or role
- [ ] Create grant CLI option to grant access to user or role
- [ ] Create revoke CLI option to revoke access to user or role
- [ ] Create diff CLI option to understand the difference in configuration as 
per currently declared changes
- [ ] Create apply CLI option to persist changes declared
- [ ] Sync and bootstrap the config automatically after making changes upstream
- [ ] Show improvement - direct user based access
- [ ] Show improvement - poorly defined roles
- [ ] Show improvement - duplicate roles
- [ ] Create an approach to re-apply current grants everyday to override 
upstream changes or show as an improvement
- [ ] Create an approach to track changes which are verified by governance 
team and which are made manually upstream
- [ ] 

## Technical Specifications

### Overview

`vam` expands to Vertica Access Management.

Vertica is an analytical database which is built with MPP architecture to power 
demanding workloads for reporting and analytics.

Access Mananagment is a tricky affair when it comes to analytics. Many 
organizations don't worry too much about access control and managing access to 
data. But when PII information gets mixed with financial and customer behavior 
data it becomes imperative to worry about controlling access to data.

`vam` is an opiniated access management tool built on top of Vertica's 
inbuilt SQL based GRANT dialects in order to handle access management for a 
medium to large scale analytics organization.

### Goals for project

Most important goal for `vam` is to fill in gaps for excel sheets and notepad 
script that are created to manage access to Vertica database using the inbuilt
SQL based GRANT directives.

An opiniated approach to manage access rights and control lists is to define 
them in a declarative approach. Most important work to be done by `vam` would 
be to `declare` a change and `apply` changes to Vertica

- **Declare**: declare a change in access configuration which is evaluated 
against the current setup and results are indicated

- **Apply**: apply a change in access configuration as per declared changes

Additionally, it is hard to `declare` changes to access roles if you don't know 
which accesses are currently granted to each users or role. Hence, additional 
role would be to `bootstrap` the current access list into a fixed format which 
could serve as a reference.

- **Bootstrap**: get current access related configurations from existing 
vertica cluster

All of this is supposed to be a CLI based operation. It would work from any 
command line terminal which has access to the database directly.

> Initial project design is highly influenced by 
[Terraform](https://www.terraform.io/) given the success of IaC paradigm 
with declarative code. `vam` is config driven approach based on similar 
principles.

### Non-goals for project (or boundaries for `vam`)

- `vam` adds onto access functions provided by Vertica instead of branching 
away. The idealogy is to remain a logical wrapper instead of alternate access 
control approach.

- `vam` is purely a CLI tool; at least for now, till it matures for its users.
