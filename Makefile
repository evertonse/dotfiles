
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
ahk:
	@cp setup/win/src/ahk/league.ahk /mnt/c/league.ahk
	wsl-open /mnt/c/league.ahk

	@cp setup/win/src/ahk/wm.ahk /mnt/c/wm.ahk
	wsl-open /mnt/c/wm.ahk




wsl-config: SOURCE = ./setup/win/.wslconfig
wsl-config: DEST = "$$WIN_USERPROFILE/.wslconfig"
wsl-config:
	echo "Configuring wsl on guest linux vm ..."
	sudo cp config/wsl.conf /etc/wsl.conf
	echo "Configuring wsl on windows host ..."
	@rm -f $(DEST)
	cp $(SOURCE) $(DEST)
	echo "Opening $$WIN_USERPROFILE/.wslconfig .."
	wsl-open $(DEST)


ROAMING := "/mnt/c/Users/$(WIN_USER)/AppData/Roaming/alacritty/"

alacritty:
	@echo $(ROAMING)
	@rm -rf $(ROAMING)
	@cp -r ./config/alacritty/ $(ROAMING)


file2clip: OURCE = "setup/win/assets/file2clip.exe"
file2clip: DEST = "$$WINDOWS_DRIVER_PATH/Windows/"
file2clip:
	cp -i $(SOURCE) $(DEST)


win: ahk wsl-config alacritty file2clip

	@cp -r ./config/alacritty/ $(ROAMING)


.PHONY: push pull clean install ahk wsl-config win file2clip
