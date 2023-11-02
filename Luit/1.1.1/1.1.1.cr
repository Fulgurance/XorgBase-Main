class Target < ISM::Software

    def prepare
        super

        fileReplaceText("#{buildDirectoryPath(false)}configure","OS_CFLAGS=\"-D_XOPEN_SOURCE=500\"","OS_CFLAGS=\"-D_XOPEN_SOURCE=600\"")
    end
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--localstatedir=/var"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
