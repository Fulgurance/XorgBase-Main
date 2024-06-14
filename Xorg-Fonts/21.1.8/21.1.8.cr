class Target < ISM::Software

    def download
    end

    def check
    end

    def extract
    end

    def patch
    end

    def prepare
    end

    def configure
    end

    def build
    end

    def prepareInstallation

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/fonts")
    end

    def install

        runChmodCommand("0755 /usr/share/fonts")

        makeLink(   target: "/usr/share/fonts/X11/OTF",
                    path:   "#{Ism.settings.rootPath}usr/share/fonts/X11-OTF",
                    type:   :symbolicLinkByOverwrite)

        makeLink(   target: "/usr/share/fonts/X11/TTF",
                    path:   "#{Ism.settings.rootPath}usr/share/fonts/X11-TTF",
                    type:   :symbolicLinkByOverwrite)

        Ism.addInstalledSoftware(@information)
    end

    def clean
    end

end
