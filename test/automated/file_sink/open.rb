require_relative '../automated_init'

context "File Sink" do
  context "Open" do
    path = Controls::Path::Temporary.random(basename: 'file-sink-open-test')

    open_file = false
    path_corresponds = false

    file_sink = Telemetry::Sink::File.open(path) do |file_sink, file|
      open_file = file_sink.io == file && file.is_a?(File)
      path_corresponds = file.path == path
    end

    test "Opens file at path" do
      assert(open_file && path_corresponds)
    end

    test "Closes the file" do
      assert(file_sink.io.closed?)
    end

  ensure
    File.unlink(path) if File.exist?(path)
  end
end
