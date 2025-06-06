class Keploy < Formula
  desc "Testing Toolkit creates test-cases and data mocks from API calls, DB queries"
  homepage "https://keploy.io"
  url "https://github.com/keploy/keploy/archive/refs/tags/v2.6.0.tar.gz"
  sha256 "ebdf03edd76e7f1b98f3f4cf4480dc692147bd2c027ca3e256d74f143551cc7a"
  license "Apache-2.0"
  head "https://github.com/keploy/keploy.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7c69bd233fb8792c2969b15c11c6c8ac7783316a77d9f3514b28acebd73a98ed"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7c69bd233fb8792c2969b15c11c6c8ac7783316a77d9f3514b28acebd73a98ed"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7c69bd233fb8792c2969b15c11c6c8ac7783316a77d9f3514b28acebd73a98ed"
    sha256 cellar: :any_skip_relocation, sonoma:        "16aad29af5bbf193a14df39c309ff3f44e44e5f90d5a7f9607c27ddff52801e9"
    sha256 cellar: :any_skip_relocation, ventura:       "16aad29af5bbf193a14df39c309ff3f44e44e5f90d5a7f9607c27ddff52801e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "55b4257f213bd0ad3693e077adc93af85d0c0c95db0cc0ee20ad689d01faeafb"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  test do
    system bin/"keploy", "config", "--generate", "--path", testpath
    assert_match "# Generated by Keploy", (testpath/"keploy.yml").read

    output = shell_output("#{bin}/keploy templatize --path #{testpath}")
    assert_match "No test sets found to templatize", output

    assert_match version.to_s, shell_output("#{bin}/keploy --version")
  end
end
