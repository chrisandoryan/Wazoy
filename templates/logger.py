import logging
import json
from datetime import datetime
import socket

class VeLogger:
    def __init__(self, log_file):
        self.logger = logging.getLogger('ve_logger')
        self.logger.setLevel(logging.INFO)
        handler = logging.FileHandler(log_file)
        handler.setFormatter(logging.Formatter('%(message)s'))
        self.logger.addHandler(handler)

    def log(self, request_body):
        log_entry = {
            'time': datetime.utcnow().isoformat(),
            'ip': self._get_ip(),
            'requestBody': request_body
        }
        self.logger.info(json.dumps(log_entry))

    def _get_ip(self):
        # Get the IP address of the machine (container) running the script
        ip = socket.gethostbyname(socket.gethostname())
        return ip