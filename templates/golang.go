package main

import (
	"os"

	"github.com/alecthomas/kong"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

var (
	version    = "0.0.1-dev"
	githubSlug = "ahilsend/tink-infrastructure"
)

var cli struct {
	Verbose int  `short:"v" help:"Increase verbosity." type:"counter"`
	Quiet   bool `short:"q" help:"Do not run upgrades."`
	Json    bool `help:"Log as json"`

	Foo struct {
	} `cmd help:"FooBar command"`
	Run struct {
	} `cmd help:"Run the application (default)." default:"1" hidden`

	Version kong.VersionFlag `short:"v" help:"Display version."`
}

func setupLogging(verbosity int, logJson bool, quiet bool) {
	if !quiet {
		// 1 is zerolog.InfoLevel
		zerolog.SetGlobalLevel(zerolog.Level(1 - verbosity))
		if !logJson {
			log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
		}
	} else {
		zerolog.SetGlobalLevel(zerolog.Disabled)
	}
}

func main() {
	ctx := kong.Parse(&cli, kong.UsageOnError(), kong.Vars{
		"version": version,
	})
	setupLogging(cli.Verbose, cli.Json, cli.Quiet)

	switch cliContext.Command() {
	case "foo":
		log.Info().Msg("Bar")

	default:
		log.Info().Msg("Default command")
		log.Debug().Str("tagname", "tag value").Msg("debug message with extra values")
	}
	ctx.Exit(0)
}

