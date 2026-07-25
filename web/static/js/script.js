    window.onload = function () {

    // ================= Inventory =================

    if(document.getElementById("docker-status")){

        const text = document.getElementById("bash-output").innerText;
        

        function find(pattern){
            const match = text.match(pattern);
            return match ? match[1] : "-";
        }

        document.getElementById("docker-status").innerHTML = `
            <p><span>Docker Installed</span><strong style="color:#00d26a;">✅ Yes</strong></p>
            <p><span>Docker Engine</span><strong style="color:#00d26a;">🟢 Running</strong></p>
        `;

        // document.getElementById("docker-version").innerHTML = `
        //     <h2 style="color:#ff8c00;font-size:36px;">
        //     find{/Docker version (.*)/}
        //     </h2>
        // `;
        const version = find(/Docker version (.*)/).replace(/\x1b\[[0-9;]*m/g, "");

        document.getElementById("docker-version").innerHTML = `
        <h2>${version}</h2>
        `;

        document.getElementById("containers").innerHTML = `
            <p><span>🟢 Running Containers</span><strong>${find(/Running :\s+(\d+)/)}</strong></p>
            <p><span>🔴 Stopped Containers</span><strong>${find(/Stopped :\s+(\d+)/)}</strong></p>
            <p><span>📦 Total Containers</span><strong>${find(/Total\s+:?\s+(\d+)/)}</strong></p>
        `;

        document.getElementById("images").innerHTML = `
            <p><span>🖼 Total Images</span><strong>${find(/Total Images :\s+(\d+)/)}</strong></p>
            <p><span>🗑 Dangling Images</span><strong>${find(/Dangling\s+:?\s+(\d+)/)}</strong></p>
        `;

        document.getElementById("volumes").innerHTML = `
            <p><span>💾 Total Volumes</span><strong>${find(/Total Volumes :\s+(\d+)/)}</strong></p>
        `;

        const networkBlock = text.match(/Networks([\s\S]*?)Volumes/);

        let html = "";

        if(networkBlock){

            networkBlock[1]
            .split("\n")
            .forEach(line=>{

                line = line.trim();

                if(line.startsWith("•")){
                    html += `<p><span>🌐 ${line.replace("•","")}</span></p>`;
                }

            });

        }

        document.getElementById("networks").innerHTML = html;
    }

    // ================= Dashboard =================

    if(document.getElementById("container-count")){

        fetch("/api/dashboard")

        .then(res => res.json())

        .then(data => {

            document.getElementById("container-count").innerHTML = data.total;
            document.getElementById("image-count").innerHTML = data.images;
            document.getElementById("network-count").innerHTML = data.networks;

        })

        .catch(err => console.log(err));

    }

}

// ====================== Monitor ======================

if (document.getElementById("monitor-output")) {

    const text = document.getElementById("monitor-output").innerText;

    function get(pattern) {
        const match = text.match(pattern);
        return match ? match[1] : "0";
    }

    // ================= Summary =================

    const running = Number(get(/Running Containers\s*:\s*(\d+)/));
    const healthy = Number(get(/Healthy\s*:\s*(\d+)/));
    const warning = Number(get(/Warnings\s*:\s*(\d+)/));
    const critical = Number(get(/Critical\s*:\s*(\d+)/));

    document.getElementById("center-running").innerHTML = running;

    document.getElementById("running-count").innerHTML = running;
    document.getElementById("healthy-count").innerHTML = healthy;
    document.getElementById("warning-count").innerHTML = warning;
    document.getElementById("critical-count").innerHTML = critical;

    // ================= Dynamic Donut =================

    const total = running + healthy + warning + critical || 1;

    const runDeg = (running / total) * 360;
    const healthyDeg = (healthy / total) * 360;
    const warnDeg = (warning / total) * 360;

    document.getElementById("donut-chart").style.background = `
    conic-gradient(
        #22c55e 0deg ${runDeg}deg,
        #3b82f6 ${runDeg}deg ${runDeg + healthyDeg}deg,
        #ffd43b ${runDeg + healthyDeg}deg ${runDeg + healthyDeg + warnDeg}deg,
        #ff4d4d ${runDeg + healthyDeg + warnDeg}deg 360deg
    )
    `;

    // ================= Resource Usage =================

    let resourceTable = `
    <table class="monitor-table">

        <thead>
            <tr>
                <th>Container</th>
                <th>CPU</th>
                <th>Memory</th>
                <th>Network</th>
                <th>Block I/O</th>
            </tr>
        </thead>

        <tbody>
    `;

    const lines = text.split("\n");

    let start = false;

    lines.forEach(line => {

        if (line.includes("BLOCK I/O")) {
            start = true;
            return;
        }

        if (!start) return;

        if (
            line.includes("Alerts") ||
            line.trim() === ""
        ) {
            start = false;
            return;
        }

        const p = line.trim().split(/\s+/);

        if (p.length >= 8) {

            resourceTable += `
            <tr>

                <td>${p[0]}</td>

                <td>${p[1]}</td>

                <td>${p[2]} ${p[3]} ${p[4]}</td>

                <td>${p[5]} ${p[6]}</td>

                <td>${p.slice(7).join(" ")}</td>

            </tr>
            `;
        }

    });

    resourceTable += "</tbody></table>";

    document.getElementById("resource-table").innerHTML = resourceTable;

    // ================= Health Table =================

    let healthTable = `
    <table class="monitor-table">

        <thead>

            <tr>
                <th>Container</th>
                <th>Status</th>
                <th>Health</th>
            </tr>

        </thead>

        <tbody>
    `;

    let healthStart = false;

    lines.forEach(line => {

        if (line.includes("Container") && line.includes("Status")) {
            healthStart = true;
            return;
        }

        if (!healthStart) return;

        if (
            line.includes("Summary") ||
            line.includes("====")
        ) {
            healthStart = false;
            return;
        }

        if (line.includes("🟢")) {

            const p = line.trim().split(/\s+/);

            healthTable += `
            <tr>

                <td>${p[0]}</td>

                <td><span class="badge green">${p[2]}</span></td>

                <td>${p[3]}</td>

            </tr>
            `;

        }

    });

    healthTable += "</tbody></table>";

    document.getElementById("health-table").innerHTML = healthTable;

}

// ====================== Analyzer ======================

if(document.getElementById("analyzer-output")){

    const text=document.getElementById("analyzer-output").innerText;

    function get(pattern){
        const m=text.match(pattern);
        return m ? m[1] : "0";
    }

    // ================= Values =================

    const running=Number(get(/Running Containers\s*:\s*(\d+)/));

    const stopped=Number(get(/Stopped Containers\s*:\s*(\d+)/));

    const totalImages=Number(get(/Total Images\s*:\s*(\d+)/));

    const unusedImages=Number(get(/Unused Images\s*:\s*(\d+)/));

    const totalVolumes=Number(get(/Total Volumes\s*:\s*(\d+)/));

    const unusedVolumes=Number(get(/Unused Volumes\s*:\s*(\d+)/));

    const totalNetworks=Number(get(/Total Networks\s*:\s*(\d+)/));

    const customNetworks=Number(get(/Custom Networks\s*:\s*(\d+)/));

    // ================= Health Score =================

    let score=100;

    score-=stopped*5;

    score-=unusedImages*3;

    score-=unusedVolumes*3;

    if(score<0) score=0;

    document.getElementById("health-score").innerHTML=score;

    document.getElementById("health-progress").style.width=score+"%";

    document.getElementById("health-percent").innerHTML=score+"%";

    // ================= Risk =================

    let risk="🟢 LOW";
    let color="#22c55e";

    if(score<80){

        risk="🟡 MEDIUM";
        color="#ff9800";

    }

    if(score<50){

        risk="🔴 HIGH";
        color="#ff4d4d";

    }

    document.getElementById("risk-level").innerHTML=risk;
    document.getElementById("health-score").style.color=color;

    // ================= Resource Analysis =================

    document.getElementById("resource-analysis").innerHTML=`

<div class="analysis-row">
<span>📦 Running Containers</span>
<strong>${running}</strong>
</div>

<div class="analysis-row">
<span>🛑 Stopped Containers</span>
<strong>${stopped}</strong>
</div>

<div class="analysis-row">
<span>🖼 Total Images</span>
<strong>${totalImages}</strong>
</div>

<div class="analysis-row">
<span>🗑 Unused Images</span>
<strong>${unusedImages}</strong>
</div>

<div class="analysis-row">
<span>💾 Total Volumes</span>
<strong>${totalVolumes}</strong>
</div>

<div class="analysis-row">
<span>🧹 Unused Volumes</span>
<strong>${unusedVolumes}</strong>
</div>

<div class="analysis-row">
<span>🌐 Total Networks</span>
<strong>${totalNetworks}</strong>
</div>

<div class="analysis-row">
<span>🔗 Custom Networks</span>
<strong>${customNetworks}</strong>
</div>

`;

    // ================= Recommendations =================

    let html="";

    if(unusedImages>0){

        html+=`

<div class="recommend-card">

<div class="recommend-icon">🗑</div>

<div>

<div class="recommend-title">

Remove Unused Images

</div>

<div class="recommend-desc">

${unusedImages} unused Docker images found.

</div>

</div>

</div>

`;

    }

    if(unusedVolumes>0){

        html+=`

<div class="recommend-card">

<div class="recommend-icon">💾</div>

<div>

<div class="recommend-title">

Clean Unused Volumes

</div>

<div class="recommend-desc">

${unusedVolumes} unused Docker volumes found.

</div>

</div>

</div>

`;

    }

    if(stopped>0){

        html+=`

<div class="recommend-card">

<div class="recommend-icon">📦</div>

<div>

<div class="recommend-title">

Remove Stopped Containers

</div>

<div class="recommend-desc">

${stopped} stopped containers detected.

</div>

</div>

</div>

`;

    }

    if(customNetworks>0){

        html+=`

<div class="recommend-card">

<div class="recommend-icon">🌐</div>

<div>

<div class="recommend-title">

Review Custom Networks

</div>

<div class="recommend-desc">

${customNetworks} custom Docker networks available.

</div>

</div>

</div>

`;

    }

    if(html===""){

        html=`

<div class="recommend-card">

<div class="recommend-icon">✅</div>

<div>

<div class="recommend-title">

Everything Looks Good

</div>

<div class="recommend-desc">

No optimization required.

</div>

</div>

</div>

`;

    }

    document.getElementById("recommendations").innerHTML=html;

}

// ====================== Recovery ======================

if(document.getElementById("recovery-output")){

const text=document.getElementById("recovery-output").innerText;

function get(pattern){

const m=text.match(pattern);

return m ? m[1] : "0";

}

const running=Number(get(/Running Containers\s*:\s*(\d+)/));

const stopped=Number(get(/Stopped Containers\s*:\s*(\d+)/));

document.getElementById("running-containers").innerHTML=running;

document.getElementById("stopped-containers").innerHTML=stopped;

// ---------------- Status ----------------

let badge=stopped>0
?'<span class="badge-warning">Needs Recovery</span>'
:'<span class="badge-success">Healthy</span>';

document.getElementById("recovery-status").innerHTML=`

<div class="status-row">

<span>Docker Engine</span>

<strong>Running</strong>

</div>

<div class="status-row">

<span>Running Containers</span>

<strong>${running}</strong>

</div>

<div class="status-row">

<span>Stopped Containers</span>

<strong>${stopped}</strong>

</div>

<div class="status-row">

<span>Recovery Status</span>

${badge}

</div>

`;

// ---------------- Actions ----------------

let html="";

if(stopped>0){

html+=`

<div class="action-card">

<div class="action-icon">🔄</div>

<div>

<div class="action-title">

Restart Stopped Containers

</div>

<div class="action-desc">

${stopped} stopped containers can be restarted.

</div>

</div>

</div>

`;

html+=`

<div class="action-card">

<div class="action-icon">🧹</div>

<div>

<div class="action-title">

Remove Stopped Containers

</div>

<div class="action-desc">

Clean inactive containers to free resources.

</div>

</div>

</div>

`;

}else{

html+=`

<div class="action-card">

<div class="action-icon">✅</div>

<div>

<div class="action-title">

No Recovery Required

</div>

<div class="action-desc">

All containers are running properly.

</div>

</div>

</div>

`;

}

html+=`

<div class="action-card">

<div class="action-icon">⚙</div>

<div>

<div class="action-title">

Docker System Cleanup

</div>

<div class="action-desc">

Run Docker cleanup periodically.

</div>

</div>

</div>

`;

document.getElementById("recovery-actions").innerHTML=html;

// ---------------- Commands ----------------

let commands = "";

// ---------------- Container Commands ----------------

if(stopped > 0){

commands += `
<div class="command-box">
docker start &lt;container_name&gt;
</div>

<div class="command-box">
docker restart &lt;container_name&gt;
</div>

<div class="command-box">
docker rm $(docker ps -aq -f status=exited)
</div>
`;

}

// ---------------- Image Commands ----------------

const unusedImages = Number(get(/Unused Images\s*:\s*(\d+)/));

if(unusedImages > 0){

commands += `
<div class="command-box">
docker image prune -f
</div>

<div class="command-box">
docker image prune -a
</div>
`;

}

// ---------------- Volume Commands ----------------

const unusedVolumes = Number(get(/Unused Volumes\s*:\s*(\d+)/));

if(unusedVolumes > 0){

commands += `
<div class="command-box">
docker volume prune -f
</div>
`;

}

// ---------------- General Cleanup ----------------

if(stopped>0 || unusedImages>0 || unusedVolumes>0){

commands += `
<div class="command-box">
docker system prune -f
</div>
`;

}

// ---------------- Healthy ----------------

if(commands===""){

commands = `
<div class="command-box">
✅ No recovery commands required.
</div>
`;

}

document.getElementById("recovery-commands").innerHTML = commands;

}

// ====================== Security ======================

if (document.getElementById("security-output")) {

    const text = document.getElementById("security-output").innerText;

    function get(pattern) {
        const match = text.match(pattern);
        return match ? match[1] : "0";
    }

    // ---------------- Values ----------------

    const running = Number(get(/Running Containers\s*:\s*(\d+)/));
    const root = Number(get(/Root Containers\s*:\s*(\d+)/));
    const privileged = Number(get(/Privileged Count\s*:\s*(\d+)/));
    const ports = Number(get(/Exposed Ports Count\s*:\s*(\d+)/));

    // ---------------- Security Score ----------------

    let score = 100;

    score -= root * 10;
    score -= privileged * 20;
    score -= ports * 5;

    if (score < 0) score = 0;

    document.getElementById("security-score").innerHTML = score;

    // ---------------- Risk Level ----------------

    let risk = "LOW";

    if (score < 80) risk = "MEDIUM";

    if (score < 50) risk = "HIGH";

    document.getElementById("risk-level").innerHTML = risk;

    // ---------------- Progress ----------------

    document.getElementById("security-progress").style.width = score + "%";
    document.getElementById("security-percent").innerHTML = score + "%";

    // ---------------- Security Table ----------------

    document.getElementById("security-checks").innerHTML = `

    <div class="analysis-row">
        <span>🐳 Running Containers</span>
        <strong>${running}</strong>
    </div>

    <div class="analysis-row">
        <span>👤 Root Containers</span>
        <strong>${root}</strong>
    </div>

    <div class="analysis-row">
        <span>⚙ Privileged Containers</span>
        <strong>${privileged}</strong>
    </div>

    <div class="analysis-row">
        <span>🌐 Exposed Ports</span>
        <strong>${ports}</strong>
    </div>

    `;

    // ---------------- Recommendations ----------------

    let rec = "";

    if (root > 0) {

        rec += `
        <div class="recommend-card">
            <div class="recommend-icon">⚠</div>
            <div>
                <div class="recommend-title">Root User Detected</div>
                <div class="recommend-desc">
                    Avoid running containers as root.
                </div>
            </div>
        </div>`;
    }

    if (privileged > 0) {

        rec += `
        <div class="recommend-card">
            <div class="recommend-icon">🚨</div>
            <div>
                <div class="recommend-title">Privileged Containers</div>
                <div class="recommend-desc">
                    Disable privileged mode whenever possible.
                </div>
            </div>
        </div>`;
    }

    if (ports > 0) {

        rec += `
        <div class="recommend-card">
            <div class="recommend-icon">🌐</div>
            <div>
                <div class="recommend-title">Exposed Ports</div>
                <div class="recommend-desc">
                    Restrict unnecessary published ports.
                </div>
            </div>
        </div>`;
    }

    if (root == 0 && privileged == 0) {

        rec += `
        <div class="recommend-card">
            <div class="recommend-icon">✅</div>
            <div>
                <div class="recommend-title">Good Security</div>
                <div class="recommend-desc">
                    No privileged containers detected.
                </div>
            </div>
        </div>`;
    }

    document.getElementById("security-recommendations").innerHTML = rec;

    // ---------------- Suggested Commands ----------------

    document.getElementById("security-commands").innerHTML = `

    <div class="command-box">docker inspect &lt;container&gt;</div>

    <div class="command-box">docker exec -it &lt;container&gt; whoami</div>

    <div class="command-box">docker update --restart unless-stopped &lt;container&gt;</div>

    <div class="command-box">docker run --user 1000:1000 IMAGE</div>

    <div class="command-box">docker scan IMAGE</div>

    `;
}