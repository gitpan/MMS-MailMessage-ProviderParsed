#!perl -T

use Test::More tests => 1;
use MMS::MailMessage::ProviderParsed;

my $thing = new MMS::MailMessage::ProviderParsed;

can_ok('MMS::MailMessage::ProviderParsed', ('new'));

