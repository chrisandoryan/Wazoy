import argparse
import requests

def main():
    # Define argument parser
    parser = argparse.ArgumentParser(description='Send TAP configuration to Envoy.')
    parser.add_argument('--host', default='localhost:9000', help='host:port of gRPC server')
    args = parser.parse_args()

    # TAP configuration
    config = '''
    {
        "config_id": "test_config_id",
        "tap_config": {
            "match": {
                "any_match": true
            },
            "output_config": {
                "streaming": false,
                "max_buffered_rx_bytes": 5000,
                "max_buffered_tx_bytes": 5000,
                "sinks": [
                    {
                        "format": "JSON_BODY_AS_BYTES",
                        "streaming_admin": {}
                    }
                ]
            }
        }
    }
    '''

    # Send POST request
    response = requests.post(f'http://{args.host}/tap', headers={'Content-Type': 'application/json'}, data=config)
    print(f"Status: [{response.status_code}]")
    print()

    # Read response data
    response_data = response.content
    print(response_data.decode())

if __name__ == '__main__':
    main()
