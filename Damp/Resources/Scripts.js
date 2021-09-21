function setStatus() {
    document.getElementById('status').innerHTML = 'herp derp'
    console.log('foop')
    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
        window.webkit.messageHandlers.toggleMessageHandler.postMessage({
            "message": 'honk splat'
        });
    }

}
