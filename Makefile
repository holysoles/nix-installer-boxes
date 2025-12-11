.PHONY: default build test clean 

default: build

build:
	@for box in $(shell find . -name "*.pkr.hcl" -print0); do \
		packer init $$box &&\
		packer validate $$box &&\
		packer build -force -on-error=abort $$box ;\
	done

test:
	@for dir in $(shell find ./artifacts -maxdepth 1 -mindepth 1 -type d -print0 | xargs -0); do \
		workspace="$$(pwd)" &&\
		cd "$$dir" &&\
		box=$$(basename $$dir) &&\
		echo "Testing box artifact: $$box" &&\
		vagrant up --provider=libvirt &&\
		vagrant ssh -c "$$(cat "$$workspace/tests/check-commands.sh")" output &&\
		cd "$$workspace" ;\
	done	

clean:
	@echo "Cleaning up..." ;\
	for dir in $(shell find ./artifacts -maxdepth 1 -mindepth 1 -type d -print0 | xargs -0); do \
		workspace="$$(pwd)" &&\
		cd "$$dir" &&\
		vagrant destroy --force &&\
		cd "$$workspace" ;\
	done ;\
	rm -rf artifacts
