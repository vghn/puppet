require 'rainbow'

def git_commit
  `git rev-parse --short HEAD`.strip
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

def version
  @version ||= begin
    v = `git describe --always --tags`
    {}.tap do |h|
      h[:major], h[:minor], h[:patch], h[:rev], h[:rev_hash] = v[1..-1].split(/[.-]/)
    end
  end
end

def increment(level)
  v = version.dup
  v[level] = v[level].to_i + 1

  to_zero = LEVELS[LEVELS.index(level) + 1..LEVELS.size]
  to_zero.each { |z| v[z] = 0 }

  v
end

def configure_changelog(config, release: nil)
  config.bug_labels         = 'Type: Bug'
  config.enhancement_labels = 'Type: Enhancement'
  config.since_tag          = 'v0.1.0'
  config.future_release     = "v#{release}" if release
end
