use strict;
use Cwd;
my $argv = shift (@ARGV) if $ARGV[0] =~ /^--/;

my $directory = $ARGV[0] || cwd;
$directory =~ tr/\x2F/\x5C/;
$directory .= "\x5C" unless $directory =~ /\x5C$/;
opendir DIR, $directory;
  my @files = map {$directory.$_} grep {/\.ht(?:ml?|t)$/} readdir(DIR);
close DIR;

unless ($argv eq '--remove') {
  print "REGEDIT4\n\n";
} else {
  print "var wsh = WScript.CreateObject ('WScript.Shell');\n";
}
for my $file (@files) {
  my %option;
  open SRC, $file;
  while (<SRC>) {
    if (/^#([a-z]+)\x20+(.+)$/) {
      $option{$1} = $2;
    }
  }
  close SRC;
  next unless $option{name};
  my (@f,%f) = split /[\x20\x09]+/, $option{context}, $option{flag};
  for (@f) {$f{$_} = 1}
  unless ($argv eq '--remove') {
    print scalar mkregsection ($option{name} => $file, %f);
  } else {
    print scalar mkremovejs ($option{name});
  }
}

sub mkregsection ($$;%) {
  my ($menuname, $filename, %option) = @_;
  $menuname =~ s/\x5C/\x5C\x5C/g;
  $filename =~ s/\x5C/\x5C\x5C/g;
  my $s = sprintf <<'EOH', $menuname, $filename;
[HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MenuExt\%s]
@="%s"
EOH
  my ($contexts, $flags) = (0, 0);
  $contexts |= 0x1 if $option{default};
  $contexts |= 0x2 if $option{image};
  $contexts |= 0x4 if $option{control};
  $contexts |= 0x8 if $option{table};
  $contexts |= 0x10 if $option{textselect};
  $contexts |= 0x20 if $option{anchor};
  $contexts |= 0x40 if $option{unknown};
  $flags |= 0x1 if $option{showdialog};
  $s .= sprintf ("\"Contexts\"=dword:%08X\n", $contexts || 1);
  $s .= sprintf "\"Flags\"=dword:%08X\n", $flags if $flags;
  $s."\n";
}

sub mkremovejs ($) {
  my $s = 'HKCU\Software\Microsoft\Internet Explorer\MenuExt\\';
  $s .= shift;
  $s =~ s/\x5C/\x5C\x5C/g;
  $s =~ s/\x27/\x5C\x27/g;
  "wsh.RegDelete ('$s\\\\');\n";
}

=head1 LICENSE

Copyright 2002 wakaba E<lt>w@suika.fam.cxE<gt>.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; see the file COPYING.  If not, write to
the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.

=head1 CHANGE

See ChangeLog.
$Date: 2002/03/30 13:47:56 $

=cut
