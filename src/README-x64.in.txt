FlexASIO @FLEXASIO_RELEASE_VERSION@ (x64)

Select FlexASIO in your 64-bit ASIO host application. This build includes
WASAPI (shared and exclusive) and WDM-KS. WASAPI shared mode is the default.
If your FlexASIO.toml selects DirectSound or MME, set backend = "Windows WASAPI".

The x64 folder includes PortAudioDevices.exe and FlexASIOTest.exe for
troubleshooting. See CONFIGURATION.md for buffer and device settings.
