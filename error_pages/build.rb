require 'erb'
require 'yaml'
require 'ostruct'
require 'fileutils'
require 'pathname'

ROOT_DIR = Pathname.new(__FILE__).dirname.expand_path
OUTPUT_DIR = ROOT_DIR.join('html')

template = ERB.new(ROOT_DIR.join('template.html.erb').read)

FileUtils.rm_rf OUTPUT_DIR
FileUtils.mkdir_p OUTPUT_DIR

YAML.load_file(ROOT_DIR.join('errors.yml')).each do |code, info|
  # See https://stackoverflow.com/a/9734736/224736
  content = template.result(OpenStruct.new(code: code, title: info['title'], description: info['description']).instance_eval { binding })

  File.open OUTPUT_DIR.join("#{code}.html"), 'w+' do |file|
    file.puts content
  end
end