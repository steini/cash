namespace "db" do
  desc "create a backup of the database"
  task :backup => :environment do
    db_config = ActiveRecord::Base.configurations[RAILS_ENV]

    base_path = ENV["DIR"] || "/tmp"
    backup_base = File.join(base_path, 'backup')
    backup_file = File.join(backup_base, archive_name('db'))

    command = "mysqldump -u #{db_config['username']} "
    command += "-p#{db_config['password']} " unless db_config['password'].nil?
    command += "--opt --skip-add-locks "
    command += "#{db_config['database']} | gzip -c > #{backup_file}"

    sh(command)
    
    puts "created archive #{backup_file}"

    dir = Dir.new(backup_base)
    all_backups = dir.entries.sort.reverse.delete_if { |x| ! (x =~ /gz$/) }

    max_backups = ENV["MAX"] || 15

    unwanted_backups = all_backups[max_backups.to_i..-1] || []

    for unwanted_backup in unwanted_backups
      FileUtils.rm_rf(File.join(backup_base, unwanted_backup))
      puts "deleted #{unwanted_backup}"
    end
    puts "Deleted #{unwanted_backups.length} backups, #{all_backups.length - unwanted_backups.length} backups available"
  end

end

def archive_name(name)
  @timestamp ||= Time.now.utc.strftime("%Y%m%d%H%M%S")
  "#{RAILS_ENV}.#{@timestamp}.gz"
end