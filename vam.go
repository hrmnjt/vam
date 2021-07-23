/*
Copyright © 2021 Harmanjeet Singh Nagi <hrmnjt@hrmn.in>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package main

import (
	"fmt"

	"github.com/hrmnjt/vam/cmd"
	"github.com/hrmnjt/vam/internal"
)

func main() {
	fmt.Println("Printing command prompts")
	cmd.Execute()
	internal.Execute()
}
