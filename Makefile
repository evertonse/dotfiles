
PROJECT := evertonsantos_202100011379_opencl

$(PROJECT).bin: $(PROJECT).cpp
	g++ -Wall -O3 -std=c++0x -o $(PROJECT).bin $(PROJECT).cpp -lOpenCL

run: $(PROJECT).bin
	./$(PROJECT).bin ./opencl.input ./opencl.output &> $(PROJECT).log

clean:
	rm -rf *.bin

push: 
	 git add . && git commit -m "$$(date)" && git push

pull:
	git pull

