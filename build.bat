git clone https://github.com/getsentry/sentry-native.git
cd sentry-native
git submodule update --init --recursive

cmake -B build -D SENTRY_BACKEND=crashpad
cmake --build build --config RelWithDebInfo
cmake --install build --prefix install --config RelWithDebInfo
tree /f install

mkdir "C:\Program Files (x86)\sentry"
xcopy /E /I "install\*" "C:\Program Files (x86)\sentry"