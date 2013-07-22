require 'formula'

class TuioCpp < Formula
  homepage 'http://reactivision.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/reactivision/TUIO%201.0/TUIO-Clients%201.4/TUIO_CPP-1.4.zip'
  sha1 'ba62b789b212031b2580c95b8db8392ee7a0e269'

  depends_on 'sdl'

  def install
    system "make shared"
    (include+"osc").install Dir["oscpack/osc/*.h"]
    (include+"ip").install Dir["oscpack/ip/*.h"]
    (include).install Dir["TUIO/*.h"]
    lib.install ["libTUIO.dylib"]
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test TUIO_CPP`.
    system "false"
  end
end
