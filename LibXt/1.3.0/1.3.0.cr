class Target < ISM::Software
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr                          \
                                    --sysconfdir=/etc                       \
                                    --localstatedir=/var                    \
                                    --disable-static                        \
                                    --docdir=/usr/share/doc/#{versionName}  \
                                    --with-appdefaultdir=/etc/X11/app-defaults",
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
