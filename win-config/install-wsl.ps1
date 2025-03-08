# Comprueba si el script se ejecuta con privilegios de administrador
$admin = [System.Security.Principal.WindowsPrincipal]::new(
    [System.Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $admin) {
    Write-Host "Este script necesita permisos de administrador. Reiniciando con privilegios elevados..."
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Write-Host "Habilitando WSL y Virtual Machine Platform..."
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Descarga el kernel de WSL 2 si es necesario
Write-Host "Verificando actualización del kernel de WSL 2..."
wsl --update

# Configura WSL 2 como predeterminado
Write-Host "Estableciendo WSL 2 como predeterminado..."
wsl --set-default-version 2

# Instala una distribución (por defecto Ubuntu)
$distros = wsl --list --online
if ($distros -match "Ubuntu") {
    Write-Host "Instalando Ubuntu..."
    wsl --install -d Ubuntu
} else {
    Write-Host "No se encontró Ubuntu en la lista de distribuciones disponibles."
}

Write-Host "Instalación de WSL 2 finalizada. Reinicia tu equipo para aplicar los cambios."

