.PHONY: clean install

NAME=HandCrank_0.1.0
ZIPFILE=dist/$(NAME).zip

$(ZIPFILE):
	@rm -rf dist
	@mkdir -p dist/$(NAME)
	cp -R src/* dist/$(NAME)/
	luacheck --codes --ignore 631 --globals script data game defines table.deepcopy -- $$(find src -type f -name '*.lua')
	@rm -rf $@
	(cd dist && zip -9 -r ../$@ $(NAME))

clean:
	rm -rf dist

install: $(ZIPFILE)
	cp $(ZIPFILE) "$(HOME)/Library/Application Support/factorio/mods/"
