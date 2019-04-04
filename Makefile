version ?= 0.10.0-pre

ci: clean lint package

clean:
	rm -rf .bundle/ bin/ stage/ *.lock

lint:
	shellcheck *.sh

package: clean
	mkdir -p stage
	chmod +x *.sh
	tar \
	  -zcvf stage/aem-helloworld-custom-manager-steps-$(version).tar.gz \
    --exclude="*.DS_Store" \
    --exclude="*bin*" \
    --exclude="*stage*" \
    --exclude="*.idea*" \
    --exclude="*.git*" \
		--exclude="*.lock*" \
    --exclude="*.bundle*" \
    --exclude=".*.yml" \
		--exclude="Gemfile" \
		--exclude="Makefile" \
	  .

.PHONY: ci clean lint package
