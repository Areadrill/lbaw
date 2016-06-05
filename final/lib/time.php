<?php
//taken from https://css-tricks.com/snippets/php/time-ago-function/
function ago($time)
{
	   $periods = array("second", "minute", "hour", "day", "week", "month", "year", "decade");
	      $lengths = array("60","60","24","7","4.35","12","10");
	   $time = $time+60*60;

	      $now = time();

	             $difference     = $now - $time;
	             $tense         = "ago";

		        for($j = 0; $difference >= $lengths[$j] && $j < count($lengths)-1; $j++) {
				       $difference /= $lengths[$j];
				          }

		        $difference = round($difference);

		        if($difference != 1) {
				       $periods[$j].= "s";
				          }

			   return $difference." ".$periods[$j]." ago";
}
?>
