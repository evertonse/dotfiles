install:
	python3 ./install -y

clean:
	rm -rf *.bin

push: 
	 git add . && git commit -m "$$(date)${MSG}" && git push

pull:
	git pull

.PHONY: push pull clean install
