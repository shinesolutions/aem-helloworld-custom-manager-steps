version ?= 0.10.1-pre.0

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
	--exclude=".rtk.json" \
		--exclude="Gemfile" \
		--exclude="Makefile" \
	  .

publish:
	gh release create $(version) --title $(version) --notes "" || echo "Release $(version) has been created on GitHub"
	gh release upload $(version) stage/aem-helloworld-custom-manager-steps-$(version).tar.gz

release-major:
	rtk release --release-increment-type major

release-minor:
	rtk release --release-increment-type minor

release-patch:
	rtk release --release-increment-type patch

release: release-minor

.PHONY: ci clean lint package publish release release-major release-minor release-patch
