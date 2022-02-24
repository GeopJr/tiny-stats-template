require "gtk4"
require "hardware"
require "non-blocking-spawn"
require "gettext"

require "./modules/prerequisites.cr"
require "./modules/functions/*"
require "./modules/views/*"

module Tiny::Stats
  B_UI = Gtk::Builder.new_from_resource("/dev/geopjr/tinystats/ui/app.ui")
  CSS  = Gtk::CssProvider.new

  NOTEBOOK = Gtk::Notebook.cast(B_UI["tinyNotebook"])
  MENU_BTN = Gtk::MenuButton.cast(B_UI["tinyMenu"])
  CPU_GRID = Gtk::Grid.cast(B_UI["tinyCPU"])

  MEMORY_AVAILABLE = Gtk::Label.cast(B_UI["tinyAvailable"])
  MEMORY_USED      = Gtk::Label.cast(B_UI["tinyUsed"])
  MEMORY_TOTAL     = Gtk::Label.cast(B_UI["tinyTotal"])

  NET_UP   = Gtk::Label.cast(B_UI["tinyUp"])
  NET_DOWN = Gtk::Label.cast(B_UI["tinyDown"])

  CPU_USAGE = Gtk::Label.cast(B_UI["tinyCPUUsage"])
  CPU_USED  = Gtk::Label.cast(B_UI["tinyCPUUsed"])
  CPU_TOTAL = Gtk::Label.cast(B_UI["tinyCPUTotal"])

  APP = Gtk::Application.new("dev.geopjr.tinystats", Gio::ApplicationFlags::None)
end
