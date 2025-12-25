
install:
	python3 ./installer.py -y

clean:
	rm -rf *.bin

push:
	chmod +x local/bin/*
	git add . && git commit -m "$$(date)${MSG}" && git push

pull:
	git pull


# TODO make ahk slow down mouse then in drawing software or my pressing a certain big combination of keys

WIN_STARTUP_DIR := "$$WIN_USERPROFILE/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup/"
ahk:
	@cp -r setup/windows/src/ahk/ /mnt/c/
	@mkdir -p "$(WIN_STARTUP_DIR)/"
	@cp setup/windows/startup.bat "$(WIN_STARTUP_DIR)/startup.bat"
	# wsl-open /mnt/c/ahk/league.ahk
	# wsl-open /mnt/c/ahk/mouse.ahk
	wsl-open "$(WIN_STARTUP_DIR)/startup.bat"


	# @cp setup/windows/src/ahk/wm.ahk /mnt/c/wm.ahk
	# wsl-open /mnt/c/wm.ahk



wsl-config: SOURCE = ./setup/windows/.wslconfig
wsl-config: DEST = "$$WIN_USERPROFILE/.wslconfig"
wsl-config:
	echo "Configuring wsl on guest linux vm ..."
	sudo cp config/wsl.conf /etc/wsl.conf
	echo "Configuring wsl on windows host ..."
	@rm -f $(DEST)
	cp $(SOURCE) $(DEST)
	echo "Displaying $$WIN_USERPROFILE/.wslconfig .."
	cat $(DEST)


ROAMING := "/mnt/c/Users/$(WIN_USER)/AppData/Roaming/alacritty/"

alacritty:
	@echo $(ROAMING)
	@rm -rf $(ROAMING)
	@cp -r ./config/alacritty/ $(ROAMING)
	


win-yank:
	# cp ./setup/windows/assets/win32yank.exe /mnt/c/Windows/System32/win32yank.exe
	cp ./setup/windows/assets/win32yank.exe /mnt/c/Windows/win32yank.exe

file2clip: OURCE = "setup/windows/assets/file2clip.exe"
file2clip: DEST = "$$WINDOWS_DRIVER_PATH/Windows/"
file2clip:
	cp -i $(SOURCE) $(DEST)


win: ahk wsl-config alacritty file2clip

	@cp -r ./config/alacritty/ $(ROAMING)


.PHONY: push pull clean install ahk wsl-config win file2clip
