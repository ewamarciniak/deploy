#!/usr/bin/perl
# fslyne 2013

use strict;
use warnings;
use Email::Send;
use Email::Send::Gmail;
use Email::Simple::Creator;

my $email = Email::Simple->create(
    header => [
        From    => 'deploy.project.2014@gmail.com',
        To      => 'emarciniak78@gmail.com',
        Subject => 'Problems with the site',
    ],
    body => 'We have encountered some problems on the website - check if services are running and used memory levels !',
);

my $sender = Email::Send->new(
    {   mailer      => 'Gmail',
        mailer_args => [
            username => 'deploy.project.2014@gmail.com',
            password => '123passwor',
        ]
    }
);
eval { $sender->send($email) };
die "Error sending email: $@" if $@;
