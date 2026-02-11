# inception
- create and image: Dockerfile << instructions for creating that image
- each instruction is a layer, only layers that have changes are rebuilt 
    when changing Dockerfile
- image: template/instructions for creating docker container
- container: container instance of an image
- When a container is removed, any changes to its state that aren't stored in persistent storage disappear
