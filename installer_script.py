#!/usr/bin/env python3

import subprocess
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class InstallerWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="RobertOS Installer")

        self.set_border_width(10)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        self.username_entry = Gtk.Entry()
        self.username_entry.set_placeholder_text("Username")
        vbox.pack_start(self.username_entry, True, True, 0)

        self.password_entry = Gtk.Entry()
        self.password_entry.set_placeholder_text("Password")
        self.password_entry.set_visibility(False)
        vbox.pack_start(self.password_entry, True, True, 0)

        self.full_name_entry = Gtk.Entry()
        self.full_name_entry.set_placeholder_text("Full Name")
        vbox.pack_start(self.full_name_entry, True, True, 0)

        self.language_label = Gtk.Label("Select Language:")
        vbox.pack_start(self.language_label, True, True, 0)

        self.language_combo = Gtk.ComboBoxText()
        self.language_combo.append_text("en_US.UTF-8")
        self.language_combo.append_text("fr_FR.UTF-8")
        self.language_combo.append_text("de_DE.UTF-8")
        self.language_combo.append_text("bn_BD.UTF-8")  # Add Bengali language
        # Add more locales as needed
        vbox.pack_start(self.language_combo, True, True, 0)

        self.timezone_label = Gtk.Label("Select Timezone:")
        vbox.pack_start(self.timezone_label, True, True, 0)

        self.timezone_combo = Gtk.ComboBoxText()
        timezones = subprocess.check_output(["timedatectl", "list-timezones"]).decode().splitlines()
        for timezone in timezones:
            self.timezone_combo.append_text(timezone)
        vbox.pack_start(self.timezone_combo, True, True, 0)

        self.install_button = Gtk.Button(label="Install")
        self.install_button.connect("clicked", self.on_install_clicked)
        vbox.pack_start(self.install_button, True, True, 0)

    def on_install_clicked(self, button):
        username = self.username_entry.get_text()
        password = self.password_entry.get_text()
        full_name = self.full_name_entry.get_text()
        locale = self.language_combo.get_active_text()
        timezone = self.timezone_combo.get_active_text()

        # Perform installation
        subprocess.run(["useradd", "-m", username])
        subprocess.run(["passwd", username], input=f"{password}\n{password}\n".encode())

        # Set locale
        subprocess.run(["sudo", "localectl", "set-locale", f"LANG={locale}"])

        # Set timezone
        subprocess.run(["sudo", "timedatectl", "set-timezone", timezone])

        # Disable the service after user creation
        subprocess.run(["systemctl", "disable", "installer_script.service"])

        # Close the window after installation
        Gtk.main_quit()

win = InstallerWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()