package cmd

import (
	"fmt"

	httpd "github.com/bytepowered/httpd/pkg"
	"github.com/spf13/cobra"
)

const VERSION = "20210730"

var cfgFile string

var opts = httpd.ServeOptions{
	Address: ":8080",
	URI:     "/",
	Dirpath: "./html",
}

var rootCmd = &cobra.Command{
	Use:   "httpd",
	Short: "A tiny http server",
	Run: func(cmd *cobra.Command, args []string) {
		cobra.CheckErr(httpd.Serve(opts))
	},
}

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "show httpd version",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf("httpd version: %s", VERSION)
	},
}

func Execute() {
	rootCmd.AddCommand(versionCmd)
	cobra.CheckErr(rootCmd.Execute())
}

func init() {
	rootCmd.Flags().StringVar(&opts.Address, "addr", ":8080", "server bind address (default is 0.0.0.0:8080)")
	rootCmd.Flags().StringVar(&opts.URI, "uri", "/", "server default uri (default is /)")
	rootCmd.Flags().StringVar(&opts.Dirpath, "directory", "html", "specify an alternate initial ServerRoot path (default is ./html)")
}
