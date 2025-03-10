class Target < ISM::SemiVirtualSoftware

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

end
