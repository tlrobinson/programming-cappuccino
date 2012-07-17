@import <Foundation/Foundation.j>
@import "LotteryEntry.j"

CPLogRegister(CPLogPrint);

var now = [[CPDate alloc] init];
// NYI: CPCalender

var array = [];
var i;

for (i = 0; i < 10; i++) {

    // Create a date/time object that is 'i' weeks from now
    var iWeeksFromNow = [CPDate dateWithTimeIntervalSinceNow:(60 * 60 * 24 * 7)]; // close enough

    // Create a new instance of LotteryEntry
    var newEntry = [[LotteryEntry alloc] init];
    var newEntry = [[LotteryEntry alloc] initWithEntryDate:iWeeksFromNow];

    // Add the LotteryEntry object to the array
    [array addObject:newEntry];
}

for (i = 0; i < 10; i++) {
    // NYI: fast enumeration
    var entryToPrint = array[i];
    // Display its contents
    CPLog("%@", entryToPrint);
}
