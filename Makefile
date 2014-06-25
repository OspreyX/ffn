TMPREPO=/tmp/docs/ffn

.PHONY: dist docs css pages

dist:
	python setup.py sdist upload

docs: css
	$(MAKE) -C docs/ clean
	$(MAKE) -C docs/ html

css:
	lessc --clean-css docs/source/_themes/klink/static/less/klink.less docs/source/_themes/klink/static/css/klink.css

pages: docs
	rm -rf $(TMPREPO)
	git clone -b gh-pages git@github.com:pmorissette/ffn.git $(TMPREPO)
	rm -rf $(TMPREPO)/*
	cp -r docs/build/html/* $(TMPREPO)
	cd $(TMPREPO); \
	git add -A ; \
	git commit -a -m 'auto-updating docs' ; \
	git push