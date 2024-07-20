git clone https://github.com/jstkdng/ueberzugpp.git ~/code/ueberzugpp/
cd ~/code/ueberzugpp/
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_X11=OFF -DENABLE_OPENCV=OFF ..
cmake --build .
