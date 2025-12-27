return {
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		ft = { "lua", "rust", "sql", "python", "javascript", "typescript", "bash" }, -- Explicitly load for these filetypes
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Ensure treesitter loads first
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					notify = false, -- disable notifications
					use_treesitter = true,
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
					style = {
						{ fg = "#806d9c" }, -- purple
						{ fg = "#c21f30" }, -- red for errors
					},
					textobject = "test",
					max_file_size = 1024 * 1024,
					error_sign = true,
					delay = 100, -- add delay to ensure treesitter is ready
				},
				indent = {
					enable = true,
					use_treesitter = false,
					chars = { "│" },
					style = { "#3b4261" }, -- dim color for regular lines
				},
			})

			-- Add SQL support by defining which node types are chunks
			local ft_types = require("hlchunk.utils.ts_node_type")

			ft_types.sql = {
				all_fields = true,
				binary_expression = true,
				case = true,
				cast = true,
				cte = true,
				float = true,
				from = true,
				group_by = true,
				invocation = true,
				join = true,
				list = true,
				marginalia = true,
				not_like = true,
				object_reference = true,
				order_by = true,
				order_target = true,
				parenthesized_expression = true,
				partition_by = true,
				program = true,
				relation = true,
				select = true,
				select_expression = true,
				set_operation = true,
				statement = true,
				subquery = true,
				where = true,
				window_function = true,
				window_specification = true,
			}

			-- Add command to debug chunk detection
			vim.api.nvim_create_user_command("HlchunkDebug", function()
				local bufnr = vim.api.nvim_get_current_buf()
				local cursor = vim.api.nvim_win_get_cursor(0)
				local pos = { bufnr = bufnr, row = cursor[1] - 1, col = cursor[2] }

				print("=== HlChunk Debug ===")
				print(string.format("Filetype: %s, Cursor: (%d, %d)", vim.bo.filetype, cursor[1], cursor[2]))

				-- Check if treesitter node exists
				local node = vim.treesitter.get_node({
					bufnr = bufnr,
					pos = { pos.row, pos.col },
				})

				if not node then
					print("ERROR: No treesitter node at cursor!")
					return
				end

				print("Node at cursor: " .. node:type())

				-- Walk up tree and check each node
				local ft_types = require("hlchunk.utils.ts_node_type")
				local rust_types = ft_types.rust or {}

				print("\nWalking up tree:")
				local current = node
				local depth = 0
				while current and depth < 10 do
					local ntype = current:type()
					local is_suitable = rust_types[ntype] or false
					print(string.format("  [%d] %s (suitable: %s)", depth, ntype, tostring(is_suitable)))
					current = current:parent()
					depth = depth + 1
				end

				-- Now run the actual chunk detection
				local helper = require("hlchunk.utils.chunkHelper")
				local retcode, scope = helper.get_chunk_range({
					pos = pos,
					use_treesitter = true,
				})

				local RET = helper.CHUNK_RANGE_RET
				local status = "UNKNOWN"
				if retcode == RET.OK then
					status = "OK"
				elseif retcode == RET.NO_CHUNK then
					status = "NO_CHUNK"
				elseif retcode == RET.NO_TS then
					status = "NO_TS"
				elseif retcode == RET.CHUNK_ERR then
					status = "CHUNK_ERR"
				end

				print(
					string.format(
						"\nResult: Status: %s, Range: %d to %d",
						status,
						scope.start or -1,
						scope.finish or -1
					)
				)
			end, {})

			-- Add command to extract all node types from the current buffer's parse tree
			vim.api.nvim_create_user_command("GetAllNodeTypes", function()
				local filetype = vim.bo.filetype
				local ok, parser = pcall(vim.treesitter.get_parser, 0, filetype)

				if not ok or not parser then
					print("ERROR: No treesitter parser found for filetype: " .. filetype)
					return
				end

				local all_nodes = {}

				-- Walk the entire tree and collect node types
				local function collect_nodes(node)
					if not node then
						return
					end
					local node_type = node:type()
					all_nodes[node_type] = true

					-- Recursively walk children
					for child in node:iter_children() do
						collect_nodes(child)
					end
				end

				-- Parse the buffer and walk the tree
				local trees = parser:parse()
				for _, tree in ipairs(trees) do
					collect_nodes(tree:root())
				end

				-- Sort and print them
				local sorted = {}
				for name, _ in pairs(all_nodes) do
					table.insert(sorted, name)
				end
				table.sort(sorted)

				print(string.format("=== All node types found in current buffer (%d total) ===", #sorted))
				for _, name in ipairs(sorted) do
					print("  " .. name)
				end

				-- Also generate a ready-to-use table
				print("\n=== Ready to use (copy this) ===")
				print("ft_types." .. filetype .. " = {")
				for _, name in ipairs(sorted) do
					-- Filter out obvious non-chunk types (punctuation, simple keywords, literals)
					if
						not name:match("^%p") -- Skip punctuation
						and not name:match("^keyword_") -- Skip keywords
						and not name:match("^literal") -- Skip literals
						and not name:match("^comment") -- Skip comments
						and not name:match("^string") -- Skip strings
						and not name:match("^number") -- Skip numbers
						and not name:match("^identifier$") -- Skip basic identifiers
						and not name:match("^field$") -- Skip basic fields
						and not name:match("^term$")
					then -- Skip basic terms
						print(string.format("  %s = true,", name))
					end
				end
				print("}")
			end, {})
		end,
	},
}
