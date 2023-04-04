class Target < ISM::Software

    def prepare
        super

        fileReplaceText("#{buildDirectoryPath(false)}configure","OS_CFLAGS=\"-D_XOPEN_SOURCE=500\"","OS_CFLAGS=\"-D_XOPEN_SOURCE=600\"")
    end
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--localstatedir=/var",
                            "--disable-static"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
