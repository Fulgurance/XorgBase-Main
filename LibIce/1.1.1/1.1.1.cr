class Target < ISM::Software
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr                          \
                                    --sysconfdir=/etc                       \
                                    --localstatedir=/var                    \
                                    --disable-static                        \
                                    --docdir=/usr/share/doc/libICE-1.1.1    \
                                    ICE_LIBS=-lpthread",
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

    def install
        super

        runLdconfigCommand
    end

end
