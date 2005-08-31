use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'MMS::MailMessage::ProviderParsed',
    AUTHOR              => 'Rob Lee <robl@robl.co.uk>',
    VERSION_FROM        => 'lib/MMS/MailMessage/ProviderParsed.pm',
    ABSTRACT_FROM       => 'lib/MMS/MailMessage/ProviderParsed.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'MMS-MailMessage-ProviderParsed-*' },
);
