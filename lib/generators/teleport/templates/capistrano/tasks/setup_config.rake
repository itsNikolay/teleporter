namespace :deploy do
  task :setup_config do
    on roles(:app) do
      set(:config_files, [
        "log_rotation",
        "monit_sidekiq",
        "sidekiq_init.sh"
      ])
      set(:executable_config_files, [
        "sidekiq_init.sh",
      ])
      set(:symlinks, [
        {
          source: "log_rotation",
          link: "/etc/logrotate.d/{{application}}_{{stage}}"
        },
        {
          source: "monit_sidekiq",
          link: "/etc/monit/conf.d/sidekiq_{{application}}_{{stage}}.conf"
        },
        {
          source: "sidekiq_init.sh",
          link: "/etc/init.d/sidekiq_{{application}}_{{stage}}"
        },
      ])
      execute :mkdir, "-p #{shared_path}/config"
      execute :mkdir, "-p #{current_path}"
      application = fetch(:application)
      stage = fetch(:stage)

      config_files = fetch(:config_files)
      config_files.each do |file|
        smart_template file
      end

      executable_files = fetch(:executable_config_files)
      executable_files.each do |file|
        execute :chmod, "+x #{shared_path}/config/#{file}"
      end

      symlinks = fetch(:symlinks)

      symlinks.each do |symlink|
        sudo "ln -nfs #{shared_path}/config/#{symlink[:source]} #{sub_strings(symlink[:link])}"
      end
    end
  end
end


def smart_template(from, to=nil)
  to ||= from
  full_to_path = "#{shared_path}/config/#{to}"
  if from_erb_path = template_file(from)
    from_erb = StringIO.new(ERB.new(File.read(from_erb_path)).result(binding))
    upload! from_erb, full_to_path
    info "copying: #{from_erb} to: #{full_to_path}"
  else
    error "error #{from} not found"
  end
end

def template_file(name)
  if File.exist?((file = "config/deploy/#{fetch(:application)}/#{name}.erb"))
    return file
  elsif File.exist?((file = "config/deploy/shared/#{name}.erb"))
    return file
  end
  return nil
end

def sub_strings(input_string)
  output_string = input_string
  input_string.scan(/{{(\w*)}}/).each do |var|
    output_string.gsub!("{{#{var[0]}}}", fetch(var[0].to_sym))
  end
  output_string
end
