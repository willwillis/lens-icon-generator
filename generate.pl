#!/usr/bin/perl
use strict;
use File::Basename;


my $text_glow_path = "/home/will/.local/bin";
my $icon_out_path = "/home/will/x/code/lens-icon-generator/examples";

my @fonts = ('MagettasDemoBold-vL39.ttf'); # 'MagettasDemo-2R7o.ttf', 'NeonSans-GOgRg.ttf','Gerdu-X3l1o.otf','Infantry-PK5Mr.ttf','FrontlineRegular-z8eG1.ttf','UniquelySprayed-PXOx.ttf','Reactive-3zz73.ttf');

my $account = "SBX";  # Sandbox Account
my @regions = ('AF'); # AWS Region: Capetown
my @environments = ('01'..'02');
my @colors = qw(wheat1 YellowGreen fuchsia purple orange red blue white yellow orange SlateBlue1 lavender);


foreach my $color (@colors) {
    foreach my $rgn (@regions) {
        foreach my $env (@environments) {
	    print "Generating icon for $rgn / $env\n";
      	    foreach my $font (@fonts) {
    	         my $environment =  join('\n', $account, $rgn, $env);
    	         command($environment,$font,$color);
    	    }
        }
    }
}


sub command {
    my $env_name = shift;
    my $font_name = shift;
    my $color = shift;
    my $outfile = $icon_out_path . '/' . join('.',$env_name, basename($font_name) , $color ,'png');
    $outfile =~ s/\s//g;
    $outfile =~ s/\\n//g;
    print $outfile, "\n";
    system($text_glow_path . "/textglow -P 150 -T '$color' -G '$color' -t '$env_name' -f $font_name '$outfile'");
}
