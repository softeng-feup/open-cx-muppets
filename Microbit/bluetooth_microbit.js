
let receivedID = 0
let receivedIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

basic.showLeds(`
    # . . . #
    # . . . #
    # . . . #
    # # # # #
    # # # # #
    `)
pins.digitalWritePin(DigitalPin.P1, 0)

/* TODO: get id via bluetooth here */
let thisID = 0
let thisIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
let remId = thisID
for (let i = 9; i >= 0; i--) {
    thisIDbits[i] = Math.floor(remId / Math.pow(2, i))
    remId = remId % Math.pow(2, i)
}

basic.pause(1000)
basic.showIcon(IconNames.Happy)

/* id is sent to Bot for broadcasting */
pins.digitalWritePin(DigitalPin.P1, 1)
basic.pause(500)
for (let index = 0; index <= 9; index++) {
    pins.digitalWritePin(DigitalPin.P1, thisIDbits[index])
    basic.pause(500)
}
pins.digitalWritePin(DigitalPin.P1, 0)


/* polling for ids from Bot */
basic.forever(function () {
    while (true) {
        basic.pause(100)
        if (pins.digitalReadPin(DigitalPin.P2) == 1) {
            receivedID = 0
            receivedIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            basic.pause(500)
            for (let index = 0; index <= 9; index++) {
                basic.pause(50)
                receivedIDbits[index] = pins.digitalReadPin(DigitalPin.P2)
                basic.pause(450)
            }
            for (let index = 0; index <= 9; index++) {
                if (receivedIDbits[index] > 0)
                    receivedID = receivedID + Math.pow(2, index)
            }
            
            basic.showNumber(receivedID)

            /* TODO: Stack received id to send later via Bluetooth or send instantly */
        
            basic.pause(2000)
            basic.showIcon(IconNames.Happy)
        }
    }
})
