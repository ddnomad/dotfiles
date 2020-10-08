# Fix for man-db errors
export MAN_DISABLE_SECCOMP=1

# Used by ~/scripts/dev to determine a development projects base directory
export DEV_ROOT=~/development

# Required by https://github.com/racer-rust/racer
export RUST_SRC_PATH=~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust

# PATH additions
PATH="${HOME}"/scripts:"${HOME}"/.cargo/bin:${PATH}
