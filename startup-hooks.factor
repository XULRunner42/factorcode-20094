V{
    { "alien" [ H{ } clone callbacks set-global ] }
    {
        "destructors"
        [
            H{ } clone disposables set-global
            V{ } clone always-destructors set-global
            V{ } clone error-destructors set-global
        ]
    }
    {
        "io.backend"
        [ init-io embedded? [ init-stdio ] unless ]
    }
    {
        "alien.strings"
        [
            8 special-object utf8 alien>string
            string>cpu \ cpu set-global
            9 special-object utf8 alien>string
            string>os \ os set-global
            67 special-object utf8 alien>string
            \ vm-compiler set-global
        ]
    }
    {
        "io.files"
        [
            cwd current-directory set-global
            13 special-object alien>native-string cwd
            prepend-path \ image set-global
            14 special-object alien>native-string cwd
            prepend-path \ vm set-global
            image parent-directory "resource-path" set-global
        ]
    }
    {
        "source-files.errors"
        [ V{ } clone error-observers set-global ]
    }
    {
        "compiler.units"
        [ V{ } clone definition-observers set-global ]
    }
    { "vocabs" [ V{ } clone vocab-observers set-global ] }
    { "command-line" [ default-cli-args ] }
    { "threads" [ init-threads ] }
    { "cpu.x86.features" [ \ sse-version reset-memoized ] }
    {
        "io.thread"
        [ t io-thread-running? set-global start-io-thread ]
    }
    {
        "environment"
        [
            "FACTOR_ROOTS" os-env [
                os windows? ";" ":" ? split
                [ add-vocab-root ] each
            ] when*
        ]
    }
    {
        "tools.crossref"
        [ invalidate-crossref add-definition-observer ]
    }
    {
        "io.launcher"
        [ H{ } clone processes set-global start-wait-thread ]
    }
    {
        "random.unix"
        [
            "/dev/random" <unix-random> &dispose
            secure-random-generator set-global
            "/dev/urandom" <unix-random> &dispose
            system-random-generator set-global
        ]
    }
    {
        "bootstrap.random"
        [
            default-mersenne-twister random-generator
            set-global
        ]
    }
    {
        "tools.deprecation"
        [ \ deprecation-observer add-definition-observer ]
    }
    {
        "vocabs.cache"
        [
            f changed-vocabs set-global
            cache-observer add-vocab-observer
        ]
    }
    {
        "vocabs.refresh.monitor"
        [
            "-no-monitors" (command-line) member?
            [ start-monitor-thread ] unless
        ]
    }
    { "opengl.gl" [ reset-gl-function-pointers ] }
    {
        "pango.fonts"
        [ \ (cache-font-description) reset-memoized ]
    }
    {
        "pango.cairo"
        [ <cache-assoc> cached-layouts set-global ]
    }
    {
        "ui"
        [
            f \ ui-running set-global
            <flag> ui-notify-flag set-global
        ]
    }
    { "ui.tools.error-list" [ updater add-error-observer ] }
}
