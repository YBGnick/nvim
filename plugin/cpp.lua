vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/civitasv/cmake-tools.nvim",
    "https://git.sr.ht/~chinmay/clangd_extensions.nvim",
    "https://github.com/attilarepka/header.nvim",
    "https://github.com/RaafatTurki/hex.nvim",
    "https://github.com/NickTsaizer/splitasm.nvim",
    "https://github.com/J-Cowsert/classlayout.nvim",
    "https://github.com/GasparVardanyan/insights.nvim",
    "https://github.com/Badhi/nvim-treesitter-cpp-tools",
})
vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

require("header").setup({
    license_from_file = true
})

require("clangd_extensions").setup {}
require("classlayout").setup {} -- ClassLayout
require("insights").setup {}    -- ClassLayout
require 'nt-cpp-tools'.setup({
    preview = {
        quit = 'q',                           -- optional keymapping for quit preview
        accept = '<tab>'                      -- optional keymapping for accept preview
    },
    header_extension = 'h',                   -- optional
    source_extension = 'cxx',                 -- optional
    custom_define_class_function_commands = { -- optional
        TSCppImplWrite = {
            output_handle = require 'nt-cpp-tools.output_handlers'.get_add_to_cpp()
        }
    }
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "c" },
    callback = function(args)
        vim.keymap.set("n", "<leader>cu", function()
            require("cppman").open_for(vim.fn.expand("<cword>"))
        end, { buffer = args.buf, desc = "[C++] open under cursor" })

        vim.keymap.set("n", "<leader>ck", function()
            require("cppman").search()
        end, { buffer = args.buf, desc = "[C++] keyword search" })
    end,
})

local header = require("header")

vim.keymap.set("n", "<leader>hh", function() header.add_headers() end, { desc = "add headers" })


local nproc = tonumber(vim.fn.system({ "nproc" }))
local cmake_build_options = {}
local cmake_generate_options = {}

if 0 ~= nproc
then
    -- multithreading make/ninja
    vim.list_extend(cmake_build_options, { "-j" .. (nproc - 1) })
end

if 1 == vim.fn.executable("clang") and 1 == vim.fn.executable("clang++")
then
    vim.fn.setenv("CC", "/usr/bin/clang")
    vim.fn.setenv("CXX", "/usr/bin/clang++")
end

if 1 == vim.fn.executable("ccache")
then
    vim.fn.setenv("CMAKE_C_COMPILER_LAUNCHER", "ccache")
    vim.fn.setenv("CMAKE_CXX_COMPILER_LAUNCHER", "ccache")
end

if 1 == vim.fn.executable("ninja")
then
    vim.list_extend(cmake_generate_options, { "-G Ninja" })
end

require("cmake-tools").setup {
    cmake_build_options = cmake_build_options,
    cmake_generate_options = cmake_generate_options,
}

if 1 == vim.fn.executable("ccache")
then
    vim.fn.setenv("CMAKE_C_COMPILER_LAUNCHER", "ccache")
    vim.fn.setenv("CMAKE_CXX_COMPILER_LAUNCHER", "ccache")
end

if 1 == vim.fn.executable("iwyu-tool") and 1 == vim.fn.executable("iwyu-fix-includes")
then
    local nproc = tonumber(vim.fn.system({ "nproc" }))
    local iwyu_current
    local iwyu_root

    if 0 ~= nproc
    then
        iwyu_current = "w | !iwyu-tool -p . -j " .. (nproc - 1) .. " % | iwyu-fix-includes"
        iwyu_root = "w | !iwyu-tool -p . -j " .. (nproc - 1) .. " | iwyu-fix-includes"
    else
        iwyu_current = "w | !iwyu-tool -p . % | iwyu-fix-includes"
        iwyu_root = "w | !iwyu-tool -p . | iwyu-fix-includes"
    end

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ClangIWYU", { clear = true }),
        pattern = { "cpp" },
        callback = function(args)
            local bufnr = args.buf
            vim.api.nvim_buf_create_user_command(bufnr, "ClangIWYUCurrent",
                function() vim.cmd(iwyu_current) end, { nargs = 0 }
            )

            vim.api.nvim_buf_create_user_command(bufnr, "ClangIWYURoot",
                function() vim.cmd(iwyu_root) end, { nargs = 0 }
            )
        end
    })
