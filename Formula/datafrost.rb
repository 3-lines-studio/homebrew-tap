class Datafrost < Formula
  desc "Database management GUI application"
  homepage "https://github.com/3-lines-studio/datafrost"
  version "0.0.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/3-lines-studio/datafrost/releases/download/v0.0.3/datafrost-macos-arm64-v0.0.3.tar.gz"
      sha256 "738fc12ea30be371a9cd819fbf9c95dc1e4f12793dc31ad733771c1ce96f329f"
    else
      odie "Intel Macs are not supported. Use --HEAD to build from source, or install on Apple Silicon."
    end
  end

  on_linux do
    url "https://github.com/3-lines-studio/datafrost/releases/download/v0.0.3/datafrost-linux-v0.0.3.tar.gz"
    sha256 "94fe99328cb72966701e40bb9fa5bd40c7c6c742aea8e5b482982da252b02853"
  end

  depends_on :macos => :big_sur

  def install
    bin.install "datafrost"

    if OS.linux?
      pkgshare.mkpath
      pkgshare.install "icon.png"

      desktop_entry = <<~EOS
        [Desktop Entry]
        Name=Datafrost
        Comment=Database management GUI
        Exec=#{bin}/datafrost
        Icon=#{pkgshare}/icon.png
        Type=Application
        Categories=Development;Database;
        Terminal=false
      EOS

      (share/"applications").mkpath
      (share/"applications/datafrost.desktop").write desktop_entry
    end
  end

  def post_install
    if OS.linux?
      # Create symlink in user's applications directory
      user_apps = Pathname.new(Dir.home)/".local/share/applications"
      user_apps.mkpath

      desktop_file = share/"applications/datafrost.desktop"
      if desktop_file.exist?
        FileUtils.ln_sf desktop_file.to_s, (user_apps/"datafrost.desktop").to_s
        ohai "Desktop entry created at: ~/.local/share/applications/datafrost.desktop"
      end
    end
  end

  def caveats
    <<~EOS
      Datafrost has been installed!

      Run with: datafrost

      macOS Users:
        This app is unsigned. On first run, you may need to:
        1. Try to run: datafrost
        2. If blocked, go to System Preferences > Security & Privacy
        3. Click "Open Anyway"

      Linux Users:
        Desktop entry created at: ~/.local/share/applications/datafrost.desktop

        Dependencies (install via your package manager):
          - libwebkit2gtk-4.0
          - libgtk-3-0

        Examples:
          Ubuntu/Debian: sudo apt-get install libwebkit2gtk-4.0-37 libgtk-3-0
          Fedora:        sudo dnf install webkit2gtk3 gtk3
          Arch:          sudo pacman -S webkit2gtk gtk3
    EOS
  end

  test do
    assert_match "Datafrost", shell_output("#{bin}/datafrost --version")
  end
end
