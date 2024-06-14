class Target < ISM::Software

    def prepare
        super

        fileReplaceText(path:       "#{buildDirectoryPath}configure",
                        text:       "OS_CFLAGS=\"-D_XOPEN_SOURCE=500\"",
                        newText:    "OS_CFLAGS=\"-D_XOPEN_SOURCE=600\"")
    end
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --sysconfdir=/etc   \
                                    --localstatedir=/var",
                        path:       buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

end
