.PHONY: clean install

NAME=HandCrank_0.1.0
ZIPFILE=dist/$(NAME).zip

FILES:= \
	control.lua \
	data.lua \
	info.json \
	prototypes \
	locale

$(ZIPFILE):
	@rm -rf dist
	@mkdir -p dist/$(NAME)
	cp -R $(FILES) dist/$(NAME)
	luacheck --codes --ignore 631 --globals script data game defines table.deepcopy -- $$(find . -type f -name '*.lua')
	@rm -rf $@
	(cd dist && zip -9 -r ../$@ $(NAME))

clean:
	rm -rf dist

install: $(ZIPFILE)
	cp $(ZIPFILE) "$(HOME)/Library/Application Support/factorio/mods/"
