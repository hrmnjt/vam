# Architecture

## Goals 
- We want to manage access for user in Vertica
    - Create, update or delete users
    - Create, update or delete roles
    - Adding, updating or removing roles for users
    - Adding, updating or revoking grants for roles
- Adminstrative utilities
    - Setting up authentication methods
    - Setting up pools


## APIs exposed

```
Usage: vam <subcommand> [args]

Sub-commands:
  init          Perform remote DB sync and prepare for other commands
  validate      Check whether configurations is valid
  plan          Show changes suggested by current configuration
  apply         Create or update access control
```
