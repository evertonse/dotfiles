
PROJECT := evertonsantos_202100011379_opencl

install: $(shell find  ./.config/ type -d)
	python3 ./install -y

clean:
	rm -rf *.bin

push: 
	 git add . && git commit -m "$$(date)" && git push

pull:
	git pull

