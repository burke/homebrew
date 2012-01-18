require 'formula'

class Openssl < Formula
  url 'http://www.openssl.org/source/openssl-1.0.1-beta1.tar.gz'
  version '1.0.1-beta1'
  homepage 'http://www.openssl.org'
  sha1 'a97fd63356a787e9ddc9f157ce4b964459a41f40'

  keg_only :provided_by_osx,
    "The OpenSSL provided by Leopard (0.9.7) is too old for some software."

  def install
    system "./config", "--prefix=#{prefix}",
                       "--openssldir=#{etc}/openssl",
                       "zlib-dynamic", "shared"

    ENV.deparallelize # Parallel compilation fails
    system "make"
    system "make test"
    system "make install MANDIR=#{man} MANSUFFIX=ssl"
  end

  def caveats; <<-EOS.undent
    Note that the libraries built tend to be 32-bit only, even on Snow Leopard.
    EOS
  end
end
