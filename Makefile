name = "untitled-game"

all: linux macos windows web
	cd /tmp; mkdir $(name); mv $(name)-linux.zip $(name)-macos.zip $(name)-windows.zip $(name)-web.zip $(name); zip -r $(name).zip $(name)

linux:
	mkdir -p /tmp/$(name)-linux
	/usr/bin/godot --export "Linux" "/tmp/$(name)-linux/$(name)"
	cd /tmp; zip -r $(name)-linux.zip $(name)-linux/
	#rm -r /tmp/$(name)-linux

macos:
	/usr/bin/godot --export "Mac OS" "/tmp/$(name)-macos.zip"
	mv "/tmp/$(name)-macos.app" "/tmp/$(name)-macos.zip"

windows:
	mkdir -p /tmp/$(name)-windows
	/usr/bin/godot --export "Windows" "/tmp/$(name)-windows/$(name).exe"
	cd /tmp; zip -r $(name)-windows.zip $(name)-windows
	#rm -r /tmp/$(name)-windows

web:
	mkdir -p /tmp/$(name)-web
	/usr/bin/godot --export "HTML5" "/tmp/$(name)-web/index.html"
	cd /tmp; zip -r $(name)-web.zip $(name)-web
	#rm -r /tmp/$(name)-web

clean:
	rm -r /tmp/$(name)*
