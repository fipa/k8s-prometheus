function logMessage() {
    const randomInterval = Math.floor(Math.random() * 10000) + 1000;
    console.log(`Logging message after ${randomInterval / 1000} seconds`);
    setTimeout(logMessage, randomInterval);
}

logMessage();