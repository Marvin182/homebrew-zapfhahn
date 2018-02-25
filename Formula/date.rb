class Date < Formula
  desc "A date and time library based on the C++11 <chrono> header"
  homepage "https://github.com/HowardHinnant/date"
  
  stable do
    url "https://github.com/HowardHinnant/date/archive/v2.4.tar.gz"
    sha256 "549c3120fe8eaaab7f28946e2430fb0d3d4b40b843a5ea52b78dba49795c7e05"
  end

  head do
    url "https://github.com/HowardHinnant/date.git"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
