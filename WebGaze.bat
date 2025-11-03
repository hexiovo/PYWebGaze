@echo off
cd /d "%~dp0"

:: 检查 Python
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python 3 not found! Downloading Python 3...
    
    :: 下载 Python 3 最新 x64 安装程序
    set "PYTHON_INSTALLER=python-3.12.1-amd64.exe"
    powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.12.1/python-3.12.1-amd64.exe -OutFile '%PYTHON_INSTALLER%'"

    echo Installing Python 3...
    :: 静默安装（修改 PATH，适用于默认安装路径）
    start /wait "" "%PYTHON_INSTALLER%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    
    :: 安装完成后删除安装包
    del "%PYTHON_INSTALLER%"
    
    echo Python 3 installed successfully.
)

:: 启动本地服务器
start "" python -m http.server 8000

:: 等待服务器启动
timeout /t 2 >nul

:: 打开 gaze.html
start "" http://localhost:8000/gaze.html
