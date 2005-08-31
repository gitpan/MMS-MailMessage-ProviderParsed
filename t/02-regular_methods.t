#!perl -T

use Test::More tests => 21;
use MMS::MailMessage::ProviderParsed;

my $message = new MMS::MailMessage::ProviderParsed;

is($message->headerdatetime("Somedate"),"Somedate");
is($message->headersubject("Subject"),"Subject");
is($message->headerfrom("From"),"From");
is($message->headerto("To"),"To");
is($message->headertext("Text"),"Text");

is($message->datetime("Somedate"),"Somedate");
is($message->subject("Subject"),"Subject");
is($message->from("From"),"From");
is($message->to("To"),"To");
is($message->text("Text"),"Text");

is($message->headerdatetime,"Somedate");
is($message->headersubject,"Subject");
is($message->headerfrom,"From");
is($message->headerto,"To");
is($message->headertext,"Text");

is($message->datetime,"Somedate");
is($message->subject,"Subject");
is($message->from,"From");
is($message->to,"To");
is($message->text,"Text");

is_deeply($message->retrievemimeattachments,[]);
