using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;
using HrvAlgorithms.HrvTracking;

class SummaryViewDelegate extends ScreenPicker.ScreenPickerDelegate {
	private var mSummaryModel;
	private var mDiscardDanglingActivity;

	function initialize(summaryModel, discardDanglingActivity) {		
		me.mPagesCount = SummaryViewDelegate.getPagesCount(summaryModel.hrvTracking);
		setPageIndexes(summaryModel.hrvTracking);
		
        ScreenPickerDelegate.initialize(0, me.mPagesCount);
        me.mSummaryModel = summaryModel;
        me.mDiscardDanglingActivity = discardDanglingActivity;
        me.mSummaryLinesYOffset = App.getApp().getProperty("summaryLinesYOffset");
	}
		
	private var mSummaryLinesYOffset;
			
	private static function getPagesCount(hrvTracking) {		
		var pagesCount = 5;
		if (hrvTracking == HrvTracking.Off) {
			pagesCount -= 4;
		}
		else if (hrvTracking == HrvTracking.On) {
			pagesCount -= 2;
		}
		return pagesCount;
	}
	
	private function setPageIndexes(hrvTracking) {		
		if (hrvTracking == HrvTracking.Off) {
			me.mStressPageIndex = InvalidPageIndex;
			me.mHrvRmssdPageIndex = InvalidPageIndex;
			me.mHrvSdrrPageIndex = InvalidPageIndex;
			me.mHrvPnnxPageIndex = InvalidPageIndex;
		}
		else {
			me.mStressPageIndex = 1;
			me.mHrvRmssdPageIndex = 2;
				
			if (hrvTracking == HrvTracking.OnDetailed) {	
				me.mHrvPnnxPageIndex = me.mHrvRmssdPageIndex + 1;	
				me.mHrvSdrrPageIndex = me.mHrvRmssdPageIndex + 2;
			}
			else {
				me.mHrvPnnxPageIndex = InvalidPageIndex;
				me.mHrvSdrrPageIndex = InvalidPageIndex;
			}
		}
	}
	
	private var mPagesCount;
	
	private var mHrvRmssdPageIndex;
	private var mHrvSdrrPageIndex;
	private var mHrvPnnxPageIndex;
	private var mStressPageIndex;
	
	private const InvalidPageIndex = -1;

	function onBack() {
		if (me.mDiscardDanglingActivity != null) {
			me.mDiscardDanglingActivity.invoke();
		}
		
		return false;
	}
	
	function createScreenPickerView() {
		var details;
		details = me.createDetailsPageHr();
		return new ScreenPicker.ScreenPickerDetailsSinglePageView(details);
	}	
				
	private function formatHr(hr) {
		return hr + " bpm";
	}
	
	private function createDetailsPageHr() {
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary HR";
        details.titleColor = Gfx.COLOR_BLACK;

        details.detailLines[1].value.color = Gfx.COLOR_BLACK;
        details.detailLines[1].value.text = TimeFormatter.format(me.mSummaryModel.elapsedTime);
     
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;
        details.detailLines[2].value.text = "Min: " + me.formatHr(me.mSummaryModel.minHr);
        
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;  
        details.detailLines[3].value.text = "Avg: " + me.formatHr(me.mSummaryModel.avgHr);
        
        details.detailLines[4].value.color = Gfx.COLOR_BLACK; 
        details.detailLines[4].value.text = "Max: " +me.formatHr(me.mSummaryModel.maxHr);
		
        var hrIconsXPos = App.getApp().getProperty("summaryHrIconsXPos");
        var hrValueXPos = App.getApp().getProperty("summaryHrValueXPos");                
        details.setAllIconsXPos(hrIconsXPos);
        details.setAllValuesXPos(hrValueXPos);   
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}
}