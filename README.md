# qpOASES-dockerised
A simple dockerisation of qpOASES environment.

---
### Purpose ###

Isolate [qpOASES](https://projects.coin-or.org/qpOASES) into a pre-compiled docker image, so as to:

- Separate qpOASES code out of the build tree of further programs and applications
- Avoid unnecessarily repeating compiling of qpOASES

###Procedure of Usage###

1. (Optional) update qpOASES (currently v3.2.1 is used) and/or Alpine image (currently v3.10.2 is used).
	- By default, an image of alpine:3.10.2 of ~5.58MB is pulled automatically when the builder image is generated for the first time.
	- Modify `Dockerfile` and `Dockerfile.builder` if you choose to update or use another version of Alpine. 
	
2. Generate builder image using `Dockerfile.builder`.
> $ docker build -t qpoases-base:test -f Dockerfile.builder .

	- Modify `Dockerfile.builder` if you would like to use a different tag other than "qpoases-base:test".
	- A static library `/usr/local/lib/libqpOASES.a` will be available in the builder image, as well as all essential header files in `/usr/local/include`.

3. Put your own code into `src` folder, and modify `CMakefile.txt` and `Dockerfile` accordingly.
	- In each file that uses qpOASES functionalities, only a single line of `#include <qpOASES.hpp>` is needed.
	- No code files from qpOASES (**including** `qpOASES.hpp` **itself as well**) is needed in the code folder.
	- Pay attention to the file `Dockerfile` (especially Line 6 and 14) and modify the lines according to your executable file(s).

4. Compile your code and generate the docker image containing your executable(s), using `Dockerfile` by default.
> docker build -t your-own-image:version .
	- Line 3 and 4 in `Dockerfile` indicate that only `CMakeLists.txt` and the files in `src` will be sent to the command `$ docker build` i.e. qpOASES is excluded in this procedure.
	- Modify  `Dockerfile` accordingly if you have a different structure of repository.
	
###TODO###
- Remove unnecessary qpOASES components (e.g. interface for Matlab) to shrink the size of the builder image.