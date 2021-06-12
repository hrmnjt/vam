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

## Design

### Initialize

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

  