#!/usr/bin/perl
#use strict


my $game = $ARGV[0];

print "Current Game: $game\n";

#parse the game to determine score

my %scores_array = (
"X" => 10,
"-" => 0,
0 => 0,
1 => 1,
2 => 2,
3 => 3,
4 => 4,
5 => 5,
6 => 6,
7 => 7,
8 => 8,
9 => 9,
);

my $TOTAL_SCORE = 0;
my $count = 0;
my $current_score = 0;
my $last_score = 0;

$length_game = length($game);

for (my $i = 1; $i <= 10; $i++)
{

	#print "FRAME $i\t";
	if (substr($game,$count,1) =~ /X/)
	{
		$current_frame = substr($game,$count,1);
		#print "CURRENT FRAME: $current_frame\n";
		$count++;
	}
	else
	{
		$current_frame = substr($game,$count,2);
		#print "CURRENT FRAME: $current_frame\n";
		$count+=2;
	}
	
	$frame_score = &calculate_frame_score ($current_frame, $game, $count);
	
	$TOTAL_SCORE += $frame_score;
	#print "\tFrame Score: $frame_score\n";
	
}	

print "Bowling Score = $TOTAL_SCORE\n";
	
	

sub calculate_frame_score
{
	my $current_frame = shift;
	my $game = shift;
	my $count = shift;
	
	my $current_score = 0;
	
	
	#If the current frame resulted in a STRIKE - count 10 + the next 2 throws
	if ($current_frame =~ /X/)
	{
		$current_score = 10;
		
		my $Xframe1 = substr($game,$count,1);
		my $Xframe2 = substr($game,$count+1,1);
		
		my $Xframe1_score = $scores_array{$Xframe1};
		my $Xframe2_score = $scores_array{$Xframe2};
		
		if ($Xframe2 =~ /\//)
		{
			$Xframe2_score = 10-$Xframe1_score;
		}
		
		$current_score = 10 + $Xframe1_score + $Xframe2_score;
	}
	else
	{
		#The bowler did NOT get a STRIKE - therefore had 2 throws
		my $throw1 = substr($current_frame,0,1);
		my $throw2 = substr($current_frame,1,1);
		
		if ($throw2 =~ /\//) # the bowler got a spare!
		{
			$current_score = 10;
			my $Xframe1 = substr($game,$count,1);
			$current_score = 10 + $scores_array{$Xframe1};
		}
		else # the bowler did not get a spare nor a strike
		{
			$current_score = $scores_array{$throw1} + $scores_array{$throw2};
		}
	}
	
	return $current_score;
}
