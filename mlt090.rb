require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Mlt090 < Formula
  homepage "http://www.mltframework.org/"
  url "https://downloads.sourceforge.net/mlt/mlt/mlt-0.9.0.tar.gz"
  version "0.9.0"
  sha1 "76bf18f4442801fae963c5a676d6626e383d1617"

  depends_on "pkg-config" => :build

  depends_on "atk"
  depends_on "ffmpeg124"
  depends_on "frei0r"
  depends_on "libdv"
  depends_on "libsamplerate"
  depends_on "libvorbis"
  depends_on "sdl"
  depends_on "sox"

  depends_on "gtk+" => :optional

  if build.with? "gtk"
    depends_on "pango"
    depends_on "gdk-pixbuf"
  end

  def install

    args = ["--prefix=#{prefix}",
            "--disable-jackrack",
            "--disable-swfdec"]

    args << "--disable-gtk" if build.without? "gtk"

    system "./configure", *args

    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/melt --version"
    system "#{bin}/melt color:black out=50 -consumer avformat:tmp.mkv vcodec=yuv4"
  end
end
