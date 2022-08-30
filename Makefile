XORG_CONFIG = --net=host --env="DISPLAY" --volume="${HOME}/.Xauthority:/root/.Xauthority:rw"

build:
	docker build . -t chess

run:
	docker run -it ${XORG_CONFIG} --rm --name chess chess
