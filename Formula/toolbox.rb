class Toolbox < Formula
  desc "Interactive launcher and downloader for PiSaucer toolbox of utility scripts"
  homepage "https://github.com/PiSaucer/toolbox"
  url "https://github.com/PiSaucer/toolbox/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "7cf3033dbb28de127fe2747518548c6961cee5b428dd40c7be26b2bde4f78ec1"
  license "MIT"

  depends_on "python"

  def install
    bin.install "toolbox.py" => "toolbox"

    # Ensure the command uses Homebrew's supported Python rather than an
    # unrelated python3 found in the user's PATH.
    inreplace bin/"toolbox",
              "#!/usr/bin/env python3",
              "#!#{Formula["python"].opt_bin}/python3"

    zsh_completion.install "completions/_toolbox"
    bash_completion.install "completions/toolbox.bash"
  end

  test do
    assert_match "toolbox #{version}", shell_output("#{bin}/toolbox --version")
  end
end
