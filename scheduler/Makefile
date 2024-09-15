CMD=podman
IMG=scheduler-local

.PHONY: server
server:
	@ruby server.rb

.PHONY: container
container:
	@$(CMD) build -f Containerfile -t scheduler-local .

# on systems with selinux mount with -v`pwd`/schedules:/app/schedules/:Z
.PHONY: run
run:
	@$(CMD) run -it --rm -v`pwd`/schedules:/app/schedules/ \
		-p 4567:4567 scheduler-local

.PHONY: watch
watch:
	@ls *.rb schedules/*.yaml | entr -r make server

.PHONY: console
console:
	@irb -r ./app.rb
