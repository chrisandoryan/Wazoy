<?php

class VeLogger {
    private $logFile;

    public function __construct($logFile) {
        $this->logFile = $logFile;
    }

    public function log($message) {
        $time = date('Y-m-d\TH:i:s.uP');
        $ip = $_SERVER['REMOTE_ADDR'];
        $logEntry = [
            'time' => $time,
            'ip' => $ip,
            'message' => $message
        ];
        file_put_contents($this->logFile, json_encode($logEntry) . PHP_EOL, FILE_APPEND);
    }
}

