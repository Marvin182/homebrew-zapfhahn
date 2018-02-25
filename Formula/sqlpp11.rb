
class Sqlpp11 < Formula
  desc "A type safe SQL template library for C++"
  homepage "https://github.com/rbock/sqlpp11"

  stable do
    url "https://github.com/rbock/sqlpp11/archive/0.54.tar.gz"
    sha256 "107e2e8ae6c37ba8db2aa1c290708ac6b651f9597c5619af6e2b84bbc5ab74e1"

    resource "connector-mysql" do
      url "https://github.com/rbock/sqlpp11-connector-mysql/archive/0.23.tar.gz"
      sha256 "4fa2d32dc22e40585c14434fa600e0dcad61740d54ab749afaeab5cd6c926e59"
    end
    resource "connector-sqlite3" do
      url "https://github.com/rbock/sqlpp11-connector-sqlite3/archive/0.28.tar.gz"
      sha256 "a51845b2990bddb72e091140c8dd05204661ff8d94cf189041a1c3c63bfd96cb"
    end
  end

  head do
    url "https://github.com/rbock/sqlpp11.igt"

    resource "connector-mysql" do
      url "https://github.com/rbock/sqlpp11-connector-mysql.git"
    end
    resource "connector-sqlite3" do
      url "https://github.com/agda/agda-connector-sqlite3.git"
    end
  end

  option "with-mysql", "Build with the connector for mysql"
  option "with-sqlite3", "Build with the connector for sqlite3"

  depends_on "date"
  depends_on "cmake" => :build
  depends_on "mysql" => :build if build.with? "mysql"
  depends_on "boost" => :build if build.with? "mysql"

  def install
    # install core library
    mkdir "build" do
      args = std_cmake_args
      system "cmake", "..", *args
      system "make", "install"
    end

    if build.with? "mysql"
      resource("connector-mysql").stage do
        args = std_cmake_args
        args << "-DDATE_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include/date"
        args << "-DSQLPP11_INCLUDE_DIR=" + include

        mkdir "build" do
          system "cmake", "..", *args
          system "make", "install"
        end
      end
    end

    if build.with? "sqlite3"
      resource("connector-sqlite3").stage do
        args = std_cmake_args
        args << "-DSQLPP11_INCLUDE_DIR=" + include

        mkdir "build" do
          system "cmake", "..", *args
          system "make", "install"
        end
      end
    end

  end
end
