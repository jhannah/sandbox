document.getElementById("capture").addEventListener("click", async () => {
    let [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
    chrome.tabs.captureVisibleTab(null, {}, (image) => {
        let note = document.getElementById("note").value;
        let output = document.getElementById("output");
        let html = `
            <div class="step">
              <p><strong>Step:</strong> ${note || "(no note)"}</p>
              <img src="${image}" style="max-width:100%">
            </div>`;
    output.innerHTML = html + output.innerHTML;
    });
});
  