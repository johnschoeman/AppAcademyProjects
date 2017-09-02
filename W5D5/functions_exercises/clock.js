class Clock {
    constructor() {
        this.myDate = new Date();
        this.printTime();
        setInterval(this._tick.bind(this), 1000);
        // setInterval(this._tick, 1000);
    }

    printTime() {
        this.hours = this.myDate.getHours();
        this.minutes = this.myDate.getMinutes();
        this.seconds = this.myDate.getSeconds();
        console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
    }
    _tick() {
        console.log("this:", this);
        this.myDate.setSeconds(this.myDate.getSeconds() + 1);
        this.printTime();
    }
}

let c = new Clock();
