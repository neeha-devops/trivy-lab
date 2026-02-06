from http.server import SimpleHTTPRequestHandler
from socketserver import TCPServer

PORT = 80
Handler = SimpleHTTPRequestHandler

with TCPServer(("", PORT), Handler) as httpd:
    print("Server running on port 80")
    httpd.serve_forever()
