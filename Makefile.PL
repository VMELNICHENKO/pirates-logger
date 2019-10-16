use 5.020;
use Config;
use Panda::Install;

write_makefile(
    NAME      => 'Pirates::Log',
    AUTHOR    => 'Vladimir Melnichenko',
    TYPEMAPS  => ['typemap'],
    BIN_DEPS  => [ 'Panda::Event', 'Panda::XS', 'Panda::Lib' ],
    SRC       => ['src', 'xs'],
    BUILD_REQUIRES => { "Panda::Install" => 0 },
    CCFLAGS  => '-O0 -g -ggdb3',
);
