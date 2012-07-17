@import <Foundation/Foundation.j>

@implementation LotteryEntry : CPObject
{
    CPDate entryDate;
    int firstNumber;
    int secondNumber;
}

- (id)init
{
    return [self initWithEntryDate:[CPDate date]];
}
- (id)initWithEntryDate:(CPDate)theDate
{
    self = [super init];
    if (self) {
        entryDate = theDate;
        firstNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
        secondNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
    }
    return self;
}

- (void)setEntryDate:(CPDate)date
{
    entryDate = date;
}
- (CPDate)entryDate
{
    return entryDate;
}

- (int)firstNumber
{
    return firstNumber;
}
- (int)secondNumber
{
    return secondNumber;
}

- (CPString)description
{
    return entryDate + " = " + firstNumber + " and " + secondNumber;
}

@end
