require "formula"

class Hearse < Formula
  homepage "http://www.argon.org/~roderick/hearse/"
  url "http://www.argon.org/~roderick/hearse/dist/hearse-1.5.tar.gz"
  sha1 "bc1ea58589067107fe82f9c3143e655418f27b78"

  resource 'Digest::MD5' do
    url 'http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/Digest-MD5-2.53.tar.gz'
    sha1 '949487c6ecaa218bd0b7e617a4a087fde4d85bfb'
  end

  resource 'LWP::UserAgent' do
    url 'http://search.cpan.org/CPAN/authors/id/M/MS/MSCHILLI/libwww-perl-6.08.tar.gz'
    sha1 '400977d632eaf6e9dc3fb517114995d93cb3f6d2'
  end

  resource 'HTTP::Request' do
    url 'http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTTP-Message-6.06.tar.gz'
    sha1 '4a88688c28e6581fab9b2eca8d0e320e96bef1ad'
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec+"lib/perl5"

    resource('Digest::MD5').stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource('LWP::UserAgent').stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource('HTTP::Request').stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    system "perl", "Makefile.PL", "PREFIX=#{prefix}"
    system "make", "install"
    bin.env_script_all_files(libexec+"bin", :PERL5LIB => ENV["PERL5LIB"])
  end

  test do
    system "#{bin}/hearse", "--help"
  end
end
