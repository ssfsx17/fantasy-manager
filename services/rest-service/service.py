from flask import Flask, escape, request
from flask_json import FlaskJSON, JsonError, json_response, as_json

print("starting service...")

app = Flask(__name__)
json = FlaskJSON(app)

@app.route('/')
def index():
  name = request.args.get("name", "World")
  return json_response(message=f'Hello, {escape(name)}')

@app.route('/healthcheck')
def healthcheck():
  return json_response(health="running")

@app.route('/prometheus')
def prometheus():
  return "# metrics not yet implemented"
