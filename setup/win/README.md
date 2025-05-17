# Some scripts '.ps1' need the execution policy to not be remote signed to execute

    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
