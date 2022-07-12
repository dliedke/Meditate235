using Toybox.WatchUi as Ui;

class SessionSettingsMenuDelegate extends Ui.MenuInputDelegate {
    private var mSessionStorage;
    private var mSessionPickerDelegate;
    
    function initialize(sessionStorage, sessionPickerDelegate) {
        MenuInputDelegate.initialize();
        me.mSessionStorage = sessionStorage;
        me.mSessionPickerDelegate = sessionPickerDelegate;
    }
		
    function onMenuItem(item) {
        
    }
    
    private function createAddEditSessionMenu(selectedSessionIndex) {
    	var addEditSessionMenu = new Rez.Menus.addEditSessionMenu();
    	var sessionNumber = selectedSessionIndex + 1;
    	addEditSessionMenu.setTitle(Ui.loadResource(Rez.Strings.addEditSessionMenu_title) + " " + sessionNumber);
    	return addEditSessionMenu;
    }
    
    function onConfirmedDeleteSession() {
    	me.mSessionStorage.deleteSelectedSession();        	 	
    	me.mSessionPickerDelegate.setPagesCount(me.mSessionStorage.getSessionsCount());
    	me.mSessionPickerDelegate.select(me.mSessionStorage.getSelectedSessionIndex());      
    }
        
    function onChangeSession(changedSessionModel) {
    	var existingSession = me.mSessionStorage.loadSelectedSession();
		existingSession.copyNonNullFieldsFromSession(changedSessionModel);
		me.mSessionStorage.saveSelectedSession(existingSession);
		me.mSessionPickerDelegate.updateSelectedSessionDetails(existingSession);
    }
}