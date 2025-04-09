from flask import Flask, request, jsonify
import subprocess

# Create a new Flask application
app = Flask(__name__)

# Define a POST endpoint for triggering a SIP call
@app.route('/call', methods=['POST'])
def call():
    data = request.get_json()
    number = data.get('number')  # Extract the number from the JSON request body

    if not number:
        # If number is missing, return an error response
        return jsonify({'error': 'number is required'}), 400

    # Send the "dial" command to baresip via the control FIFO
    cmd = f'echo "dial {number}" >> /tmp/baresip_control'
    subprocess.call(cmd, shell=True)

    # Return a success response
    return jsonify({'status': 'calling', 'number': number})

# Run the Flask API on port 8085 and allow access from all interfaces
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8085)
