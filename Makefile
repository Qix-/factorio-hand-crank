.PHONY: clean

FILES:= \
	control.lua \
	data.lua \
	info.json \
	item.lua \
	locale

HandCrank_0.1.0.zip:
	luacheck --codes --ignore 631 --globals script data game defines table.deepcopy -- $$(find . -type f -name '*.lua')
	@rm -rf $@
	zip -9 $@ $(FILES)
