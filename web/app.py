from flask import Flask, render_template, jsonify, request
import subprocess

app = Flask(__name__)


def cmd(command):
    return subprocess.check_output(command, shell=True, text=True).strip()


def run_script(script):
    result = subprocess.run(
        ["bash", script],
        capture_output=True,
        text=True
    )
    return result.stdout + result.stderr


@app.route("/")
def home():
    return render_template("index.html")


# ---------------- Dashboard API ---------------- #

@app.route("/api/dashboard")
def dashboard():

    running = cmd("docker ps -q | wc -l")
    stopped = cmd("docker ps -aq -f status=exited | wc -l")
    total = cmd("docker ps -aq | wc -l")

    images = cmd("docker images -q | sort -u | wc -l")
    networks = cmd("docker network ls -q | wc -l")
    volumes = cmd("docker volume ls -q | wc -l")

    return jsonify({
        "running": running,
        "stopped": stopped,
        "total": total,
        "images": images,
        "networks": networks,
        "volumes": volumes
    })


# ---------------- Pages ---------------- #

@app.route("/inventory")
def inventory():
    output = run_script("../inventory/inventory.sh")
    return render_template("inventory.html", output=output)


@app.route("/monitor")
def monitor():
    output = run_script("../monitor/monitor.sh")
    return render_template("monitor.html", output=output)


@app.route("/analyzer")
def analyzer():
    output = run_script("../analyzer/analyzer.sh")
    return render_template("analyzer.html", output=output)


@app.route("/recovery")
def recovery():
    output = run_script("../recovery/recovery.sh")
    return render_template("recovery.html", output=output)


@app.route("/security")
def security():
    output = run_script("../security/security.sh")
    return render_template("security.html", output=output)


if __name__ == "__main__":
    app.run(debug=True)