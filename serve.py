import http.server
import socketserver
import os

PORT = 5176
DIRECTORY = "build/web"

class SPARequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        # Disable caching so Flutter Web always fetches the latest main.dart.js
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()

    def do_GET(self):
        # If file doesn't exist on disk, serve index.html for Flutter Web SPA routes
        path = self.translate_path(self.path)
        if not os.path.exists(path) and not self.path.startswith('/assets'):
            self.path = '/index.html'
        return super().do_GET()

if __name__ == "__main__":
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), SPARequestHandler) as httpd:
        print(f"Serving Flutter Web SPA on port {PORT}...")
        httpd.serve_forever()
