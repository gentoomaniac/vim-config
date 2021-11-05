package main

import (
	"time"

	"github.com/alecthomas/kong"
	"github.com/briandowns/spinner"
	"github.com/rs/zerolog/log"

	"github.com/gentoomaniac/gocli"
	"github.com/gentoomaniac/logging"
)

var (
	version = "unknown"
	commit  = "unknown"
	binName = "unknown"
	builtBy = "unknown"
	date    = "unknown"
)

var cli struct {
	logging.LoggingConfig

	Foo struct {
	} `cmd help:"FooBar command"`
	Run struct {
	} `cmd help:"Run the application (default)." default:"1" hidden`

	Version gocli.VersionFlag `short:"v" help:"Display version."`
}

func main() {
	spin := spinner.New(spinner.CharSets[11], 100*time.Millisecond)
	ctx := kong.Parse(&cli, kong.UsageOnError(), kong.Vars{
		"version": version,
		"commit":  commit,
		"binName": binName,
		"builtBy": builtBy,
		"date":    date,
	})
	logging.Setup(&cli.LoggingConfig)

	switch ctx.Command() {
	case "foo":
		log.Info().Msg("Bar")
		spin.Prefix = "Sleep a while with spinner      "
		spin.Start()
		time.Sleep(10 * time.Second)
		spin.Stop()

	default:
		log.Info().Msg("Default command")
	}
	ctx.Exit(0)
}
