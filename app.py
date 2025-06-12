from flask import Flask, request, jsonify, render_template
import logging
import os

app = Flask(__name__)

# Setup basic logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s: %(message)s')

# Simulated in-memory data
users = {'admin': 'password123'}
uploaded_files = []

@app.route('/')
def home():
    app.logger.info("Homepage accessed")
    return render_template("index.html")

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    if users.get(username) == password:
        app.logger.info(f"User {username} logged in successfully.")
        return jsonify({'message': 'Login successful'})
    else:
        app.logger.warning(f"Failed login attempt for user {username}")
        return jsonify({'message': 'Invalid credentials'}), 401

@app.route('/upload', methods=['POST'])
def upload():
    if 'file' not in request.files:
        app.logger.error("No file part in the request")
        return jsonify({'error': 'No file part'}), 400
    file = request.files['file']
    if file.filename == '':
        app.logger.warning("No file selected for upload")
        return jsonify({'error': 'No file selected'}), 400
    uploaded_files.append(file.filename)
    app.logger.info(f"File '{file.filename}' uploaded successfully")
    return jsonify({'message': f"File '{file.filename}' uploaded"})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
