class File

  #read last n lines of a file. useful for getting last part of a big log file.
  def tail(n)
    buffer = 1024
    chunks = []
    lines = 0

    if size>buffer
      idx = size - buffer
    else
      idx = 0
      buffer = size
    end

    begin
      seek(idx)
      chunk = read(buffer)
      if chunk
        lines += chunk.count("\n")
        chunks.unshift chunk
      end
      idx -= buffer
    end while lines < ( n + 1 ) && pos!=0 && idx>=0

    chunks.join('').split(/\n/).reverse.take(n)
  end
end