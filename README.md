# Sentry Native Install script
Useful template for pipelines that need to install sentry-native

1. Take note of the RelWithDebInfo flag, make sure you use the correct flag for whatever environment you're deploying to

Rule of thumb:
- DEV -> Debug
- CERT -> RelWithDebInfo
- PROD -> Release

https://stackoverflow.com/questions/48754619/what-are-cmake-build-type-debug-release-relwithdebinfo-and-minsizerel

2. Make sure you add `...\sentry\bin` to PATH in pipelines (here is tutorial for [local](https://gist.github.com/nex3/c395b2f8fd4b02068be37c961301caa7))
- Windows
```
echo "C:\Program Files (x86)\sentry\bin" | Out-File -FilePath $env:GITHUB_PATH -Encoding utf8 -Append
```

- MacOS/Linux

## Notes:

### Windows
- Use .bat file
- Run as admin on Windows

### macOS, Linux
- Use .sh file