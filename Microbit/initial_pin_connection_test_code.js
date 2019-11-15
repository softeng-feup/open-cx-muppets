radio.onReceivedNumber(function (receivedNumber) {
    if (receivedNumber == 43) {
        basic.showIcon(IconNames.Happy)
    } else if (receivedNumber == 15) {
        basic.showIcon(IconNames.Sad)
    } else if (receivedNumber == 20) {
        basic.showIcon(IconNames.Angry)
    }
})
input.onButtonPressed(Button.A, function () {
    pins.analogWritePin(AnalogPin.P1, thisID)
})
let thisID = 0
radio.setGroup(1)
basic.showLeds(`
    # . . . #
    # . . . #
    # . . . #
    # # # # #
    # # # # #
    `)
thisID = 43
basic.pause(1000)
basic.forever(function () {
    while (true) {
        basic.showIcon(IconNames.Happy)
        radio.sendNumber(thisID)
        basic.pause(2000)
        if (pins.analogReadPin(AnalogPin.P2) == 43) {
            basic.showIcon(IconNames.No)
            basic.pause(2000)
        }
    }
})
