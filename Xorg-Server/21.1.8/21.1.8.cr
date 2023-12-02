class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        runMesonCommand(["setup",@buildDirectoryNames[:mainBuild]],mainWorkDirectoryPath)
    end

    def configure
        super

        runMesonCommand([   "configure",
                            @buildDirectoryNames[:mainBuild],
                            "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--localstatedir=/var",
                            "--disable-static",
                            "-Dsuid_wrapper=true",
                            "-Dglamor=true",
                            "-Dxkb_output_dir=/var/lib/xkb"],
                            mainWorkDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/X11/xorg.conf.d")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig")

        if File.exists?("#{Ism.settings.rootPath}etc/sysconfig/createfiles")
            copyFile("#{Ism.settings.rootPath}etc/sysconfig/createfiles","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig/createfiles")
        else
            generateEmptyFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig/createfiles")
        end

        createFilesData = <<-CODE
        /tmp/.ICE-unix dir 1777 root root
        /tmp/.X11-unix dir 1777 root root
        CODE
        fileUpdateContent("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/sysconfig/createfiles",createFilesData)
    end

end
