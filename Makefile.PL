use 5.022;
use Config;
use Panda::Install;

write_makefile(
    NAME      => 'CSGame::Logger',
    AUTHOR    => 'Vladimir Melnichenko',
#    TYPEMAPS  => ['typemap'],
    BIN_DEPS => ['Export::XS', 'XS::Framework', 'CPP::panda::lib'],
    CPLUS    => 17,
    SRC      => ['src', 'xs'],
    INC      => '-Isrc',
    CCFLAGS  => '-Wall -Wextra',
);
