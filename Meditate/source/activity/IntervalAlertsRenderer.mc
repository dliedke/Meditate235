using Toybox.Graphics as Gfx;
using Toybox.Lang;

class IntervalAlertsRenderer {
	function initialize(sessionTime, repeatIntervalAlerts, radius, width) {
		me.mSessionTime = sessionTime;
		me.mRepeatIntervalAlerts = repeatIntervalAlerts;	
		me.mRadius = radius;
		me.mWidth = width;	
		me.mRepeatPercentageTimes = me.createPercentageTimes(repeatIntervalAlerts);	
	}
	
	private var mSessionTime;
	private var mRepeatIntervalAlerts;
	private var mRadius;
	private var mWidth;	
    private var mRepeatPercentageTimes;
    
    function drawRepeatIntervalAlerts(dc) {    
		me.drawIntervalAlerts(dc, me.mRepeatIntervalAlerts, me.mRepeatPercentageTimes);
    }
    
    private function createPercentageTimes(intervalAlerts) {
    	if (intervalAlerts.size() == 0) {
    		return [];
    	}
    	var resultPercentageTimes = new [intervalAlerts.size()];
		for (var i = 0; i < intervalAlerts.size(); i++) {
    		var intervalAlert = intervalAlerts[i];	
    		resultPercentageTimes[i] = intervalAlert.getAlertArcPercentageTimes(me.mSessionTime);
    	}
    	return resultPercentageTimes;
    }
    
    private function drawIntervalAlerts(dc, intervalAlerts, percentageTimes) {
		for (var i = 0; i < intervalAlerts.size(); i++) {
    		for (var pIndex = 0; pIndex < percentageTimes[i].size(); pIndex++) {
    			me.drawIntervalAlert(dc, percentageTimes[i][pIndex], intervalAlerts[i].color);
    		}
    	}
    }    
    
    private function getAlertProgressPercentage(percentageTime) {
    	var progressPercentage = percentageTime * 100;
    	if (progressPercentage > 100) {
    		progressPercentage = 100;
    	}
    	else {
    		if (progressPercentage == 0) {
    			progressPercentage = 0.05;
    		}
		}
		return progressPercentage;	
    }
    
    private function drawIntervalAlert(dc, intervalAlertTime, color) {
    	var progressPercentage = me.getAlertProgressPercentage(intervalAlertTime);
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		
		// Because 235 screen is not totally round we need this hack
		if (progressPercentage == 0 || progressPercentage == 50) {
			dc.setPenWidth(me.mWidth + 38);	
		} else {
        	dc.setPenWidth(me.mWidth);
		}
        var startDegree = percentageToArcDegree(progressPercentage);
        var endDegree = startDegree - 1.2;
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2,  me.mRadius , Gfx.ARC_CLOCKWISE, startDegree, endDegree);
    }
        
    private static function percentageToArcDegree(percentage) {
    	return 90 - percentage * 3.6;
    }
}