class Target < ISM::Software

    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/fonts")

        makeLink(   target: "/usr/share/fonts/X11/OTF",
                    path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/fonts/X11-OTF",
                    type:   :symbolicLinkByOverwrite)

        makeLink(   target: "/usr/share/fonts/X11/TTF",
                    path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/fonts/X11-TTF",
                    type:   :symbolicLinkByOverwrite)
    end

    def install
        super

        runChmodCommand("0755 /usr/share/fonts")
    end

end
