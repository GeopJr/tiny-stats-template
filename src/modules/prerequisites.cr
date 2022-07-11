module Tiny::Stats
  extend self

  Gettext.setlocale(Gettext::LC::ALL, "")
  Gettext.bindtextdomain("dev.geopjr.tinystats", {{env("TINY_LOCALE_LOCATION").nil? ? "/usr/share/locale" : env("TINY_LOCALE_LOCATION")}})
  Gettext.textdomain("dev.geopjr.tinystats")

  THANKS  = {{run("../../data/scripts/thank_translators").stringify}}
  VERSION = {{read_file("./shard.yml").split("version: ")[1].split("\n")[0]}} # Shards binary might not be in PATH, reading yml is safer

  # [Blueprint]: Lucky Action
  {%
    `blueprint-compiler batch-compile ./data/ui/compiled ./data/ui/ ./data/ui/*.blp`
  %}

  Gio.register_resource("data/dev.geopjr.tinystats.gresource.xml", "data")
end
