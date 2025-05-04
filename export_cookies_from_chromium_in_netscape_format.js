(function () {
    const cookies = document.cookie.split(';').map(cookie => {
      const [name, value] = cookie.trim().split('=');
      return { name, value };
    });
    const domain = window.location.hostname;
    const netscapeCookies = [
      '# Netscape HTTP Cookie File',
      '# This is a generated file! Do not edit.',
      ''
    ];
    cookies.forEach(cookie => {
      // Simplified assumptions: adjust as needed
      const line = [
        domain,                // domain
        'TRUE',                // flag (host-only)
        '/',                   // path
        'FALSE',               // secure (modify if needed)
        '0',                   // expiration (0 for session cookies)
        cookie.name,           // name
        cookie.value           // value
      ].join('\t');
      netscapeCookies.push(line);
    });
    console.log(netscapeCookies.join('\n'));
    return netscapeCookies.join('\n');
  })();