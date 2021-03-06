require 'formula'

class Watchdog < Formula
  homepage 'https://github.com/artcom/watchdog'

  git_url = if build.include? 'use-internal-git'
              'git://gitorious.intern.artcom.de/pro/watchdog.git'
            else
              'https://github.com/artcom/watchdog.git'
            end

  url git_url, :tag => '1.0.9'
  head git_url, :branch => 'master'

  depends_on 'cmake' => :build
  depends_on 'acmake' => :build
  depends_on 'asl' => :build
  depends_on 'glib' => :build

  def install
    system 'cmake', '.', *std_cmake_args
    system 'make'
    system 'make test' if build.include? 'enable-tests'
    system 'make install'

    # workaround for #https://github.com/artcom/homebrew-y60/issues/3
    acmake_dir = include + "acmake"
    puts acmake_dir.children.each do |file|
      file.delete
    end
    acmake_dir.rmdir_if_possible
  end

  def test
    system 'make test'
  end
end
