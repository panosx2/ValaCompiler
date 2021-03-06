/***
  BEGIN LICENSE
  Copyright (C) 2017 Basem Kheyar<basjam@gmail.com>
  This program is free software: you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License version 3, as
  published by the Free Software Foundation.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranties of
  MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
  PURPOSE.  See the GNU General Public License for more details.
  You should have received a copy of the GNU General Public License along
  with this program.  If not, see <http://www.gnu.org/licenses>
  END LICENSE
***/

namespace ValaCompiler.Widgets {
    public class FilesListRow : Gtk.Box {
        public Gtk.ToggleButton toggle_button;
        public Gtk.Image active_icon;
        
        private string file;
        private bool active;
        
        public signal void active_changed (string file, bool active);
        
        public FilesListRow (string file_incoming) {
            this.file = file_incoming;
            this.get_style_context ().add_class (Granite.STYLE_CLASS_CARD);
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.spacing = 0;
            this.hexpand = true;
            this.active = true;
            
            active_icon = new Gtk.Image ();
            update_active_icon ();
            active_icon.halign = Gtk.Align.FILL;
            active_icon.margin_top = 5;
            active_icon.margin_bottom = 7;
            active_icon.margin_left = 12;
            
            toggle_button = new Gtk.ToggleButton.with_mnemonic (file);
            toggle_button.draw_indicator = true;
            toggle_button.xalign = 0;
            toggle_button.image = active_icon;
            toggle_button.always_show_image = true;
            toggle_button.tooltip_text = _("Click to toggle file");
            toggle_button.toggled.connect (() => {
                this.active = toggle_button.active;
                active_changed (file, active);
                update_active_icon ();
            });
            
            this.pack_start (toggle_button, true, true, 0);
        }
        
        public bool get_active () {
            return this.active;
        }
        
        public string get_file () {
            return this.file;
        }
        
        public void update_active_icon () {
            if (active) {
                active_icon.set_from_icon_name ("user-available", Gtk.IconSize.DND);
            } else {
                active_icon.set_from_icon_name ("user-busy", Gtk.IconSize.DND);
            };
        }
    }
}
