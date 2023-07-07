#!/usr/bin/perl
use strict;
use FileHandle;
use Time::Local;

# When classes start
my $start_date = [ 8,26,2013];
# When classes end
my $end_date =   [12, 7,2013];

# Start and end dates for midterms
#my $midterms =   [ [10,14,2013],  [10,19,2013] ];
my $midterms =   [ ];

# Start and end dates for finals
my $finals =     [ [12, 9,2013],  [12,14,2013] ];

# Pairs of start/end dates for holidays
my $holidays = [[ 9, 2, 2013], [ 9, 2,2013],
                [11, 7, 2013], [11,10,2013],
                [11,27, 2013], [12, 1,2013]];
# Which days of the week classes, meet. [2,4] for Tue and Thu.
my $class = [5];

# Basic class info
my $course_str = "Scientific Computing";
my $time_str = "8:30pm to 11:20pm";
my $text_str = "Scientific Computing";
my $author_str = "Steven R. Brandt and Frank Löffler";

# What gets taught on each class day
my @entries = (
"F Course Introduction; Survival skills for unix environments",
"F Record and share your work: revision control systems; Collaboration / project management",
"F Have a glance at your data: simple data visualization; Show off with your data: three-dimentional data visualization",
"S From source to result: compiling, debugging, profiling; Programming (best) practices",
"H The future of computing: going parallel",
"H Challanges in parallel computing",
"Review",
"S Beyond CPU computing",
"J Introduction to Distributed Scientific Computing",
"J Distributed Scientific Computing: MapReduce and Cloud Computing",
"P Simulation Basics; Simulating Complex Systems",
"P Framework Architectures; Getting Science out of Computing",
"Review",
"Final");

# Something specific to one class
# Expands shorthand
my %prof = (
    "S"=>"Steven Brandt",
    "F"=>"Frank Löffler",
    "H"=>"Hartmut Kaiser",
    "J"=>"Shantenu Jha",
    "P"=>"Peter Diener");

for(my $i=0;$i<=$#entries;$i++) {
    $entries[$i] =~ s/^([SFHJP]) (.*)/$prof{$1}.": $2"/e;
}

###### END CONFIGURATION ####

my $en = "";
my $entry = 0;
my $day = 3600*24;

my $i_start = date($start_date);
my $i_end = date($end_date);
my @mo = qw(XXX Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
my @wd = qw(Su  M Tu  W Th  F Sa &nbsp;);

my $i_0 = $i_start;
while(1) {
    my @t = localtime($i_0);
    last if($t[3] == 1);
    $i_0 = norm($i_0 - $day);
}
my $i_N = $i_end;
while(1) {
    my @t = localtime($i_N);
    last if($t[3] == 1);
    $i_N = norm($i_N + $day);
}
$i_N = norm($i_N - $day);

my $fd = new FileHandle;
open($fd,">cal.html") or die;

print $fd qq{
<html>
<head><title>Syllabus</title></head>
<style type="text/css">
td { font-family: Courier,Arial }
.class_day { background: #FFCCCC; font-weight: 900; }
.holiday { background: #CCCCFF; font-weight: 900; }
.test { background: #FFCCFF; font-weight: 900; }
.entry { background: #FFFFCC; }
.month { background: #CCCCCC; }
</style>
<body>
<table cellpadding='5' cellspacing='0' border='1'>
<tr><td class='month'>Course:</td><td class='month'>$course_str</td></tr>
<tr><td>Time:</td><td>$time_str</td></tr>
<tr><td>Text:</td><td>$text_str</td></tr>
<tr><td>Author:</td><td>$author_str</td></tr>
</table>
<br />
<table border='1' cellpadding='5' cellspacing='0'>
<tr><td class='month' colspan='2'>Key</td></tr>
<tr><td class='holiday'>&nbsp;</td><td>Holiday</td></tr>
<tr><td class='test'>&nbsp;</td><td>Testing Day</td></tr>
<tr><td class='class_day'>&nbsp;</td><td>Class Day</td></tr>
</table>
</br>
<table cellpadding='5' cellspacing='0' border='1'>
};
for(my $i=$i_0;$i<=$i_N;$i += $day) {
    $i = norm($i);
    my @t = localtime($i);
    my @n = localtime($i+$day);
    my ($m,$d,$y,$w) = ($t[4]+1,$t[3],$t[5]+1900,$t[6]);
    if($d == 1) {
        printf $fd "<tr><td class='month' colspan=8>%s</td></tr>\n",$mo[$m];
        print $fd "<tr>";
        for(my $j=0;$j<=$#wd;$j++) {
            printf $fd "<td>%s</td>",$wd[$j];
        }
        print $fd "</tr>\n";
        print $fd "<tr>";
        for(my $col = 0;$col < $w;$col++) {
            print $fd "<td>&nbsp;</td>";
        }
    }
    my $is_class_day = 0;
    if(date($start_date)-3600 < $i and $i < date($end_date)+3600) {
        for my $c (@$class) {
            if($w == $c) {
                $is_class_day = 1;
                last;
            }
        }
    }
    my $is_holiday = within($holidays,$i);
    my $is_midterm = within($midterms,$i);
    my $is_final = within($finals,$i);
    if($is_midterm and $is_class_day) {
        $en .= "; " unless($en eq "");
        $en .= $entries[$entry++];
        printf $fd "<td class='test'>%d</td>",$d;
    } elsif($is_final) {
        $en .= "; " unless($en eq "");
        $en .= $entries[$entry++];
        printf $fd "<td class='test'>%d</td>",$d;
    } elsif($is_holiday) {
        printf $fd "<td class='holiday'>%d</td>",$d;
    } elsif($is_class_day) {
        $en .= "; " unless($en eq "");
        $en .= $entries[$entry++];
        printf $fd "<td class='class_day'>%d</td>",$d;
    } else {
        printf $fd "<td>%d</td>",$d;
    }
    $en =~ s/[; ]+$//;
    if($t[4] != $n[4]) {
        for(my $col = $w; $col < 6;$col++) {
            print $fd "<td>&nbsp;</td>";
        }
        if($en eq "") {
            print $fd "<td></td></tr>\n";
        } else {
            print $fd "<td class='entry'>$en</td></tr>\n";
            $en = "";
        }
    } elsif($w == 6) {
        if($en eq "") {
            print $fd "<td></td></tr>\n";
        } else {
            print $fd "<td class='entry'>$en</td></tr>\n";
            $en = "";
        }
        print $fd "<tr>";
    }
}
print $fd qq{
</table>
</body>
</html>
};
close($fd);

sub date {
    my $a = shift;
    my ($m,$d,$y)=@$a;
    return timelocal(0,0,5,$d,$m-1,$y-1900);
}
sub norm {
    my $t = shift;
    my @t = localtime($t);
    return timelocal(0,0,5,$t[3],$t[4],$t[5]);
}
sub within {
    my $h = shift;
    my @h = @{$h};
    my $i = shift;
    while (@h) {
        my ($hs,$he) = splice @h,0,2;
        my ($ds,$de) = (date($hs)-3600,date($he)+3600);
        if($ds < $i and $i < $de) {
            return 1;
        }
    }
    return 0;
}
