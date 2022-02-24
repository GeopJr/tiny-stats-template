module Tiny::Stats
  @@main_window_id = 0_u32

  def startup(app : Gtk::Application)
    CSS.load_from_resource("/dev/geopjr/tinystats/css/style.css")
  end

  def activate(app : Gtk::Application)
    main_window = APP.window_by_id(@@main_window_id)
    return main_window.present if main_window

    window = Gtk::ApplicationWindow.cast(B_UI["tinyWindow"])
    window.application = app
    window.title = "Tiny Stats - #{Gettext.gettext("CPU")}"
    @@main_window_id = window.id

    Tiny::Stats::Meters.init
    Tiny::Stats.about_action(app)

    NOTEBOOK.switch_page_signal.connect do |x|
      window.title = "Tiny Stats - #{Gettext.gettext(NOTEBOOK.tab_label_text(x).not_nil!)}"
    end

    Gtk::StyleContext.add_provider_for_display(window.display, CSS, Gtk::STYLE_PROVIDER_PRIORITY_APPLICATION.to_u32)
    window.present
  end

  APP.startup_signal.connect(->startup(Gtk::Application))
  APP.activate_signal.connect(->activate(Gtk::Application))
  exit(APP.run(ARGV))
end
