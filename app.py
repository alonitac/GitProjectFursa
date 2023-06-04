from flask import Flask, send_file, request

app = Flask(__name__)


@app.route("/")
def home():
    return "Welcome to my web server!"


@app.route("/status")
def home():
    return "OK"


@app.route("/blog")
def blog():
    return "Check out my latest blog post at example.com/blog."


@app.route("/pricing")
def pricing():
    return "Our pricing for web development starts at $55 per hour."


@app.route("/contact")
def contact():
    return "You can contact us at contact@example.com or info@example.com."


@app.route("/chat")
def contact():
    return "You can chat with live agent!"


@app.route("/services")
def services():
    return "We offer the following services: web development, data analysis, SEO."


if __name__ == "__main__":
    app.run(debug=True, port=8081, host="0.0.0.0")


