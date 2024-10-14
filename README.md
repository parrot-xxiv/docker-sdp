## Installation

Download [ManageEngine_ServiceDesk_Plus.bin](https://sdpondemand.manageengine.com/Register.do?opDownload&deployment=Onpremises?sdpadminguide)

1. `docker volume create volume_sdp` 
- for data persistence
2. `docker build -t servicedesk-plus .`
- to build the image
3. `docker run -p 8080:8080 --name servicedesk-plus -v volume_sdp:/opt/manageengine-sdp servicedesk-plus` 
- to run the container using the built image and created volume, expose 8080

### Re-install 
- `docker volume rm volume_sdp`
- use another volume

>**Container: servicedesk-plus-oct**  
user: `administrator`  
pass: `P@ssword`
