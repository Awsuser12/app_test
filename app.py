from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, Jenkins and Docker with Python 3.11!"

if __name__ == '__main__':
    # Ensure the app is available externally by binding to 0.0.0.0
    app.run(host='0.0.0.0', port=5000)
