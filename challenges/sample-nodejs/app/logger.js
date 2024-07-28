const winston = require('winston');
const path = require('path');

class VeLogger {
    constructor(logFilePath) {
        this.logger = winston.createLogger({
            level: 'info',
            format: winston.format.combine(
                winston.format.timestamp(),
                winston.format.json()
            ),
            transports: [
                new winston.transports.File({ filename: logFilePath })
            ]
        });
    }

    log(requestBody, ip) {
        const logEntry = {
            time: new Date().toISOString(),
            ip: ip || 'unknown',
            requestBody: requestBody
        };
        this.logger.info(logEntry);
    }
    
}

module.exports = VeLogger;
