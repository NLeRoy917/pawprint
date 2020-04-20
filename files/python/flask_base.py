# import flask
from flask import Flask
from flask import jsonify
from flask import request
from flask import render_template
from flask_cors import CORS
app = Flask(__name__)
CORS(app)

DB_NAME = 'codon_usage_data.db'

# Testing route/main route
@app.route('/')
def api_base():

	return '<div><h1>Welcome to my backend</h1></div>'
