// https://mackuba.eu/notes/wwdc20/meet-safari-web-extensions/

browser.runtime.onMessage.addListener(message => {
    if( typeof message.damp_whitelist !== 'undefined' ) {
        const realUrl = document.querySelector('link[rel=canonical]').getAttribute('href')
        if(
            realUrl
            && document.location.hostname === 'www.google.com'
            && document.location.pathname.substr(0, 7) === '/amp/s/'
            && document.href !== realUrl
        ) {
            const sourceDomain = document.location.pathname.split('/')[3]
            if( message.damp_whitelist.indexOf(sourceDomain) < 0 ) {
                console.log(`D’AMP web extension: forwarding from AMP hosted page to source: ${realUrl}`)
                document.location = realUrl
            }
        }
    }
})

browser.runtime.sendMessage('need_damp_whitelist')
