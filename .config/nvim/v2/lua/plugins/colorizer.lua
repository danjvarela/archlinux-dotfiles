local default_opts = {
	RGB = true, -- #RGB hex codes
	RRGGBB = true, -- #RRGGBB hex codes
	names = true, -- "Name" codes like Blue
	RRGGBBAA = true, -- #RRGGBBAA hex codes
	rgb_fn = true, -- CSS rgb() and rgba() functions
	hsl_fn = false, -- CSS hsl() and hsla() functions
	css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
	mode = "background", -- Set the display mode.
}

return {
	"norcalli/nvim-colorizer.lua",
	opts = {
		css = default_opts,
		javacript = default_opts,
		typescript = default_opts,
		yaml = default_opts,
	},
}
