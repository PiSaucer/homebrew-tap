cask "toolbox-desktop" do
  version "1.0.0"
  sha256 "2b551978b34ca0bc920003ff865ee3ea91b0a708447c55d3340bbfbcbe4688f4"

  url "https://github.com/PiSaucer/toolbox-desktop/releases/download/v#{version}/toolbox-desktop-#{version}-macos.dmg"
  name "Toolbox Desktop"
  desc "Browse, download, verify, and run PiSaucer toolbox utility scripts"
  homepage "https://github.com/PiSaucer/toolbox"

  livecheck do
    url "https://github.com/PiSaucer/toolbox-desktop"
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "toolbox desktop.app"

  binary "#{appdir}/toolbox desktop.app/Contents/MacOS/toolbox",
         target: "toolbox"

  zap trash: [
    "~/Library/Application Support/toolbox",
    "~/Library/Preferences/com.pisaucer.toolbox.desktop.plist",
    "~/Library/Saved Application State/com.pisaucer.toolbox.desktop.savedState",
  ]
end
