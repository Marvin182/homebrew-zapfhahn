class Date < Formula
  desc "A date and time library based on the C++11 <chrono> header"
  homepage "https://github.com/HowardHinnant/date"
  url "https://github.com/HowardHinnant/date/archive/v2.0.0.tar.gz"
  sha256 "dfd2a4a99d7567313fe7cf2ec40d3f09a54dcb74f65f33f5fce2a3855b7696dc"

  head do
      url "https://github.com/HowardHinnant/date.git"
  end

  def install
    mkdir "date" do
      cp %w(../chrono_io.h ../date.h ../islamic.h ../iso_week.h ../julian.h ../tz.h), "."
    end
    include.install "date"
  end
end
