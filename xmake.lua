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

local S7_VERSION = "20231115"
add_requires("s7 "..S7_VERSION, {system=false})

target("s7") do
  add_packages ("s7")
  add_files("repl.c")
  on_install(function (target)
    if is_plat("linux", "macosx") then
      os.cp("$(buildir)/$(plat)/$(arch)/$(mode)/s7", "$(buildir)/s7_$(plat)_$(arch)")
    elseif is_plat("windows") then 
      os.cp("$(buildir)/$(plat)/$(arch)/$(mode)/s7.exe", "$(buildir)/s7_$(plat)_$(arch).exe")
    else
      print("Unsupported platform!!!")
    end
    if is_plat("macosx") and is_arch("arm64") then
      os.exec("codesign  --force --sign  - $(buildir)/s7_macosx_arm64")
    end
  end)
end

target("plus.scm") do
  if is_plat("linux", "macosx") then
    on_run(function (target)
      cmd = "$(buildir)/$(plat)/$(arch)/$(mode)/s7 " .. "tests/plus.scm"
      print("> " .. cmd)
      os.exec(cmd)
    end)
  end
  if is_plat("windows") then
    on_run(function (target)
      cmd = "$(buildir)/$(plat)/$(arch)/$(mode)/s7.exe " .. "tests/plus.scm"
      print("> " .. cmd)
      os.exec(cmd)
    end)
  end
end
