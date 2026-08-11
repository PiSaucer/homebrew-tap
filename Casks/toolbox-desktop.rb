cask "toolbox-desktop" do
  version "1.0.4"
  sha256 "d9d87c0498e752c8f64cbff6f3843cebb334c626205fcaa18e294e95c16e0ad2"

  url "https://github.com/PiSaucer/toolbox-desktop/releases/download/v#{version}/toolbox-desktop-#{version}-macos.dmg"
  name "Toolbox Desktop"
  desc "Browse, download, verify, and run PiSaucer toolbox utility scripts"
  homepage "https://github.com/PiSaucer/toolbox"

  livecheck do
    url "https://github.com/PiSaucer/toolbox-desktop"
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "toolbox desktop.app"

  zap trash: [
    "~/Library/Application Support/toolbox",
    "~/Library/Preferences/com.pisaucer.toolbox.desktop.plist",
    "~/Library/Saved Application State/com.pisaucer.toolbox.desktop.savedState",
  ]
end
