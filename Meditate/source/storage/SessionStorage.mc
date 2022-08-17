using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class SessionStorage {
	function initialize() {	
		mSelectedSessionIndex = 0;
		me.mSessionsCount = 7;
		me.loadSelectedSession();
	}	
	
	private var mSelectedSessionIndex;
	private var mSessionsCount;
		
	function selectSession(index) {
		me.mSelectedSessionIndex = index;
		App.getApp().setProperty("meditateApp_selectedSession", index);
	}
	
	function loadSelectedSession() {

		var sessionIndex =	App.getApp().getProperty("meditateApp_selectedSession");

		if (sessionIndex == null) {
			me.mSelectedSessionIndex = 0;
		} else {
			me.mSelectedSessionIndex = sessionIndex;
		}

		var session = new SessionModel();
		session.reset(me.mSelectedSessionIndex);
		return session;
	}
	
	function getSessionsCount() {
		return 7;
	}
	
	function getSelectedSessionIndex() {
		return me.mSelectedSessionIndex;
	}
}

