require 'socket'
require 'base64'

server = TCPServer.new 80

VERBOSE = false

STDERR_REDIRECT = VERBOSE ? "" : "2>/dev/null"
URL_PREFIX=ENV["URL_PREFIX"]

VSCODE_ICON_SVG = File.read("./vscode.svg")
ROOT_PATH = "/search"

def print_urls(session)
    git_repository_paths = %x|find #{ROOT_PATH} -type d -name .git -execdir pwd \\;|.split("\n")

    for path in git_repository_paths
        real_path = path.sub(/#{ROOT_PATH}/,'')
        session.print "<a href=\"#{URL_PREFIX}#{real_path}\" class=\"vscode\" >#{VSCODE_ICON_SVG} #{real_path}</a>"
    end
end

while session = server.accept
    request = session.gets
    puts request 

    if not request
        next
    end

    method, path = request.split(" ")

    if method == "GET" && path == "/favicon.ico"
        img = File.open("./bg.jpg", "rb").read
        session.print "HTTP/1.1 200\n"
        session.print "Content-Type: image/svg+xml\n"
        session.print "\n"
        session.print VSCODE_ICON_SVG
        session.close
        next

    elsif method == "GET" && path == "/bg.jpg"
        img = File.open("./bg.jpg", "rb").read
        session.print "HTTP/1.1 200\n"
        session.print "Content-Type: image/jpeg\n"
        session.print "\n"
        session.print img
        session.close
        next

    elsif method == "GET" && path == "/app.js"
        file = File.open("./app.js", "rb").read
        session.print "HTTP/1.1 200\n"
        session.print "Content-Type: application/javascript\n"
        session.print "\n"
        session.print file
        session.close
        next
    
    elsif method == "GET" && path == "/app.css"
        file = File.open("./app.css", "rb").read
        session.print "HTTP/1.1 200\n"
        session.print "Content-Type: text/css\n"
        session.print "\n"
        session.print file
        session.close
        next
    
    elsif method == "GET" && path == "/"
        session.print "HTTP/1.1 200\n"
        session.print "Content-Type: text/html\n"
        session.print "\n"

        session.print "<html><head>
        <script src=\"./app.js\" ></script>
        <link rel=\"stylesheet\" href=\"./app.css\" />
        </head><body>"

        session.print '<div class="content">'
        session.print '<div class="search">
            <input type="text" id="search" placeholder="Filter..." autofocus />
        </div>'

        print_urls(session)

        session.print '</div>'
        session.print "</body></html>"

        session.close
        next
    end

    session.print "HTTP/1.1 404\n"
    session.close
end
