
# Scheduler

Conference agenda/schedule organization.

# Usage & Development

The application renders schedules from YAML files and provides a web interface
for visualization and comparison.

```sh
# All program details are stored in `schedules/*.yaml` files. Any YAML file
# that is prefixed with an underscore `_` is considered a for display, so you
# can have any other files as draft ready to be used for comparison.
#
# The yaml files hold all days and slots with their respective talks or other
# type of events and is used to render a schedule using a local webserver.
$ ls -l schedules/

$ make # run dev server, visit at localhost:4567

# Find details of CFP submissions that are used to populate the schedule with
# random entries. Those can be identified as they end with a (?) in the title.
# The details are prefilled so we can work on a real program rather than moving
# around empty slots.
$ cat cfp-details.yaml
```

## Use With Container

```sh
$ CMD=docker make build
# or $ docker build -f Containerfile -t scheduler-local .
$ CMD=docker make run
# or $ docker run -it --rm -v`pwd`/schedules:/app/schedules/ \
#   -p 4567:4567 scheduler-local
```
