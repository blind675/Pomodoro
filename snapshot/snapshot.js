#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

// Setting to initial orientation (not necessary unless taking screenshots in multiple orientations)

//target.delay(2)

captureLocalizedScreenshot("1-SplashScreen")


target.frontMostApp().mainWindow().scrollViews()[0].scrollViews()[0].buttons()["Start"].tap();
target.delay(2)
captureLocalizedScreenshot("1-MainScreen")

target.frontMostApp().mainWindow().scrollViews()[0].scrollViews()[0].images()[0].scrollToVisible();
target.frontMostApp().mainWindow().scrollViews()[0].images()["leftPartImage"].scrollToVisible();
target.delay(2)
captureLocalizedScreenshot("1-StatsScreen")

target.frontMostApp().mainWindow().scrollViews()[0].scrollViews()[0].images()[0].scrollToVisible();
target.delay(2)
captureLocalizedScreenshot("1-AboutScreen")