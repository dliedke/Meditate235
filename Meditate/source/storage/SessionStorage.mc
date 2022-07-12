using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class SessionStorage {
	function initialize() {	
		mSelectedSessionIndex = 0;
		me.mSessionsCount = 5;
		me.loadSelectedSession();

		return;
		me.mSelectedSessionIndex = App.Storage.getValue("selectedSessionIndex");
		if (me.mSelectedSessionIndex == null) {
			me.mSelectedSessionIndex = 0;
		}
				
		me.mSessionKeysStorage = new SessionKeysStorage();
		
		me.mSessionsCount = App.Storage.getValue("sessionsCount");
		if (me.mSessionsCount == null) {
			me.loadSelectedSession();
		}
	}	
	
	private var mSelectedSessionIndex;
	private var mSessionsCount;
	private var mSessionKeysStorage;
		
	function selectSession(index) {
		me.mSelectedSessionIndex = index;
	}
	
	private function getSelectedSessionKey() {
		return null;
	}
	
	function loadSelectedSession() {
		var session = new SessionModel();
		session.reset(me.mSelectedSessionIndex);
		return session;

	}
	
	function saveSelectedSession(session) {
		return;
	}
	
	function getSessionsCount() {
		return 5;
	}
	
	function getSelectedSessionIndex() {
		return 0;
	}
	
	private function updateSessionStats() {
		return;
	}
			
	function addSession() {
		return null;
		
	}
	
	function deleteSelectedSession() {
		return;

	}	
}

