using Toybox.Attention;

class Vibe {
	static function vibrate(pattern) {

		switch (pattern) {
			case VibePattern.LongContinuous:
				Attention.playTone(Attention.TONE_SUCCESS);
				break;
			case VibePattern.LongPulsating:
				Attention.playTone(Attention.TONE_ALARM);
				break;
			case VibePattern.LongAscending:
				Attention.playTone(Attention.TONE_ALERT_HI);
				break;
			case VibePattern.MediumContinuous:
				Attention.playTone(Attention.TONE_LOUD_BEEP);
				break;
			case VibePattern.MediumPulsating:
				Attention.playTone(Attention.TONE_TIME_ALERT);
				break;
			case VibePattern.MediumAscending:
				Attention.playTone(Attention.TONE_START);
				break;
			case VibePattern.ShortContinuous:
				Attention.playTone(Attention.TONE_CANARY);
				break;
			case VibePattern.ShortPulsating:
				Attention.playTone(Attention.TONE_LOW_BATTERY);
				break;
			case VibePattern.ShortAscending:
				Attention.playTone(Attention.TONE_ALERT_LO);
				break;
			case VibePattern.ShorterAscending:
				Attention.playTone(Attention.TONE_ERROR);
				break;
			case VibePattern.ShorterContinuous:
				Attention.playTone(Attention.TONE_FAILURE);
				break;
			case VibePattern.Blip:
				Attention.playTone(Attention.TONE_MSG);
				break;
			default:
				Attention.playTone(Attention.TONE_SUCCESS);
				break;
		}
	}
}