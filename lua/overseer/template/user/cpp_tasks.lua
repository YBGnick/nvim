-- lua/overseer/templates/cpp_tasks.lua
local binary = require("utils.cmake_binary")
local overseer = require("overseer")

-- Helper: build first, then run a tool
local function build_then(tool_cmd_fn)
  return function()
    local bin = binary.get_binary()
    if not bin then
      vim.notify("No binary found", vim.log.levels.ERROR)
      return
    end
    overseer.run_template({ name = "CMake Build" }, function(task)
      if task then
        -- after build completes, run the tool
        task:subscribe("on_complete", function(_, status)
          if status == overseer.STATUS.SUCCESS then
            overseer.new_task({
              cmd = tool_cmd_fn(bin),
              components = {
                "default",
                { "on_complete_notify", statuses = { "SUCCESS", "FAILURE" } },
                { "on_output_quickfix", open = true },
              },
            }):start()
          else
            vim.notify("Build failed, skipping run", vim.log.levels.WARN)
          end
        end)
      end
    end)
  end
end

return {

  -----------------------------------------------------------------------
  -- 1. CMake Configure
  -----------------------------------------------------------------------
  {
    name = "CMake Configure",
    builder = function()
      return {
        cmd = "cmake",
        args = {
          "-S", ".",
          "-B", "build",
          "-DCMAKE_BUILD_TYPE=Debug",
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
        },
        components = {
          "default",
          { "on_complete_notify" },
          { "on_output_quickfix", open_on_match = true },
        },
      }
    end,
    condition = { filetype = { "cpp", "c", "cmake" } },
  },

  -----------------------------------------------------------------------
  -- 2. CMake Build
  -----------------------------------------------------------------------
  {
    name = "CMake Build",
    builder = function()
      return {
        cmd = "cmake",
        args = { "--build", "build", "--parallel" },
        components = {
          "default",
          { "on_complete_notify" },
          { "on_output_quickfix",   open_on_match = true },
          -- clear binary cache on rebuild
          { "on_complete_callback", callback = function() binary.clear_cache() end },
        },
      }
    end,
    condition = { filetype = { "cpp", "c", "cmake" } },
  },

  -----------------------------------------------------------------------
  -- 3. Run Binary
  -----------------------------------------------------------------------
  {
    name = "Run Binary",
    builder = function()
      local bin = binary.get_binary()
      local args = vim.fn.input("Args: ")
      return {
        cmd = bin,
        args = vim.split(args, " ", { trimempty = true }),
        components = {
          "default",
          { "on_complete_notify" },
          { "on_output_quickfix", open = true },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 4. Valgrind Memcheck
  -----------------------------------------------------------------------
  {
    name = "Valgrind Memcheck",
    builder = function()
      local bin = binary.get_binary()
      local args = vim.fn.input("Program args: ")
      return {
        cmd = "valgrind",
        args = vim.list_extend({
          "--tool=memcheck",
          "--leak-check=full",
          "--show-leak-kinds=all",
          "--track-origins=yes",
          "--verbose",
          "--error-exitcode=1",
          "--log-file=/tmp/valgrind.log",
          bin,
        }, vim.split(args, " ", { trimempty = true })),
        components = {
          "default",
          { "on_complete_notify" },
          -- parse valgrind output into quickfix on completion
          {
            "on_complete_callback",
            callback = function(_, status)
              vim.cmd("cfile /tmp/valgrind.log")
              vim.cmd("copen")
              vim.notify(
                status == "SUCCESS" and "Valgrind: No errors!" or "Valgrind: Issues found",
                status == "SUCCESS" and vim.log.levels.INFO or vim.log.levels.WARN
              )
            end,
          },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 5. Valgrind Callgrind (CPU profiling)
  -----------------------------------------------------------------------
  {
    name = "Valgrind Callgrind",
    builder = function()
      local bin = binary.get_binary()
      return {
        cmd = "valgrind",
        args = {
          "--tool=callgrind",
          "--callgrind-out-file=/tmp/callgrind.out",
          "--branch-sim=yes",
          "--cache-sim=yes",
          bin,
        },
        components = {
          "default",
          { "on_complete_notify" },
          {
            "on_complete_callback",
            callback = function()
              -- open KCachegrind automatically
              vim.fn.jobstart("kcachegrind /tmp/callgrind.out &")
              vim.notify("Callgrind done — opening KCachegrind", vim.log.levels.INFO)
            end,
          },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 6. Heaptrack
  -----------------------------------------------------------------------
  {
    name = "Heaptrack",
    builder = function()
      local bin = binary.get_binary()
      local args = vim.fn.input("Program args: ")
      return {
        cmd = "heaptrack",
        args = vim.list_extend(
          { bin },
          vim.split(args, " ", { trimempty = true })
        ),
        components = {
          "default",
          { "on_complete_notify" },
          {
            "on_complete_callback",
            callback = function()
              -- find the most recent heaptrack output and open GUI
              local handle = io.popen("ls -t heaptrack.*.gz 2>/dev/null | head -1")
              if handle then
                local latest = handle:read("*l")
                handle:close()
                if latest and latest ~= "" then
                  vim.fn.jobstart("heaptrack_gui " .. latest .. " &")
                  vim.notify("Opening heaptrack_gui: " .. latest, vim.log.levels.INFO)
                else
                  vim.notify("No heaptrack output found", vim.log.levels.WARN)
                end
              end
            end,
          },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 7. perf record
  -----------------------------------------------------------------------
  {
    name = "Perf Record",
    builder = function()
      local bin = binary.get_binary()
      local args = vim.fn.input("Program args: ")
      return {
        cmd = "perf",
        args = vim.list_extend({
          "record",
          "-g",                    -- call graph
          "--call-graph", "dwarf", -- better stack unwinding for C++
          "-o", "/tmp/perf.data",
          bin,
        }, vim.split(args, " ", { trimempty = true })),
        components = {
          "default",
          { "on_complete_notify" },
          {
            "on_complete_callback",
            callback = function()
              vim.notify("perf.data written to /tmp/perf.data", vim.log.levels.INFO)
            end,
          },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 8. perf report (in toggleterm)
  -----------------------------------------------------------------------
  {
    name = "Perf Report",
    builder = function()
      return {
        cmd = "perf",
        args = { "report", "-i", "/tmp/perf.data", "--stdio" },
        components = {
          "default",
          -- stream output to a terminal so you get the interactive TUI
          { "on_output_terminal", open = true },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 9. Hotspot (perf GUI)
  -----------------------------------------------------------------------
  {
    name = "Hotspot",
    builder = function()
      return {
        cmd = "hotspot",
        args = { "/tmp/perf.data" },
        components = { "default", { "on_complete_notify" } },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 10. AddressSanitizer Run
  -----------------------------------------------------------------------
  {
    name = "ASan Run",
    builder = function()
      -- expects a separate ASan build at build-asan/
      local bin = binary.find_binary("build-asan") or binary.get_binary()
      local args = vim.fn.input("Program args: ")
      return {
        cmd = bin,
        args = vim.split(args, " ", { trimempty = true }),
        env = {
          ASAN_OPTIONS = "detect_leaks=1:halt_on_error=0:log_path=/tmp/asan",
          UBSAN_OPTIONS = "print_stacktrace=1:log_path=/tmp/ubsan",
        },
        components = {
          "default",
          { "on_complete_notify" },
          {
            "on_complete_callback",
            callback = function()
              -- load all asan log files into quickfix
              vim.cmd("cexpr []")
              for _, f in ipairs(vim.fn.glob("/tmp/asan.*", false, true)) do
                vim.cmd("caddfile " .. f)
              end
              vim.cmd("copen")
            end,
          },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },

  -----------------------------------------------------------------------
  -- 11. Full Workflow: Configure → Build → ASan Run
  -----------------------------------------------------------------------
  {
    name = "Full: Configure → Build → ASan",
    builder = function()
      return {
        -- overseer supports task chaining via dependencies
        name = "Full C++ Workflow",
        dependencies = {
          { name = "CMake Configure" },
          { name = "CMake Build" },
        },
        cmd = "echo",
        args = { "Pipeline complete" },
        components = {
          "default",
          { "on_complete_notify" },
        },
      }
    end,
    condition = { filetype = { "cpp", "c" } },
  },
}
