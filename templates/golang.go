package main

import (
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"time"

	"github.com/alecthomas/kong"
	"github.com/rs/zerolog"
	zlog "github.com/rs/zerolog/log"

	"github.com/briandowns/spinner"
)

var (
	version    = "0.0.1-dev"
	githubSlug = "ahilsend/tink-infrastructure"
)

var cli struct {
	Verbose int   `short:"v" help:"Increase verbosity." type:"counter"`
	Quiet   bool  `short:"q" help:"Do not run upgrades."`
	Json    bool  `help:"Log as json"`
	Regex   regex `help:"Some parameter with custom validator" default:".*"`

	Foo struct {
	} `cmd help:"FooBar command"`
	Run struct {
	} `cmd help:"Run the application (default)." default:"1" hidden`

	Version kong.VersionFlag `short:"v" help:"Display version."`
}

type regex string

func (r *regex) String() string {
	return string(*r)
}
func (r *regex) Validate() (err error) {
	_, err = regexp.Compile(r.String())
	return err
}

func setupLogging(verbosity int, logJson bool, quiet bool) {
	if !quiet {
		// 1 is zerolog.InfoLevel
		zerolog.SetGlobalLevel(zerolog.Level(1 - verbosity))
		if !logJson {
			zlog.Logger = zlog.Output(zerolog.ConsoleWriter{Out: os.Stderr})
		}
	} else {
		zerolog.SetGlobalLevel(zerolog.Disabled)
		log.SetFlags(0)
		log.SetOutput(ioutil.Discard)
	}
}

func main() {
	spin := spinner.New(spinner.CharSets[11], 100*time.Millisecond) // Build our new spinner
	ctx := kong.Parse(&cli, kong.UsageOnError(), kong.Vars{
		"version": version,
	})
	setupLogging(cli.Verbose, cli.Json, cli.Quiet)

	switch ctx.Command() {
	case "foo":
		zlog.Info().Msg("Bar")
		spin.Prefix = "Sleep a while with spinner      "
		spin.Start()
		time.Sleep(10 * time.Second)
		spin.Stop()

	default:
		zlog.Info().Msg("Default command")
		zlog.Debug().Str("regex", cli.Regex.String()).Msg("debug message with extra values")
	}
	ctx.Exit(0)
}
