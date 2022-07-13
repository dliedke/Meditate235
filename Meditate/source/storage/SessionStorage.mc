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
	}
	
	function loadSelectedSession() {
		var session = new SessionModel();
		session.reset(me.mSelectedSessionIndex);
		return session;

	}
	
	function getSessionsCount() {
		return 7;
	}
	
	function getSelectedSessionIndex() {
		return 0;
	}
}

