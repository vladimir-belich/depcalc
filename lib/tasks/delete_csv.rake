# frozen_string_literal: true

desc 'This task deletes CSV files'
task :delete_csv do
  Dir.glob('tmp/*.csv').each { |csv| File.delete(csv) if (Time.now - File.atime(csv)).to_i / 86_400 > 0 }
end
