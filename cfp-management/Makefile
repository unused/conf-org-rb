
# build & generate CFP reports
all: submissions pdf epub

# generage PDF reports
.PHONY: pdf
pdf: $(addsuffix .pdf, $(basename $(wildcard ./export/*.md)))

# transform markdown files to pdf using pandoc
%.pdf: %.md
	@pandoc -o $@ $<

# generage epub reports
.PHONY: epub
epub: $(addsuffix .epub, $(basename $(wildcard ./export/*.md)))

# transform markdown files to epub using pandoc
%.epub: %.md
	@pandoc -o $@ $<

# extract submissions
submissions:
	@ruby main.rb

# list all submission titles
titles:
	@echo 'puts Submission.all.map(&:title).sort.join("\n")' | ruby -r ./lib/app.rb

console:
	@irb -r ./lib/app.rb

# remove exported cfp submissions & generated reports
clean:
	@rm -f ./export/*.*
