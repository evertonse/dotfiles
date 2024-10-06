
install:
	python3 ./installer.py -y

clean:
	rm -rf *.bin

push:
	 git add . && git commit -m "$$(date)${MSG}" && git push

pull:
	git pull

SOURCE = ./config/league.ahk
DEST = /mnt/c/league.ahk

ahk:
	@rm -f $(DEST)
	@cp $(SOURCE) $(DEST)
	wsl-open $(DEST)


ROAMING := "/mnt/c/Users/$(WIN_USER)/AppData/Roaming/alacritty/"

alacritty:
	@echo $(ROAMING)
	@rm -rf $(ROAMING)
	@cp -r ./config/alacritty/ $(ROAMING)
	

WIN_USERPROFILE := "/mnt/c/Users/$(WIN_USER)"
wslconfig:
	cp ./setup/win/.wslconfig $(WIN_USERPROFILE)

	

.PHONY: push pull clean install
