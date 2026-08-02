class Toolbox < Formula
  desc "Interactive launcher and downloader for PiSaucer toolbox of utility scripts"
  homepage "https://github.com/PiSaucer/toolbox"
  url "https://github.com/PiSaucer/toolbox/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "b84cafb307b5ad2f01a7a82b5714e59382580cccf099cfa0ea51500881811b14"
  license "MIT"
  head "https://github.com/PiSaucer/toolbox.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

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

  def caveats
    <<~EOS
      Run the interactive launcher with:
        toolbox

      Download scripts directly with:
        toolbox SCRIPT_ID
    EOS
  end

  test do
    assert_match "toolbox #{version}", shell_output("#{bin}/toolbox --version")
  end
end
