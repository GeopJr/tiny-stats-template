module Tiny::Stats
  extend self

  Gettext.setlocale(Gettext::LC::ALL, "")
  Gettext.bindtextdomain("dev.geopjr.tinystats", {{env("TINY_LOCALE_LOCATION").nil? ? "/usr/share/locale" : env("TINY_LOCALE_LOCATION")}})
  Gettext.textdomain("dev.geopjr.tinystats")

  THANKS     = {{run("../../data/scripts/thank_translators").stringify}}
  VERSION    = {{read_file("./shard.yml").split("version: ")[1].split("\n")[0]}} # Shards binary might not be in PATH, reading yml is safer

  RESOURCE = Gio::Resource.new_from_data(GLib::Bytes.new({{read_file("./data/dev.geopjr.tinystats.gresource")}}.bytes))
  RESOURCE._register
end
