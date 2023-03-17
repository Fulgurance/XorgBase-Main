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

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/X11/xorg.conf.d")
        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/sysconfig")

        createFilesData = <<-CODE
        /tmp/.ICE-unix dir 1777 root root
        /tmp/.X11-unix dir 1777 root root
        CODE
        fileAppendData("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/sysconfig/createfiles",createFilesData)
    end

end
