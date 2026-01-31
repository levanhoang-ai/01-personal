# ---- Root Makefile for Sphinx Docs (auto venv) ----

VENV        = .venv
PYTHON      = $(VENV)/bin/python
SPHINXBUILD = $(VENV)/bin/sphinx-build
SPHINXAUTO  = $(VENV)/bin/sphinx-autobuild
PIP         = $(VENV)/bin/pip

DOCSDIR     = docs
SOURCEDIR   = $(DOCSDIR)/source
BUILDDIR    = $(DOCSDIR)/_build

.PHONY: help venv clean html livehtml

help:
	@echo "Targets:"
	@echo "  make venv       Create venv + install docs deps"
	@echo "  make html       Build HTML docs"
	@echo "  make livehtml   Live reload docs (hot reload)"
	@echo "  make clean      Clean build files"

venv:
	python3 -m venv $(VENV)
	$(PIP) install -U pip
	$(PIP) install -r $(DOCSDIR)/requirements.txt
	$(PIP) install sphinx-autobuild

clean:
	rm -rf $(BUILDDIR)

html:
	$(SPHINXBUILD) -b html $(SOURCEDIR) $(BUILDDIR)/html

livehtml:
	$(SPHINXAUTO) $(SOURCEDIR) $(BUILDDIR)/html \
		--host 0.0.0.0 \
		--port 4321 \
		--open-browser
