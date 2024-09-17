-- TODO:
-- ya pack -a hankertrix/augment-command Ape/open-with-cmd yazi-rs/plugins#smart-filter ndtoan96/ouch
-- ya pack -i, ya pack -u

-- https://github.com/hankertrix/augment-command.yazi
require("augment-command"):setup({
	prompt = false,
	default_item_group_for_prompt = "hovered",
	smart_enter = true,
	smart_paste = false,
	enter_archives = false,
	extract_behaviour = "skip",
	must_have_hovered_item = true,
	skip_single_subdirectory_on_enter = true,
	skip_single_subdirectory_on_leave = true,
	ignore_hidden_items = false,
	wraparound_file_navigation = false,
})

require("zoxide"):setup({
	update_db = true,
})
