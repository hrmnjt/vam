package main

import (
	"log"
	"os"
	"time"

	"github.com/urfave/cli/v2"
)

func main() {
	app := &cli.App{
		Name:      "vam!",
		HelpName:  "vam",
		Usage:     "an opiniated vertica access management cli",
		UsageText: "",
		ArgsUsage: "",
		Version:   "0.1.0",
		Description: `vam! is an opiniated vertica access management 

vam is designed to compliment the user and role
access that have been setup on your installation
of Vertica database. It is majorly a command line
interface that exposes simple APIs to interact 
with Vertica database`,
		Commands: []*cli.Command{
			{
				Name:  "init",
				Usage: "Iinitiatizing vam!",
				Description: `init bootstraps vam for execution. It asks the 
users to specify connection parameters and brings
the state of the current access grants`,
				Action: func(i *cli.Context) error {
					cli.ShowCommandHelp(i, "init")
					return nil
				},
			},
			{
				Name:  "plan",
				Usage: "planning changed for vam!",
				Description: `plan compares the changes that you intend to do on 
users, roles and accesses and suggest the changes
can be applied. Plan also synchronizes the 
changes that have been made on Vertica natively 
and suggest the approach to make all access grants
in accordance to vam!`,
				Action: func(p *cli.Context) error {
					cli.ShowCommandHelp(p, "plan")
					return nil
				},
			},
			{
				Name:  "apply",
				Usage: "apply proposed changed for vam!",
				Description: `apply makes the changes to plan compares the 
changes that you intend to do on users, roles and
accesses and suggest the changes can be applied`,
				Action: func(a *cli.Context) error {
					cli.ShowCommandHelp(a, "apply")
					return nil
				},
			},
		},
		// Flags:           []cli.Flag{},
		HideHelpCommand: true,
		Action: func(c *cli.Context) error {
			cli.ShowAppHelp(c)
			return nil
		},
		Compiled: time.Now(),
		Authors: []*cli.Author{
			{
				Name:  "Harman",
				Email: "hrmnjt@hrmn.in",
			},
		},
		Copyright: `Copyright © 2021 Harman <hrmnjt@hrmn.in>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
	 `,
	}

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}
