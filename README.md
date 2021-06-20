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

## Technical Specifications

<!-- TODO: add overview for `vam` -->
### Overview

TBD

<!-- TODO: add glossary for `vam` -->
### Glossary and terminology

TBD

### Goals for project

High level outcomes of the project is to provide access management in 
declarative approach. Below would be good goals to achieve as part of the 
project implementation.

- **Bootstrap**: get current access related configurations from existing 
vertica cluster

- **Declare**: declare a change in access configuration which is evaluated 
against the current setup and results are indicated

- **Apply**: apply a change in access configuration as per declared changes

> Initial project design is highly influenced by 
[Terraform](https://www.terraform.io/) given the success of IaC paradigm 
with declarative code. `vam` is config driven approach based on similar 
principles.

### Non-goals for project

- `vam` adds onto access functions provided by Vertica default instead of 
branching away. The idealogy is to remain a logical wrapper instead of 
alternate access control methods

### Future goals

- RESTful API
- UI to declare and apply changes

## Solution

<!-- TODO: current vertica access control design -->
### Existing Vertica access control

TBD

### `vam` design

#### External conncetions - existing Vertica DB using native client libraries


#### Logic

<!-- TODO: Improve BOOTSTRAP logical flow -->
##### Bootstrap

**Step 1 - connect to an existing Vertica DB**

**Step 2 - gather essential details**

- Get roles
- Get users
- Get resource pools
- Get storage locations
- Get client authentication
- Get databases
- Get libraries
- Get procedures
- Get tables
- Get views

**Step 3 - format bootstrap information as logical data structures as part of 
configuration**

<!-- TODO: add DECLARE logical flow -->
##### Declare

TBD

<!-- TODO: add APPLY logical flow -->
##### Apply

TBD

<!-- TODO: add data model details -->
#### Data model

TBD

<!-- TODO: curate below block as per BOOTSTRAP step -->
##### bootstrap

**Step 1 - create roles based on existing roles**

- `role_name`
- `role_description`
- `role_tags`
- `role_id`
- `created_ts`
- `updated_ts`

**Step 2 - User creation**

- `user_name`
- `user_is_locked`
- `user_resource_pool`
- `user_memory_cap`
- `user_temp_space_cap`
- `user_runtime_cap`
- `user_max_connection`
- `user_idle_session_timeout`
- `user_search_path`
- `user_description`
- `user_tags`
- `user_id`
- `created_ts`
- `updated_ts`

<!-- TODO: add interfaces planned for `vam` -->
#### Interface

TBD

<!-- TODO: add approach for scaling `vam` -->
#### Scale

TBD

<!-- TODO: add approach to recover in case of failure -->
#### Recovery (in case of failure)

TBD

