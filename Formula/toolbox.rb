class Toolbox < Formula
  include Language::Python::Virtualenv

  desc "Interactive launcher and downloader for PiSaucer toolbox of utility scripts"
  homepage "https://github.com/PiSaucer/toolbox"
  url "https://github.com/PiSaucer/toolbox/archive/refs/tags/v1.0.9.tar.gz"
  sha256 "4466611e1450599af9f5cb2b58d0ad3076127c453d05b8cd4040f8223cc1e2ce"
  license "MIT"
  head "https://github.com/PiSaucer/toolbox.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Use Homebrew-managed Python instead of relying on the user's system Python.
  depends_on "python"

  # Rich uses markdown-it-py to render Markdown content in the terminal.
  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  # markdown-it-py uses mdurl to parse and normalize URLs.
  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  # Rich uses Pygments for syntax highlighting.
  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  # Bundle Rich so installation does not download packages at install time.
  resource "rich" do
    url "https://files.pythonhosted.org/packages/fb/d2/8920e102050a0de7bfabeb4c4614a49248cf8d5d7a8d01885fbb24dc767a/rich-14.2.0.tar.gz"
    sha256 "73ff50c7c0c1c77c8243079283f4edb376f0f6442433aecb8ce7e6d0b92d1fe4"
  end

  def install
    # Install the vendored resources into an isolated environment, then install
    # Toolbox from pyproject.toml. Its [project.scripts] entry creates the
    # `toolbox` executable and links it into Homebrew's bin directory.
    virtualenv_install_with_resources

    # Install shell completions into Homebrew's standard locations.
    zsh_completion.install "completions/_toolbox"
    bash_completion.install "completions/toolbox.bash"
  end

  def caveats
    <<~EOS
      Run the interactive launcher with:
        toolbox

      Download scripts directly with:
        toolbox SCRIPT_ID
    EOS
  end

  test do
    # Starting the command also confirms that Rich can be imported.
    assert_match "toolbox #{version}", shell_output("#{bin}/toolbox --version")
  end
end
