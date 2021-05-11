#!/usr/bin/env python3

import html
import requests
import sys

filename = sys.argv[1]

with open(filename, 'r') as file:
    content = ''.join(file.readlines())

document = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
    <pre id="text-content">
{{ text-content }}
    </pre>
</body>
</html>
'''

ready_html = document.replace('{{ text-content }}', html.escape(content))

with open(filename + '.html', 'w') as file:
    file.writelines(ready_html)
