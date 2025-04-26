using Toybox.Lang;

class TimeFormatter {
	static function format(timeInSec) {		
		var timeCalc = timeInSec;
		var seconds = timeCalc % 60;
		timeCalc /= 60;
		var minutes = timeCalc % 60;
		timeCalc /= 60;
		var hours = timeCalc % 24;
		
		var formattedTime = Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), seconds.format("%02d")]);
		return formattedTime;
	}

	static function formatHours(timeInSec) {		
		var timeCalc = timeInSec;
		var hours = timeCalc % 24;
		
		var formattedTime;
		
		if (hours == 1) {
			formattedTime = Lang.format("$1$ hour", [hours.format("%02d")]);
		} else {
			formattedTime = Lang.format("$1$ hours", [hours.format("%02d")]);
		}

		return formattedTime;
	}

	static function formatMinutes(timeInSec) {		
		var timeCalc = timeInSec;
		timeCalc /= 60;
		var minutes = timeCalc % 60;
		timeCalc /= 60;
		
		var formattedTime = Lang.format("$1$ Minutes", [minutes.format("%02d")]);
		return formattedTime;
	}

	static function formatSeconds(timeInSec) {		
		var timeCalc = timeInSec;
		var seconds = timeCalc % 60;
		timeCalc /= 60;
		timeCalc /= 60;
		
		var formattedTime = Lang.format("$1$ Seconds", [seconds.format("%02d")]);
		return formattedTime;
	}
}