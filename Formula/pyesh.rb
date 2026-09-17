class Pyesh < Formula
  include Language::Python::Virtualenv

  desc "Cross-platform, Python-oriented interactive and scripting shell"
  homepage "https://github.com/PiSaucer/pyesh"
  url "https://github.com/PiSaucer/pyesh/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b4d5acdd993057271e2829bf89f40f6e5fca462753f09a4fbd1c54eb6761dafd"
  license "MIT"
  head "https://github.com/PiSaucer/pyesh.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Use Homebrew-managed Python instead of relying on the user's system Python.
  depends_on "python"

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/a1/96/06e01a7b38dce6fe1db213e061a4602dd6032a8a97ef6c1a862537732421/prompt_toolkit-3.0.52.tar.gz"
    sha256 "28cde192929c8e7321de85de1ddbe736f1375148b02f2e17edd840042b1be855"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/fb/d2/8920e102050a0de7bfabeb4c4614a49248cf8d5d7a8d01885fbb24dc767a/rich-14.2.0.tar.gz"
    sha256 "73ff50c7c0c1c77c8243079283f4edb376f0f6442433aecb8ce7e6d0b92d1fe4"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/36/57/ed58088fafdf4c55a0ad6bde846502567645424d7ebf325230b9237f4085/wcwidth-0.8.3.tar.gz"
    sha256 "d128512515fbf4612e0ff21fd6380399210318b7b54a9af59dff8454cf9730eb"
  end

  def install
    # Install the vendored resources into an isolated environment, then install
    # pyesh from pyproject.toml. Its [project.scripts] entry creates the
    # `pyesh` executable and links it into Homebrew's bin directory.
    virtualenv_install_with_resources
  end

  test do
    assert_match "pyesh #{version}", shell_output("#{bin}/pyesh --version")
    assert_equal "homebrew\n", shell_output("#{bin}/pyesh --no-startup -c 'echo homebrew'")
  end
end
