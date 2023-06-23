
To build Docker Images that can be converted to Singularity Images and run on the HPC you must creat the image using a linux/amd64 architecture. 

To use an Silicon Silicon Mac (e.g., Apple M1 Max)m to build your images you will need to install Docker and Docker buildx

Docker buildx needs to be initialized to build for different architecures

`docker buildx ls`

`docker buildx create --use`


