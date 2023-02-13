IMAGE_TAG=$(shell awk -F='/IMAGE_TAG/ {print $$2}' ../make.properties)

build-all: ueransimbase ueransim clean

.PHONY: ueransimbase ueransim clean
ueransimbase:
	docker build --build-arg ImageTag=${IMAGE_TAG} -t ${USER}/ueransimbase:{IMAGE_TAG} -f Dockerfile.base .

ueransim:
	IMAGE_TAG=${IMAGE_TAG} docker compose build
	docker image ls ${USER}/ueransim:{IMAGE_TAG}

clean:
	-docker rmi ${USER}/ueransim:${IMAGE_TAG}
	-docker rmi ${USER}/ueransimbase:${IMAGE_TAG}