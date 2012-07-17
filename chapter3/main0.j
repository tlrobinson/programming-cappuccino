@import <Foundation/Foundation.j>

CPLogRegister(CPLogPrint);

var array = [];
var i;

for (i = 0; i < 10; i++) {
    var newNumber = i * 3;
    [array addObject:newNumber]; // could also use JavaScript method "array.push(newNumber)"
}

for (i = 0; i < 10; i++) {
    var numberToPrint = [array objectAtIndex:i];
    CPLog("The number at index %d is %s", i, numberToPrint);
}
