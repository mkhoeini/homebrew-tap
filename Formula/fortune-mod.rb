class FortuneMod < Formula
  desc "Implementation of the Unix fortune command for displaying a random quotation"
  homepage "https://www.shlomifish.org/open-source/projects/fortune-mod/"
  url "https://github.com/shlomif/fortune-mod/releases/download/fortune-mod-3.6.1/fortune-mod-3.6.1.tar.xz"
  sha256 "b7e12ef9399d83ae4f9967ec6ef00b0ccaa9cc3b051348fc38cd40d893eb87b3"
  license "NOASSERTION"

  conflicts_with "fortune"

  depends_on "cmake" => :build
  depends_on "recode" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    cp "#{prefix}/games/fortune", bin
    ln_s Dir.glob("#{prefix}/local/share/*"), share
  end

  test do
    system "#{bin}/fortune"
  end
end
