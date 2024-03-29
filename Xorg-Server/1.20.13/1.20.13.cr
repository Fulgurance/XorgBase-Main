class Target < ISM::Software

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--localstatedir=/var",
                            "--disable-static",
                            "--enable-glamor",
                            "--enable-suid-wrapper",
                            "--with-xkb-output=/var/lib/xkb"],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/X11/xorg.conf.d")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig")

        if File.exists?("#{Ism.settings.rootPath}etc/sysconfig/createfiles")
            copyFile("#{Ism.settings.rootPath}etc/sysconfig/createfiles","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig/createfiles")
        else
            generateEmptyFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig/createfiles")
        end

        createFilesData = <<-CODE
        /tmp/.ICE-unix dir 1777 root root
        /tmp/.X11-unix dir 1777 root root
        CODE
        fileUpdateContent("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig/createfiles",createFilesData)
    end

end
