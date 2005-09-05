package MMS::MailMessage::ProviderParsed;

use warnings;
use strict;

use base 'MMS::MailMessage';

=head1 NAME

MMS::MailMessage::ProviderParsed - A class representing a parsed MMS (or picture) message, that has been parsed as originating from a specific network provider.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

This class is used by MMS::Parser to provide a final data storage class after the MMS has been parsed by the provider mail parser.  It inherits from the MMS::MailMessage class and extends it's methods to allow access to parsed properties.

=head1 METHODS

The MMS::MailMessage::ProviderParsed class inherits all the methods from it's parent class MMS::MailMessage.

=head2 Constructor

=over

=item new()

Return a new MMS::MailMessage::ProviderParsed object.

=back

=head2 Regular Methods

=over

=item add_picture MIME::Entity

Adds the supplied MIME::Entity attachment to the picture stack for the message.  This method is mainly used by the MMS::MailProviderParser class to add pictures while parsing.

=item add_video MIME::Entity

Adds the supplied MIME::Entity attachment to the video stack for the message.  This method is mainly used by the MMS::MailProviderParser class to add videos while parsing.

=item pictures 

Returns an array reference to an array of pictures from the message.

=item videos

Returns an array reference to an array of videos from the message.

=item datetime STRING

Returns the time and date the MMS was sent when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the headerdatetime property if a datetime property has not been explicitly set.

=item from STRING

Returns the sending email address the MMS was sent from when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the headerfrom property if a from property has not been explicitly set.

=item to STRING

Returns the recieving email address the MMS was sent to when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the headerto property if a to property has not been explicitly set.

=item subject STRING

Returns the MMS subject when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the headersubject property if a subject property has not been explicitly set.

=item text STRING

Returns the MMS body text when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the headertext property if a text property has not been explicitly set.

=item retrieve_attachments STRING

Expects a mime-type to be passed as an argument and a regular expression match using the supplied string is applied to each attachment in the attachment stack of the message object and a reference to an array of objects where the mime-type matches the supplied string is returned.  In the event no attachment was matched to the supplied mime-type an undef value is returned.

=back

=head2 Deprecated Methods

Methods listed here are maintained for backwards compatibility and should not be used in new code as they may be removed in future versions.

=over

=item addvideo

Equivalent to add_video

=item addpicture

Equivalent to add_picture

=item retrievemimeattachments

Equivalent to retrieve_attachments

=back

=head1 AUTHOR

Rob Lee, C<< <robl@robl.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-mms-message-providerparsed@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MMS-MailMessage-ProviderParsed>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 NOTES

To quote the perl artistic license ('perldoc perlartistic') :

10. THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
    WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES
    OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=head1 ACKNOWLEDGEMENTS

As per usual this module is sprinkled with a little Deb magic.

=head1 COPYRIGHT & LICENSE

Copyright 2005 Rob Lee, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

sub new {

  my $class = shift;
  my $message = shift;
  my $self  = $class->SUPER::new();

  bless ($self, $class);

  if (defined($message)) {
    $self->SUPER::_clonedata($message);
  }

  $self->{pictures} = [];
  $self->{videos} = [];

  return $self;
}

sub subject {

  my $self = shift;
  my $subject = shift;

  unless (defined $subject) {
    if (exists($self->{subject})) {
      return $self->{subject};
    } elsif (defined $self->header_subject) {
      return $self->header_subject;
    } else {
      return undef;
    }
  }
  $self->{subject} = $subject;
}

sub to {

  my $self = shift;
  my $to = shift;

  unless (defined $to) {
    if (exists($self->{to})) {
      return $self->{to};
    } elsif (defined $self->header_to) {
      return $self->header_to;
    } else {
      return undef;
    }
  }
  $self->{to} = $to;
}

sub from {

  my $self = shift;
  my $from = shift;

  unless (defined $from) {
    if (exists($self->{from})) {
      return $self->{from};
    } elsif (defined $self->header_from) {
      return $self->header_from;
    } else {
      return undef;
    }
  }
  $self->{from} = $from;
}

sub datetime {

  my $self = shift;
  my $datetime = shift;

  unless (defined $datetime) {
    if (exists($self->{datetime})) {
      return $self->{datetime};
    } elsif (defined $self->header_datetime) {
      return $self->header_datetime;
    } else {
      return undef;
    }
  }
  $self->{datetime} = $datetime;
}

sub text {

  my $self = shift;
  my $text = shift;

  unless (defined $text) {
    if (exists($self->{text})) {
      return $self->{text};
    } elsif (defined $self->header_text) {
      return $self->header_text;
    } else {
      return undef;
    }
  }
  $self->{text} = $text;
}

sub pictures {

  my $self = shift;
  my $pictures = shift;

  unless (defined $pictures) {
    if (exists($self->{pictures})) {
      return $self->{pictures};
    } else {
      return undef;
    }
  }
  $self->{pictures}=$pictures;
  
}

sub videos {

  my $self = shift;
  my $videos = shift;

  unless (defined $videos) {
    if (exists($self->{videos})) {
      return $self->{videos};
    } else {
      return undef;
    }
  }
  $self->{videos}=$videos;

}

sub add_picture {

  my $self = shift;
  my $picture = shift;

  unless (defined($picture)) {
    return 0;
  }

  push @{$self->{pictures}}, $picture;

  return 1;

}

sub add_video {

  my $self = shift;
  my $video = shift;

  unless(defined $video) {
    return 0;
  }

  push @{$self->{videos}}, $video;

  return 1;

}

sub retrieve_attachments {

  my $self = shift;
  my $type = shift;

  unless (defined $type) {
    return [];
  }
  
  my @mimeattachments;
  foreach my $attachment (@{$self->attachments}) {
    if ($attachment->mime_type =~ /$type/) {
      push @mimeattachments, $attachment;
    }
  }

  if (@mimeattachments>0) {
    return \@mimeattachments;
  } else {
    return [];
  } 

}

# Deprecated methods ##############
#

sub addpicture {
  add_picture(@_);
}
sub addvideo {
  add_video(@_);
}
sub retrievemimeattachments {
  retrieve_attachments(@_);
}


1; # End of MMS::MailMessage::ProviderParsed
