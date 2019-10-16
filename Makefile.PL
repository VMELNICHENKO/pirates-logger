use 5.022;
use Config;
use XS::Install;

write_makefile(
    NAME      => 'CSGame::Logger',
    AUTHOR    => 'Vladimir Melnichenko',
    BIN_DEPS  => ['Export::XS', 'XS::Framework', 'CPP::panda::lib'],
    CPLUS     => 17,
    SRC       => ['src'],
    INC       => '-Isrc',
    CCFLAGS   => '-Wall -Wextra',
);
