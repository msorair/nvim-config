return {
	"chipsenkbeil/distant.nvim",
	branch = "v0.3",
	config = function()
		require("distant"):setup({
			servers = {
				["172.17.0.2"] = {
					cwd = "/home/uto/uto",
					launch = {
						bin = "/home/uto/.local/bin/distant",
					},
					connect = {
						default = {
							username = "uto",
						},
					},
				},
			},
		})
	end,
}
