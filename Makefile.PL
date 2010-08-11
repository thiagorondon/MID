
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME => 'MID',
    VERSION_FROM => "lib/POE/Component/Server/MID.pm",    
    ABSTRACT => 'Simple ID Server and Client',
    PREREQ_PM => {
        'Module::Build' => 0.36,
        'ExtUtils::MakeMaker' => 6.31,
        'ExtUtils::Install' => 1.46,
        'Test::More' => 0.90,
        'Net::EasyTCP' => 0.26,
        'MooseX::Traits' => 0.11,
        'namespace::autoclean' => 0.11,
        'Data::UUID' => 1.215
    },
    LICENSE => 'perl',
    #EXE_FILES => [ 'bin/sipa' ],
);

