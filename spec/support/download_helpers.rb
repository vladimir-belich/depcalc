module DownloadHelpers
  extend self

  def download_path
    File.expand_path '../../../tmp/downloads', __FILE__
  end

  def csv_path
    File.expand_path '../../../tmp/*.csv', __FILE__
  end

  def clear_downloads
  	FileUtils.rm_f(download_path + '/output.csv')
  	Dir[csv_path].each { |f| FileUtils.rm_f(f)}
  end

  def wait_for_download
    Timeout.timeout(1) do
      sleep 0.1 until Dir.entries(download_path).include?("output.csv")
    end
  end
end