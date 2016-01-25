CFLAGS=-ggdb
GTK=3.0
CXXFLAGS=$(CFLAGS) `sdl-config --cflags` `pkg-config gtk+-${GTK} --cflags`
LDFLAGS=`sdl-config --libs` `pkg-config gtk+-${GTK} --libs`
LIBS=-lSDL -lgtk-x11-2.0 -lgobject-2.0
INC=-I/usr/include/gtk-2.0/ -I/usr/include/glib-2.0/ -I/usr/lib/x86_64-linux-gnu/glib-2.0/include/ \
-I/usr/include/cairo/ -I/usr/include/pango-1.0/ -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include/ \
-I/usr/include/gdk-pixbuf-2.0/ -I/usr/include/atk-1.0/

sfxr: main.cpp tools.h sdlkit.h
	$(CXX) $(INC) $< $(CFLAGS) $(LIBS) -o $@
	#$(CXX) $< $(CXXFLAGS) $(LDFLAGS) -o $@

install: sfxr
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/share/sfxr
	mkdir -p $(DESTDIR)/usr/share/applications
	mkdir -p $(DESTDIR)/usr/share/icons/hicolor/48x48/apps
	install -m 755 sfxr $(DESTDIR)/usr/bin
	install -m 644 -p *.tga *.bmp $(DESTDIR)/usr/share/sfxr
	install -p -m 644 sfxr.png \
		$(DESTDIR)/usr/share/icons/hicolor/48x48/apps
	desktop-file-install --vendor "" \
		--dir $(DESTDIR)/usr/share/applications sfxr.desktop

clean:
	rm -f sfxr
