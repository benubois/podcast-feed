class Episode
  def initialize(file)
    @file = file
  end

  def name
    Pathname.new(@file).basename.sub('.mp3', '').to_s
  end

  def url
    @file.sub('./public/', '')
  end

  def date
    Time.parse(name).rfc2822
  end

  def length
    File.size(@file)
  end
end
