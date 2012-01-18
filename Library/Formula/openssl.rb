require 'formula'

class Openssl < Formula
  url 'http://www.openssl.org/source/openssl-1.0.1-beta1.tar.gz'
  version '1.0.1-beta1'
  homepage 'http://www.openssl.org'
  sha1 'a97fd63356a787e9ddc9f157ce4b964459a41f40'

  keg_only :provided_by_osx,
    "The OpenSSL provided by Lion (0.9.8) is too old for some software."

  def install
    # I don't understand why this works and other things don't, but I'm done debugging this. it's ugly, but it works.
    `cd #{Dir.pwd} ; ./Configure darwin64-x86_64-cc --prefix=#{prefix} --openssldir=#{prefix}/etc/openssl zlib-dynamic shared`

    ENV.deparallelize # Parallel compilation fails
    system "make"
    system "make test"
    system "make install MANDIR=#{man} MANSUFFIX=ssl"
    system "curl http://curl.haxx.se/ca/cacert.pem > /usr/local/Cellar/openssl/1.0.1-beta1/etc/openssl/cert.pem"
  end

end
