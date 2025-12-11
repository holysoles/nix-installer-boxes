.PHONY: default build test clean 

default: build

build:
	for box in $$(find -name *.pkr.hcl); do\
		packer init $$box &&\
		packer validate $$box &&\
		packer build -force -on-error=abort $$box ;\
	done

test:
	for dir in $$(find ./artifacts -maxdepth 1 -mindepth 1 -type d); do\
		box=$$(basename $$dir) &&\
		vagrant box add --force nix-installer "artifacts/$$box/package.box" &&\
		vagrant up --provider=libvirt &&\
		vagrant ssh -c "$$(cat ./tests/check-commands.sh)" ;\
	done	

clean:
	vagrant destroy --force ||\
	vagrant box remove nix-installer ||\
	rm -rf artifacts
