-------------------------------------------------------------------------------
--
-- MODULE      : packages.lua
-- DESCRIPTION : Xmake package config file for TeXmacs
-- COPYRIGHT   : (C) 2023       jingkaimori
--                   2022-2023  Darcy Shen
--
-- This software falls under the GNU general public license version 3 or later.
-- It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
-- in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.

set_xmakever("2.8.5")

set_project("s7-scheme-binary")

add_repositories("mogan-repo xmake")

local S7_VERSION = "20230413"
add_requires("s7 "..S7_VERSION, {system=false})

target("s7") do
  add_packages ("s7")
  add_files("repl.c")
end
