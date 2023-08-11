#!/usr/bin/perl
use strict;
use utf8;
use open qw(:std :utf8);
use Cwd qw(abs_path);
use Mail::Header;
use Mail::Address;
use Encode qw(decode);

# Collect targets
my %target;

my $header = Mail::Header->new([<>], Modify => 0);
sub parse_target {
    my (@addrs) = @_;
    foreach my $addr (@addrs) {
        my $phrase = $addr->phrase();
        if (!$phrase) {
            $target{$addr->user()} = $addr->format();
            next;
        }
        $phrase = lc decode "MIME-Header", $phrase;
        $phrase =~ s/\s/-/g;
        $target{$phrase} = $addr->format();
    }
}
parse_target(Mail::Address->parse($header->get($_))) for qw(To Cc Bcc);

# Read and write back the aliases
my $aliasfile = $ENV{ALIASFILE} || abs_path($ENV{HOME} . "/.config/mutt/muttrc.aliases");
open my $alias, "<", $aliasfile
    or die "Can't open alias file for read: $!";
while (my $line = <$alias>) {
    $line =~ /^alias\s+(-group\s+\w+)?([-\w]+)/ or next;
    delete $target{$2};
}
close $alias;
open $alias, ">>", $aliasfile
    or die "Can't open alias file for write: $!";
while (my ($k, $v) = each (%target)) {
    print $alias "alias $k $v\n";
}
close $alias;

