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
        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/fonts")
    end

    def install
        setPermissions("#{Ism.settings.rootPath}usr/share/fonts",0o755)
        makeLink("/usr/share/fonts/X11/OTF","#{Ism.settings.rootPath}usr/share/fonts/X11-OTF",:symbolicLinkByOverwrite)
        makeLink("/usr/share/fonts/X11/TTF","#{Ism.settings.rootPath}usr/share/fonts/X11-TTF",:symbolicLinkByOverwrite)
    end

    def clean
    end

end
