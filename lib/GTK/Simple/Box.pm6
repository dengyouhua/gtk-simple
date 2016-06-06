
use v6;

use GTK::Simple::Raw :box, :DEFAULT;
use GTK::Simple::Common;
use GTK::Simple::Container;

unit role GTK::Simple::Box does GTK::Simple::Container;

multi method new(*@packees) {
    my $box = self.bless();

    for @packees {
        if $_ ~~ Hash {
            $box.pack-start($_<widget>, $_<expand>, $_<fill>, $_<padding>);
        } else {
            $box.pack-start($_);
        }
    }

    $box
}

multi method pack-start($widget, Int $expand, Int $fill, Int $padding) {
    gtk_box_pack_start(self.WIDGET, $widget.WIDGET, $expand, $fill, $padding);
    gtk_widget_show($widget.WIDGET);
}

multi method pack-start($widget) {
    self.pack-start($widget, 1, 1, 0);
}

multi method pack_start($widget) {
    DEPRECATED('pack-start',Any,'0.3.2');
    self.pack-start($widget);
}

method spacing 
    returns Int
    is gtk-property(&gtk_box_get_spacing, &gtk_box_set_spacing)
    { * }
