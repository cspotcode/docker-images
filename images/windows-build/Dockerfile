# escape=`
# BASED ON DOCS HERE: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2017

# Use the latest Windows Server Core image with .NET Framework 4.7.2.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download the Build Tools bootstrapper.
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.AzureBuildTools `
    --add Microsoft.VisualStudio.Workload.MSBuildTools `
    --add Microsoft.VisualStudio.Workload.NetCoreBuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Workload.WebBuildTools `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
    --remove Microsoft.VisualStudio.Component.Windows81SDK `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Define the entry point for the Docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

###########

ADD https://dist.nuget.org/win-x86-commandline/v4.3.0/nuget.exe C:\\Nuget\\nuget.exe

ADD https://github.com/mesonbuild/meson/releases/download/0.54.0/meson-0.54.0-64.msi C:\Downloads\meson.msi
RUN msiexec /i "C:\\Downloads\\meson.msi"

ADD https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0-win64-x64.msi C:\\Downloads\cmake.msi
RUN msiexec /i "C:\\Downloads\\cmake.msi"

ADD https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/win64/nasm-2.14.02-win64.zip C:\\Downloads\nasm.zip
RUN powershell.exe -NoP -NonI -Command "Expand-Archive 'C:\\Downloads\\nasm.zip' 'C:\nasm'"

ADD http://strawberryperl.com/download/5.30.2.1/strawberry-perl-5.30.2.1-64bit.msi C:\Downloads\perl.msi
RUN msiexec /i "C:\\Downloads\\perl.msi"

ADD https://www.python.org/ftp/python/3.8.2/python-3.8.2-amd64.exe C:\Downloads\python.exe
RUN C:\Downloads\python.exe /simple /quiet /passive /log C:\Downloads\python-installation-log.txt

RUN SETX /M Path "%Path%;C:\\Nuget;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\BuildTools\\MSBuild\\15.0\\Bin;C:\\nasm"


# RUN git clone https://github.com/cisco/openh264.git -b<branch|tag>

# git clone https://github.com/openssl/openssl.git -b<branch|tag>

# git clone https://github.com/FreeRDP/freerdp.git -b<branch|tag>
