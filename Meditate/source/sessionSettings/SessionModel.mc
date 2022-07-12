using Toybox.Graphics as Gfx;
using HrvAlgorithms.HrvTracking;

module VibePattern {
	enum {
		LongPulsating = 1,
		LongContinuous = 2,
		LongAscending = 3,		
		ShortPulsating = 4,
		ShortContinuous = 5,
		ShortAscending = 6,
		MediumPulsating = 7,
		MediumContinuous = 8,
		MediumAscending = 9,
		ShorterAscending = 10,
		ShorterContinuous = 11,
		Blip = 12
	}
}

module ActivityType {
	enum {
		Meditating = 0,
		Yoga = 1
	}
}

class SessionModel {
	function initialize() {	
	}
		
	function fromDictionary(loadedSessionDictionary) {	
		me.time = loadedSessionDictionary["time"];
		me.color = loadedSessionDictionary["color"];
		me.vibePattern = loadedSessionDictionary["vibePattern"];
		me.activityType = loadedSessionDictionary["activityType"];		
		me.hrvTracking = loadedSessionDictionary["hrvTracking"];
	}

	function toDictionary() {	
		return {
			"time" => me.time,
			"color" => me.color,
			"vibePattern" => me.vibePattern,
			"activityType" => me.activityType,
			"hrvTracking" => me.hrvTracking
		};
	}
		
	function reset(index) {
		if (index == 0) {
		me.time = 15;
		me.color = Gfx.COLOR_BLUE;
		me.vibePattern = VibePattern.LongContinuous;		
		me.activityType = "Meditate";
		me.hrvTracking = HrvTracking.OnDetailed;
		}

		if (index == 1) {
		me.time = 5 * 60;
		me.color = Gfx.COLOR_GREEN;
		me.vibePattern = VibePattern.LongContinuous;		
		me.activityType = "Meditate";
		me.hrvTracking = HrvTracking.OnDetailed;
		}

		if (index == 2) {
		me.time = 10 * 60;
		me.color = Gfx.COLOR_YELLOW;
		me.vibePattern = VibePattern.LongContinuous;		
		me.activityType = "Meditate";
		me.hrvTracking = HrvTracking.OnDetailed;
		}

		if (index == 3) {
		me.time = 15 * 60;
		me.color = Gfx.COLOR_BLUE;
		me.vibePattern = VibePattern.LongContinuous;		
		me.activityType = "Meditate";
		me.hrvTracking = HrvTracking.OnDetailed;
		}

		if (index == 4) {
		me.time = 20 * 60;
		me.color = Gfx.COLOR_GREEN;
		me.vibePattern = VibePattern.LongContinuous;		
		me.activityType = "Meditate";
		me.hrvTracking = HrvTracking.OnDetailed;
		}
	}
	
	function copyNonNullFieldsFromSession(otherSession) {
    	if (otherSession.time != null) {
    		me.time = otherSession.time;
    	}
    	if (otherSession.color != null) {
    		me.color = otherSession.color;
    	}
    	if (otherSession.vibePattern != null) {
    		me.vibePattern = otherSession.vibePattern;
    	}
    	if (otherSession.activityType != null) {
    		me.activityType = otherSession.activityType;
    	}
    	if (otherSession.hrvTracking != null) {
    		me.hrvTracking = otherSession.hrvTracking;
    	}
	}
		
	var time;
	var color;
	var vibePattern;
	var activityType;
	var hrvTracking;
}