# Podmaniac
My personal set of containerized apps for everyday use

##### Cheats
* To see stale builds that prevent removal of images, execute `podman ps -a --external`
* To remove builds all at once, execute `podman ps -a --external --format "{{.ID}}" | xargs -r podman rm -f`
