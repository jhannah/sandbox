chrome.runtime.onInstalled.addListener(() => {
    console.log("Screenshot Helper extension installed.");
});
  
// Optional: Listen for messages from popup or content scripts
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.type === "hello") {
        console.log("Received message from popup:", request);
        sendResponse({ reply: "Hi from background.js!" });
    }
});
  