end

local clang_config = {
    stdc = "c18",
    stdcpp = "c++23",
}

local clang_standard = function()
    if vim.bo.filetype == "cpp" then
        return "--extra-arg=-std=" .. clang_config.stdcpp
    elseif vim.bo.filetype == "c" then
        return "--extra-arg=-std=" .. clang_config.stdc
    else
        return ""
    end
end

local cppcheck_standard = function()
    if vim.bo.filetype == "cpp" then
        return "--std=" .. clang_config.stdcpp
    elseif vim.bo.filetype == "c" then
        return "--std=" .. clang_config.stdc
    else
        return ""
    end
end

local cppcheck_jnproc = ''

if 0 ~= nproc
then
    cppcheck_jnproc = "-j " .. (nproc - 1)
end

local clang_tidy = require("lint").linters.clangtidy
local cppcheck = require("lint").linters.cppcheck

-- https://clang.llvm.org/extra/clang-tidy/
vim.list_extend(clang_tidy.args, {
    clang_standard,
    "--checks=*" -- abseil, altera, android, boost, bugprone,
    -- cert, clang, concurrency, cppcoreguidelines, darwin,
    -- fuchsia, google, hicpp, linuxkernel, llvm, llvmlibc,
    -- misc, modernize, mpi, objc, openmp, performance,
    -- portability, readability, zircon

    .. ",-darwin-*"
    .. ",-linuxkernel-*"
    .. ",-llvmlibc-*"
    .. ",-objc-*"

    .. ",-altera-unroll-loops"
    .. ",-bugprone-easily-swappable-parameters"
    .. ",-fuchsia-default-arguments-calls"
    .. ",-fuchsia-default-arguments-declarations"
    .. ",-fuchsia-overloaded-operator"
    .. ",-fuchsia-trailing-return"
    .. ",-google-explicit-constructor"
    .. ",-hicpp-explicit-conversions"
    .. ",-llvm-else-after-return"
    .. ",-misc-non-private-member-variables-in-classes"
    .. ",-misc-use-anonymous-namespace"
    .. ",-modernize-use-trailing-return-type"
    .. ",-readability-else-after-return"
    .. ",-readability-function-cognitive-complexity"
    .. ",-readability-identifier-length"
    .. ",-readability-isolate-declaration"
    .. ",-readability-magic-numbers"
    .. ",-readability-redundant-access-specifiers"
    .. ",-readability-redundant-inline-specifier"
    .. ",-readability-simplify-boolean-expr"

    -- .. ",-cppcoreguidelines-avoid-do-while"
    -- .. ",-cppcoreguidelines-avoid-magic-numbers"
    -- .. ",-cppcoreguidelines-non-private-member-variables-in-classes"
    -- .. ",-cppcoreguidelines-owning-memory"
    -- .. ",-cppcoreguidelines-rvalue-reference-param-not-moved"
    -- .. ",-modernize-use-nodiscard"
})

vim.list_extend(cppcheck.args, {
    cppcheck_standard,
    cppcheck_jnproc,
    "--std=c++23",
    "--inline-suppr",
    "--quiet",
    "--template={file}:{line}:{column}",
    "--check-level=exhaustive",
    "--enable=all",
    "--suppress=missingIncludeSystem",
    "--suppress=unusedFunction",
})

local cmake = require("cmake-tools")

vim.api.nvim_create_user_command("CMakeRunPerf", function()
    cmake.run({ wrap_call = { "perf", "record", "--call-graph", "dwarf" } })
end, {})

vim.api.nvim_create_user_command("CMakeRunValgrind", function()
    cmake.run({ wrap_call = { "valgrind", "--leak-check=full", "--xml=yes", "--xml-file=valgrind.xml" } })
end, {})

vim.api.nvim_create_user_command("CMakeRunPerfCurrent", function()
    cmake.run_current_file({ wrap_call = { "perf", "record", "--call-graph", "dwarf" } })
end, {})

vim.api.nvim_create_user_command("CMakeRunValgrindCurrent", function()
    cmake.run_current_file({ wrap_call = { "valgrind", "--leak-check=full", "--xml=yes", "--xml-file=valgrind.xml" } })
end, {})
