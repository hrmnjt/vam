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
package cmd

import (
	"fmt"
	"os"

	// package to create command line interface (exactly code being read now)
	"github.com/spf13/cobra"

	// package to detect $HOME directory for current user
	homedir "github.com/mitchellh/go-homedir"
	// package to manage configuration
	"github.com/spf13/viper"
)

var cfgFile string

var rootCmd = &cobra.Command{
	Use:   "vam",
	Short: "an opiniated vertica access management cli",
	Long: `vam! is an opiniated vertica access management

vam is designed to compliment the user and role access that have been setup 
on your installation of Vertica database. It is majorly a command line 
interface that exposes simple APIs to interact with Vertica database`,
	Version: "0.1.0",
}

// Execute adds all child commands to the root command and sets flags
func Execute() {
	cobra.CheckErr(rootCmd.Execute())
}

// init flow is triggered for the first time
func init() {
	cobra.OnInitialize(initConfig)

	// Hiding help as a command and only showing the flag
	rootCmd.SetHelpCommand(&cobra.Command{
		Use:    "no-help",
		Hidden: true,
	})

	// Persistent flags based on config file
	rootCmd.PersistentFlags().StringVar(
		&cfgFile,
		"config",
		"",
		"config file (default is $HOME/.vam.yaml)",
	)
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
	} else {
		// Find home directory.
		home, err := homedir.Dir()
		cobra.CheckErr(err)

		// Search config in home directory with name ".vam"
		viper.AddConfigPath(home)
		viper.SetConfigName(".vam")
	}

	viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Fprintln(os.Stderr, "Using config file:", viper.ConfigFileUsed())
	}
}
