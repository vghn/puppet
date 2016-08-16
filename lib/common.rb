require 'rainbow'

def version
  File.read('VERSION').strip
end

def current_git_sha
  `git rev-parse HEAD`.strip
end

def previous_git_sha
  `git rev-parse HEAD~1`.strip
end

def info(message)
  puts Rainbow("==> #{message}").green
end

def warn(message)
  puts Rainbow("==> #{message}").yellow
end

def error(message)
  puts Rainbow("==> #{message}").red
end

def command?(command)
  system("command -v #{command} >/dev/null 2>&1")
end
