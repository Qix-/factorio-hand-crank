.PHONY: clean install

NAME=HandCrank_0.1.0

FILES:= \
	control.lua \
	data.lua \
	info.json \
	item.lua \
	locale

dist/$(NAME).zip:
	@rm -rf dist
	@mkdir -p dist/$(NAME)
	cp -R $(FILES) dist/$(NAME)
	luacheck --codes --ignore 631 --globals script data game defines table.deepcopy -- $$(find . -type f -name '*.lua')
	@rm -rf $@
	(cd dist && zip -9 -r ../$@ $(NAME))

clean:
	rm -rf dist

install:
	cp dist/$(NAME).zip "$(HOME)/Library/Application Support/factorio/mods/"
