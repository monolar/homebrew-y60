require 'formula'

class TuioCpp < Formula
  homepage 'http://reactivision.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/reactivision/TUIO%201.0/TUIO-Clients%201.4/TUIO_CPP-1.4.zip'
  sha256 '9fa79a6e7ef7893295c669befbc8f19f13c3e40ee2b98bb75075579cab65edd2'

  depends_on 'sdl'

  def install
    system 'make shared'
    (include + 'osc').install Dir['oscpack/osc/*.h']
    (include + 'ip').install Dir['oscpack/ip/*.h']
    (include).install Dir['TUIO/*.h']
    lib.install ['libTUIO.dylib']
  end

  def patches
    # DATA is the embedded diff that comes after __END__ in this file!
    # Patch adds unistd.h necessary for Mac OSX Mavericks
    DATA
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test TUIO_CPP`.
    system 'false'
  end
end

__END__
diff --git a/TUIO/TuioServer.h b/TUIO/TuioServer.h
index 325e15f..da9f249 100644
--- a/TUIO/TuioServer.h
+++ b/TUIO/TuioServer.h
@@ -25,6 +25,7 @@
 #ifndef WIN32
 #include <pthread.h>
 #include <sys/time.h>
+#include <unistd.h>
 #else
 #include <windows.h>
 #endif
