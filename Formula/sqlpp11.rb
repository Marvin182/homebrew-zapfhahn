
class Sqlpp11 < Formula
  desc "A type safe SQL template library for C++"
  homepage "https://github.com/rbock/sqlpp11"

  stable do
    url "https://github.com/rbock/sqlpp11/archive/0.43.tar.gz"
    sha256 "473cb35c47ea2960c224fe49173581d243eb8b25ab0fcff85ef540e6df7e8abc"

    resource "connector-sqlite3" do
      url "https://github.com/rbock/sqlpp11-connector-sqlite3/archive/0.23.tar.gz"
      sha256 "4e00bdd5c873895d58346b3a503cc5b2222c3f918d45afe8e22be6ad997c3461"
    end
  end

  head do
    url "https://github.com/rbock/sqlpp11.igt"

    resource "connector-sqlite3" do
      url "https://github.com/agda/agda-connector-sqlite3.git"
    end
  end

  option "with-sqite3", "Build with the connector for sqlite3"

  depends_on "date"
  depends_on "cmake" => :build

  def install
    # install core library
    mkdir "build" do
      args = std_cmake_args
      args << "-DHinnantDate_ROOT_DIR=#{HOMEBREW_PREFIX}/include/date"
      system "cmake", "..", *args
      system "make", "install"
    end

    # install sqlite connector
    if build.with? "sqlite3"
      resource("connector-sqlite3").stage do
        args = std_cmake_args
        args << "-DDATE_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include/date"
        args << "-DSQLPP11_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include"

        puts include
        puts bin
        mkdir "build" do
          system "cmake", "..", *args
          system "make", "install"
        end
      end
    end
  end
end
