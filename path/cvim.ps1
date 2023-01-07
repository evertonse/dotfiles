#Requires -Version 7.1
$ErrorActionPreference = "Stop" # exit when command fails

$env:XVIM_BASE_PATH   = "C:\Users\ExCyber\AppData\Local\nvim-cybervim"

$env:XDG_DATA_HOME    = "$env:XVIM_BASE_PATH"   
$env:XDG_CONFIG_HOME  = "$env:XVIM_BASE_PATH"   
$env:XDG_CACHE_HOME   = "$env:XVIM_BASE_PATH"   

#$env:XDG_RUNTIME_DIR  = "$env:XDG_DATA_HOME\nvim.astrovim"
# $env:XDG_CONFIG_DIR   = "$env:XDG_CONFIG_HOME\nvim.astrovim"
# $env:XDG_CACHE_DIR    = "$env:XDG_CACHE_HOME\nvim.astrovim-data"
# $env:XDG_BASE_DIR     = "$env:LUNARVIM_RUNTIME_DIR\nvim.astrovim"

nvim  -u "$env:XVIM_BASE_PATH\nvim\init.lua" @args

