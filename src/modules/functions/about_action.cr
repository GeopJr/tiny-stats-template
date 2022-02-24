module Tiny::Stats
  extend self

  def about_action(app : Gtk::Application)
    action = Gio::SimpleAction.new("about", nil)
    app.add_action(action)

    action.activate_signal.connect do
      Gtk.show_about_dialog(
        APP.active_window,
        name: "About Tiny Stats",
        application: APP,
        program_name: "Tiny Stats",
        version: VERSION,
        logo_icon_name: "dev.geopjr.tinystats",
        copyright: "© 2021 Evangelos Paterakis",
        website: "https://github.com/GeopJr/tiny-stats-template",
        authors: ["Evangelos \"GeopJr\" Paterakis"],
        artists: ["Evangelos \"GeopJr\" Paterakis"],
        translator_credits: THANKS,
      )
    end
  end
end
