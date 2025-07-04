require_relative '../automated_init'

context "File Sink" do
  context "Open" do
    file_path = Controls::Path::File.example(basename: 'file-sink-open-test')

    open_file = false
    path_corresponds = false

    file_sink = Telemetry::Sink::File.open(file_path) do |file_sink, file|
      open_file = file_sink.file == file && file.is_a?(File)
      path_corresponds = file.path == file_path
    end

    test "Opens file at path" do
      assert(open_file && path_corresponds)
    end

    test "Closes the file" do
      assert(file_sink.file.closed?)
    end

  ensure
    File.unlink(file_path) if file_path && File.exist?(file_path)
  end
end
