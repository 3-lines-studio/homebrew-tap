class Datafrost < Formula
  desc "Database management GUI application"
  homepage "https://github.com/3-lines-studio/datafrost"
  version "0.0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/3-lines-studio/datafrost/releases/download/v0.0.2/datafrost-macos-arm64-v0.0.2.tar.gz"
      sha256 "4a3983c221c096da0f1eafa7518895b92e0022dec1dd51cb61b25ce4ffb194ec"
    else
      odie "Intel Macs are not supported. Use --HEAD to build from source, or install on Apple Silicon."
    end
  end

  on_linux do
    url "https://github.com/3-lines-studio/datafrost/releases/download/v0.0.2/datafrost-linux-v0.0.2.tar.gz"
    sha256 "b640dcd76a1869df8864cd51ab10e35002f0e32d874bddd36b0e89fbf2fb3c9b"
  end

  depends_on :macos => :big_sur
  depends_on "gtk+3" if OS.linux?
  depends_on "webkitgtk" if OS.linux?

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

      #{OS.macos? ? mac_caveats : linux_caveats}
    EOS
  end

  def mac_caveats
    <<~EOS
      macOS Security Note:
        This app is unsigned. On first run, you may need to:
        1. Try to run: datafrost
        2. If blocked, go to: System Preferences > Security & Privacy
        3. Click "Open Anyway"
    EOS
  end

  def linux_caveats
    <<~EOS
      Linux Desktop Integration:
        A desktop entry has been created at:
          ~/.local/share/applications/datafrost.desktop

        To refresh your application menu:
          update-desktop-database ~/.local/share/applications/

      Dependencies:
        The following packages should be installed (via your package manager):
          - libwebkit2gtk-4.0
          - libgtk-3-0

        On Ubuntu/Debian:
          sudo apt-get install libwebkit2gtk-4.0-37 libgtk-3-0

        On Fedora:
          sudo dnf install webkit2gtk3 gtk3

        On Arch:
          sudo pacman -S webkit2gtk gtk3
    EOS
  end

  test do
    assert_match "Datafrost", shell_output("#{bin}/datafrost --version")
  end
end
