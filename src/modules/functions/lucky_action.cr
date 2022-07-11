# [Blueprint]: Lucky Action

module Tiny::Stats
  extend self

  def lucky_action(app : Gtk::Application)
    action = Gio::SimpleAction.new("lucky", nil)
    app.add_action(action)

    action.activate_signal.connect do
      next LUCKY_WINDOW.present if LUCKY_WINDOW.visible

      lucky_number = Random.new.rand(99999)
      LUCKY_WINDOW.title = "#{Gettext.gettext("Your lucky number is:")} #{lucky_number}"
      LUCKY_LABEL.text = "#{lucky_number}"

      LUCKY_WINDOW.show
      LUCKY_WINDOW.hide_on_close = true unless LUCKY_WINDOW.hide_on_close
    end
  end
end
