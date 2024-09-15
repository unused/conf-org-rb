
# CFP Organization

Manage cfp submissions & voting for any event.

## Usage

```sh
make # build
make submissions # generate markdown files from submissions

# explore information
make console
> Reviewer.all.map(&:submission_url).uniq
> Submission.all.map(&:email).uniq.count
> Submission.all.map(&:location).tally
```

## Edit Submissions

In case you need to edit a submission content, you can do so with the cached
intermediate results in `export/submissions/*.md`. Those files won't be
overwritten, as long as author and title doesn't change. I kept the submissions
simply versioned with git to track changes. For instance, remove all results,
re-run the generation and see what changed.

## Practical Tips

Use git, also for managing submissions. The identifier checksum will ensure the
submission gets stored with the same file if the title and email doesn't
change. Remove and re-generate submission files to see what changed. Handle new
submissions by seeing they got added to your git repository.

Some characters like emojis or multi-byte characters might not be supported by
document generation. You can tweak the default template or replace the
characters.

